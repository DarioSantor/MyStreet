//
//  ConfirmationViewController.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 20/03/2023.
//

import UIKit

class ConfirmationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.tintColor = .label
        navigationItem.title = "Reportar ocorrência"
        
        let confirmationText = UILabel()
        confirmationText.translatesAutoresizingMaskIntoConstraints = false
        confirmationText.text = "A sua ocorrência foi submetida com êxito. vamos mantê-lo informado acerca da resolução desta situação. Obrigado pelo seu contributo."
        confirmationText.textAlignment = .center
        confirmationText.font = UIFont.systemFont(ofSize: 20.0)
        confirmationText.textColor = .label
        confirmationText.lineBreakMode = NSLineBreakMode.byWordWrapping
        confirmationText.numberOfLines = 0
        
        let action = UIAction() {_ in
            self.navigationController?.pushViewController(UserMenuViewController(), animated: true)
        }
        
        let mainMenuButton = UIButton(type: .system, primaryAction: action)
        mainMenuButton.translatesAutoresizingMaskIntoConstraints = false
        mainMenuButton.backgroundColor = .systemBlue
        mainMenuButton.setTitle("MENU PRINCIPAL", for: .normal)
        mainMenuButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        mainMenuButton.layer.cornerRadius = 8
        mainMenuButton.setTitleColor(UIColor.label, for: .normal)
        
        view.addSubview(confirmationText)
        view.addSubview(mainMenuButton)
        
        NSLayoutConstraint.activate([
            confirmationText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmationText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            confirmationText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmationText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mainMenuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            mainMenuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainMenuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainMenuButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
