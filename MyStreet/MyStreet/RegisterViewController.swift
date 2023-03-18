//
//  RegisterViewController.swift
//  MyStreet
//
//  Created by Cerqueira, Fabio Galante on 18/03/2023.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let logo = UIImageView(image: UIImage(named: "logo"))
        let firstName = UITextField()
        let lastName = UITextField()
        let email = UITextField()
        let password = UITextField()
        let confirmPassword = UITextField()
        let registerBtn = UIButton()
        
        firstName.placeholder = "  Primeiro Nome"
        lastName.placeholder = "  Último Nome"
        email.placeholder = "  Email"
        password.placeholder = "  Password"
        confirmPassword.placeholder = "  Confirmar Password"
                
        registerBtn.backgroundColor = .blue
        registerBtn.setTitle("REGISTAR", for: .normal)
        registerBtn.layer.cornerRadius = 10

        
        
        firstName.layer.cornerRadius = 10
        
        lastName.layer.cornerRadius = 10
        
        email.layer.cornerRadius = 10
        
        password.layer.cornerRadius = 10
        
        confirmPassword.layer.cornerRadius = 10
        
        firstName.layer.borderWidth = 1.0
        firstName.layer.borderColor = UIColor.gray.cgColor

        lastName.layer.borderWidth = 1.0
        lastName.layer.borderColor = UIColor.gray.cgColor

        email.layer.borderWidth = 1.0
        email.layer.borderColor = UIColor.gray.cgColor

        password.layer.borderWidth = 1.0
        password.layer.borderColor = UIColor.gray.cgColor

        confirmPassword.layer.borderWidth = 1.0
        confirmPassword.layer.borderColor = UIColor.gray.cgColor
        
        
        
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        firstName.translatesAutoresizingMaskIntoConstraints = false
        lastName.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        confirmPassword.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.translatesAutoresizingMaskIntoConstraints = false

        
        view.addSubview(logo)
        view.addSubview(firstName)
        view.addSubview(lastName)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(confirmPassword)
        view.addSubview(registerBtn)
        
        
        
        
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 150),
            logo.heightAnchor.constraint(equalToConstant: 150),
            
            firstName.widthAnchor.constraint(equalToConstant: 317),
            firstName.topAnchor.constraint(equalTo: logo.bottomAnchor,constant: 40),
            firstName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstName.heightAnchor.constraint(equalToConstant: 52),

            
            lastName.topAnchor.constraint(equalTo: firstName.bottomAnchor,constant: 20),
            lastName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastName.widthAnchor.constraint(equalToConstant: 317),
            lastName.heightAnchor.constraint(equalToConstant: 52),


            email.topAnchor.constraint(equalTo: lastName.bottomAnchor,constant: 20),
            email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            email.widthAnchor.constraint(equalToConstant: 317),
            email.heightAnchor.constraint(equalToConstant: 52),


            password.topAnchor.constraint(equalTo: email.bottomAnchor,constant: 20),
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.widthAnchor.constraint(equalToConstant: 317),
            password.heightAnchor.constraint(equalToConstant: 52),


            confirmPassword.topAnchor.constraint(equalTo: password.bottomAnchor,constant: 20),
            confirmPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmPassword.widthAnchor.constraint(equalToConstant: 317),
            confirmPassword.heightAnchor.constraint(equalToConstant: 52),
            
            registerBtn.topAnchor.constraint(equalTo: confirmPassword.bottomAnchor,constant: 60),
            registerBtn.widthAnchor.constraint(equalToConstant: 217),
            registerBtn.heightAnchor.constraint(equalToConstant: 52),
            registerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)


        ])


    }


}
