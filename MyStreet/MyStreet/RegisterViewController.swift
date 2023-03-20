//
//  RegisterViewController.swift
//  MyStreet
//
//  Created by Cerqueira, Fabio Galante on 18/03/2023.
//

import UIKit
///ghsdgahjdgagshj
class RegisterViewController: UIViewController {

    private let logo = UIImageView(image: UIImage(named: "logo"))
    private let firstNameRegisterField = CustomTextField(fieldType: .firstName)
    private let lastNameRegisterField = CustomTextField(fieldType: .lastName)
    private let emailRegisterField = CustomTextField(fieldType: .email)
    private let passwordRegisterField = CustomTextField(fieldType: .password)
    private let confirmPassRegisterField = CustomTextField(fieldType: .confirmPass)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // forma de dar cor diferente aos item do navigation bar
        navigationController?.navigationBar.tintColor = .label
        
        let action = UIAction() {_ in
            localizationAuthorization = true
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        let registerButton = UIButton(type: .system, primaryAction: action)
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitle("REGISTAR", for: .normal)
        registerButton.setTitleColor(UIColor.label, for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        registerButton.layer.cornerRadius = 8
        
        let items = [
            logo,
            firstNameRegisterField,
            lastNameRegisterField,
            emailRegisterField,
            passwordRegisterField,
            confirmPassRegisterField,
            registerButton
        ]
        
        for item in items {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
    
        NSLayoutConstraint.activate([
            
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 150),
            logo.heightAnchor.constraint(equalToConstant: 150),
            
            firstNameRegisterField.topAnchor.constraint(equalTo: logo.bottomAnchor,constant: 40),
            firstNameRegisterField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameRegisterField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstNameRegisterField.heightAnchor.constraint(equalToConstant: 40),

            lastNameRegisterField.topAnchor.constraint(equalTo: firstNameRegisterField.bottomAnchor,constant: 20),
            lastNameRegisterField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameRegisterField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lastNameRegisterField.heightAnchor.constraint(equalToConstant: 40),

            emailRegisterField.topAnchor.constraint(equalTo: lastNameRegisterField.bottomAnchor,constant: 20),
            emailRegisterField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailRegisterField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailRegisterField.heightAnchor.constraint(equalToConstant: 40),

            passwordRegisterField.topAnchor.constraint(equalTo: emailRegisterField.bottomAnchor,constant: 20),
            passwordRegisterField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordRegisterField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordRegisterField.heightAnchor.constraint(equalToConstant: 40),

            confirmPassRegisterField.topAnchor.constraint(equalTo: passwordRegisterField.bottomAnchor,constant: 20),
            confirmPassRegisterField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPassRegisterField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmPassRegisterField.heightAnchor.constraint(equalToConstant: 40),
            
            registerButton.topAnchor.constraint(equalTo: confirmPassRegisterField.bottomAnchor,constant: 60),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
        
        ])
    }
}
