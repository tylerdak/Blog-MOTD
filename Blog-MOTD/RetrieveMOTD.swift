//
//  RetrieveMOTD.swift
//  Blog-MOTD
//
//  Created by Tyler Dakin on 11/23/20.
//

import Foundation

struct Response: Codable {
    let motd: String
}

extension ViewController {
    func retrieveMOTD() {
        // Put your link in for the string, instead of my link!
        guard let url = URL(string: "https://site.tylerdakin.com/motd.json") else {
            // Visual feedback if something goes wrong
            motd = "URL not valid"
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data else {
                print("No data found.\nERROR: \(error?.localizedDescription ?? "Unknown Error")")
                return
            }
            
            if let response = try? JSONDecoder().decode(Response.self, from: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.motd = response.motd
                }
            }
            else {
                self?.motd = "ERROR: Could not decode into Response.self"
            }
        }.resume()
    }
    
    func retrieveMOTDasText() {
        // Put your link in for the string, instead of my link! Make sure it's the txt link!
        guard let url = URL(string: "https://site.tylerdakin.com/motd.txt") else {
            // Visual feedback if something goes wrong
            motd = "URL not valid"
            return
        }
        
        do {
            let message = try String(contentsOf: url)
            motd = message
        }
        catch {
            motd = "No message received."
            print("There was an error retrieving the message.")
        }
    }
    
    func getSplashText() {
        // Replace my link with your splash text link!
        let allMessages = retrieveTextFromURL("https://site.tylerdakin.com/splash.txt")
        // The split method gives us each line as its own Substring.
        let eachLine = allMessages.split(separator: "\n")
        // Grab a random item from the array, convert to String, and assign to motd.
        motd = String(eachLine.randomElement() ?? "No message was found.")
    }
}

// This function can be used outside of the extension because it doesn't assign to the motd variable!
// I'd recommend making an Xcode snippet out of it for future use!
func retrieveTextFromURL(_ urlString: String) -> String {
    // Put your link in for the string, instead of my link! Make sure it's the txt link!
    guard let url = URL(string: urlString) else {
        // Visual feedback if something goes wrong
        return "URL not valid"
    }
    
    do {
        let message = try String(contentsOf: url)
        return message
    }
    catch {
        print("There was an error retrieving the message.")
        return "No text received."
    }
}
