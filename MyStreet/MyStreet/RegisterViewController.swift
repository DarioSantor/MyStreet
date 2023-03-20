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
        
        let action = UIAction() {_ in
            userHasAuth = true
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        let registerButton = UIButton(type: .system, primaryAction: action)
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitle("REGISTAR", for: .normal)
        registerButton.setTitleColor(UIColor.black, for: .normal)
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
            
            firstNameRegisterField.widthAnchor.constraint(equalToConstant: 317),
            firstNameRegisterField.topAnchor.constraint(equalTo: logo.bottomAnchor,constant: 40),
            firstNameRegisterField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstNameRegisterField.heightAnchor.constraint(equalToConstant: 52),

            lastNameRegisterField.topAnchor.constraint(equalTo: firstNameRegisterField.bottomAnchor,constant: 20),
            lastNameRegisterField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastNameRegisterField.widthAnchor.constraint(equalToConstant: 317),
            lastNameRegisterField.heightAnchor.constraint(equalToConstant: 52),

            emailRegisterField.topAnchor.constraint(equalTo: lastNameRegisterField.bottomAnchor,constant: 20),
            emailRegisterField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailRegisterField.widthAnchor.constraint(equalToConstant: 317),
            emailRegisterField.heightAnchor.constraint(equalToConstant: 52),

            passwordRegisterField.topAnchor.constraint(equalTo: emailRegisterField.bottomAnchor,constant: 20),
            passwordRegisterField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordRegisterField.widthAnchor.constraint(equalToConstant: 317),
            passwordRegisterField.heightAnchor.constraint(equalToConstant: 52),

            confirmPassRegisterField.topAnchor.constraint(equalTo: passwordRegisterField.bottomAnchor,constant: 20),
            confirmPassRegisterField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmPassRegisterField.widthAnchor.constraint(equalToConstant: 317),
            confirmPassRegisterField.heightAnchor.constraint(equalToConstant: 52),
            
            registerButton.topAnchor.constraint(equalTo: confirmPassRegisterField.bottomAnchor,constant: 60),
            registerButton.widthAnchor.constraint(equalToConstant: 217),
            registerButton.heightAnchor.constraint(equalToConstant: 52),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
    }
}
