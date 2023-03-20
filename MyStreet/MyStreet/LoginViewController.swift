//
//  LoginViewController.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 13/03/2023.
//

import UIKit

///Login View Controller
class LoginViewController: UIViewController {
    
    private let logo = UIImageView(image: UIImage(named: "logo"))
    
    
    private let emailLoginField = CustomTextField(fieldType: .email)
    private let passwordLoginField = CustomTextField(fieldType: .password)
    private let loginButton = CustomButton(title: "Login", bgColor: .systemGreen)
    private let registerButton = CustomButton(title: "Registar", bgColor: .systemBlue)
    
    private let registerQuestion: UILabel = {
        let label = UILabel()
        label.text = "Não tem conta?"
        label.layer.borderWidth = 1
        return label
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        
        view.addSubview(logo)
        view.addSubview(emailLoginField)
        view.addSubview(passwordLoginField)
        view.addSubview(loginButton)
        view.addSubview(registerQuestion)
        view.addSubview(registerButton)
        
        addContraints()
        
        registerButton.addTarget(self, action: #selector(goToRegisterVC), for: .touchUpInside)
    }
    
    private func addContraints() {
        logo.translatesAutoresizingMaskIntoConstraints = false
        emailLoginField.translatesAutoresizingMaskIntoConstraints = false
        passwordLoginField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registerQuestion.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 280),
            logo.heightAnchor.constraint(equalToConstant: 250),
//            
            emailLoginField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            emailLoginField.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
            emailLoginField.widthAnchor.constraint(equalTo: logo.widthAnchor),
            emailLoginField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordLoginField.topAnchor.constraint(equalTo: emailLoginField.bottomAnchor, constant: 20),
            passwordLoginField.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
            passwordLoginField.widthAnchor.constraint(equalTo: logo.widthAnchor),
            passwordLoginField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordLoginField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: logo.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            registerQuestion.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerQuestion.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
            
            registerButton.topAnchor.constraint(equalTo: registerQuestion.bottomAnchor, constant: 5),
            registerButton.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
            registerButton.widthAnchor.constraint(equalTo: logo.widthAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
    
    @objc func goToRegisterVC() {
        navigationController?.pushViewController(LocalizationAuthViewController(), animated: true)
    }
    


}

