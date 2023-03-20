//
//  LocalizationAuthViewController.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 13/03/2023.
//

import UIKit

class LocalizationAuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        let authWarning = UILabel()
        authWarning.translatesAutoresizingMaskIntoConstraints = false
        authWarning.text = "Esta aplicação necessita de aceder à sua localização. Autorize, por favor, premindo o botão \"AUTORIZAR\"."
        authWarning.textAlignment = .center
        authWarning.font = UIFont.systemFont(ofSize: 20.0)
//        authWarning.textColor = UIColor(named: "myBlackColor")
        authWarning.textColor = .label
        authWarning.lineBreakMode = NSLineBreakMode.byWordWrapping
        authWarning.numberOfLines = 0
        
        let action = UIAction() {_ in
            userHasAuth = true
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        
        let localizationButton = UIButton(type: .system, primaryAction: action)
        localizationButton.translatesAutoresizingMaskIntoConstraints = false
        localizationButton.backgroundColor = .systemBlue
        localizationButton.setTitle("AUTORIZAR", for: .normal)
        localizationButton.layer.cornerRadius = 8
        localizationButton.setTitleColor(UIColor.white, for: .normal)
        
        view.addSubview(logo)
        view.addSubview(authWarning)
        view.addSubview(localizationButton)
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 160),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 250),
            logo.heightAnchor.constraint(equalToConstant: 250),
            
            authWarning.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 8),
            authWarning.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authWarning.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            authWarning.heightAnchor.constraint(equalToConstant: 200),
            
            localizationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            localizationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            localizationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            localizationButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }


}
