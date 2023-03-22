//
//  LoginViewController.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 13/03/2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    private let logo = UIImageView(image: UIImage(named: "logo"))
    
    private var isUserAdmin: Bool = false
    private let emailLoginField = CustomTextField(fieldType: .email)
    private let passwordLoginField = CustomTextField(fieldType: .password)
    private let loginButton = CustomButton(title: "LOGIN", bgColor: .systemGreen)
    private let registerButton = CustomButton(title: "REGISTAR", bgColor: .systemBlue)
    
    private let registerQuestion: UILabel = {
        let label = UILabel()
        label.text = "Não tem conta?"
        return label
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // forma de esconder o back button e texto
        navigationItem.setHidesBackButton(true, animated: false)
    
        view.addSubview(logo)
        view.addSubview(emailLoginField)
        view.addSubview(passwordLoginField)
        view.addSubview(loginButton)
        view.addSubview(registerQuestion)
        view.addSubview(registerButton)
        
        addContraints()
        
        loginButton.addTarget(self, action: #selector(goToMenuVC), for: .touchUpInside)
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
            emailLoginField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailLoginField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailLoginField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordLoginField.topAnchor.constraint(equalTo: emailLoginField.bottomAnchor, constant: 20),
            passwordLoginField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordLoginField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordLoginField.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: passwordLoginField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            registerQuestion.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerQuestion.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
            
            registerButton.topAnchor.constraint(equalTo: registerQuestion.bottomAnchor, constant: 5),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            
            
        ])
    }
    
    @objc func goToMenuVC() {
        
        guard let email = self.emailLoginField.text else { return }
        guard let password = self.passwordLoginField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                
                // TODO: tratamento de erros do servidor
                print("DEBUG - \(error.localizedDescription)")
                return
            }
            print("You're IIIIIINNNNNNNN")
            guard let uid = result?.user.uid else { return }
            
            if uid == ADMIN_UID {
                self.navigationController?.pushViewController(AdminFiltersViewController(), animated: true)
                return
            }
            self.navigationController?.pushViewController(self.isUserAdmin ? UserMenuViewController() : UserMenuViewController(), animated: true)
        }

    }
    
    @objc func goToRegisterVC() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}

