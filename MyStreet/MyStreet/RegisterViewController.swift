//
//  RegisterViewController.swift
//  MyStreet
//
//  Created by Cerqueira, Fabio Galante on 18/03/2023.
//

import UIKit
import Firebase

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
            
            // TODO tratamento de aceitação dos valores introduzidos
            guard let email = self.emailRegisterField.text else { return }
            guard let password = self.passwordRegisterField.text else { return }
            guard let firstName = self.firstNameRegisterField.text else { return }
            guard let lastName = self.lastNameRegisterField.text else { return }
            
            // criação do utilizador, por defeito o registo verifica se o email está bem formatado e se
            // a pass tem pelo menos 6 caracteres
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    
                    // TODO tratamento de erros do servidor
                    print("DEBUG - \(error.localizedDescription)")
                    return
                }
                print("DEBUG - Successfull Registration")
                
                // recebemos o uid atribuido ao utilizador
                guard let uid = result?.user.uid else { return }
                
                // valores para serem guardados na base de dados
                let values = ["email": email, "firstName": firstName, "lastName": lastName]
                
                
                // guarda os valores
                REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
                    print("Successfully updated user info")
                }
                self.navigationController?.pushViewController(UserMenuViewController(), animated: true)
            }
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
