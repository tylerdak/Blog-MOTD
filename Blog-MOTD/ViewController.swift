//
//  ViewController.swift
//  Blog-MOTD
//
//  Created by Tyler Dakin on 11/23/20.
//

import UIKit

class ViewController: UIViewController {

    var motd: String = "" {
        didSet {
            label.text = motd
        }
    }
    
    var label: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Pick a source!"
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        let jsonButton = UIButton()
        jsonButton.setTitle("JSON", for: .normal)
        
        let textButton = UIButton()
        textButton.setTitle("Text", for: .normal)
        
        let randomButton = UIButton()
        randomButton.setTitle("Random", for: .normal)
        
        [jsonButton,textButton, randomButton].forEach { button in
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.frame = CGRect(origin: view.center, size: CGSize(width: 200, height: 100))
            button.backgroundColor = .systemBlue
            button.tintColor = .label
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        }
        
        NSLayoutConstraint.activate([
            jsonButton.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            jsonButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            textButton.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            textButton.topAnchor.constraint(equalTo: jsonButton.bottomAnchor, constant: 10),
            randomButton.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            randomButton.topAnchor.constraint(equalTo: textButton.bottomAnchor, constant: 10),
            jsonButton.widthAnchor.constraint(equalTo: randomButton.widthAnchor),
            textButton.widthAnchor.constraint(equalTo: randomButton.widthAnchor)
        ])
    }
    
    @objc func buttonPressed(sender: UIButton) {
        switch sender.title(for: .normal) {
        case "JSON":
            retrieveMOTD()
        case "Text":
            retrieveMOTDasText()
        case "Random":
            getSplashText()
        default:
            motd = "Button not recognized."
        }
    }


}

