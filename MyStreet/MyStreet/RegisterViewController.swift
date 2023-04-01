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
    
    private var keyboardHeight: CGFloat = 0.0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // forma de dar cor diferente aos item do navigation bar
        navigationController?.navigationBar.tintColor = .label
        
        let emailErrorLabel = UILabel()
        emailErrorLabel.textColor = .systemRed
        emailErrorLabel.attributedText = NSAttributedString(string: "Email já registado.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)])
        emailErrorLabel.isHidden = true
        
        let passwordErrorLabel = UILabel()
        passwordErrorLabel.textColor = .systemRed
        passwordErrorLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        passwordErrorLabel.isHidden = true
        
        let firstNameErrorLabel = UILabel()
        firstNameErrorLabel.textColor = .systemRed
        firstNameErrorLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        firstNameErrorLabel.isHidden = true
        
        let lastNameErrorLabel = UILabel()
        lastNameErrorLabel.textColor = .systemRed
        lastNameErrorLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        lastNameErrorLabel.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let action = UIAction() {_ in
            localizationAuthorization = true
            
            // TODO: tratamento de aceitação dos valores introduzidos
            guard let email = self.emailRegisterField.text else { return }
            guard let password = self.passwordRegisterField.text else { return }
            guard let firstName = self.firstNameRegisterField.text else { return }
            guard let lastName = self.lastNameRegisterField.text else { return }
            guard let confirmPass = self.confirmPassRegisterField.text else { return }

            if firstName == "" {
                firstNameErrorLabel.isHidden = false
                firstNameErrorLabel.text = "Campo de preenchimento obrigatório."
            }
            else{
                firstNameErrorLabel.isHidden = true

            }
            if lastName == "" {
                lastNameErrorLabel.isHidden = false
                lastNameErrorLabel.text = "Campo de preenchimento obrigatório."
            }
            else{
                lastNameErrorLabel.isHidden = true

            }
            
            if password != confirmPass {
                passwordErrorLabel.isHidden = false
                passwordErrorLabel.text = "Passwords não coincidem."

                return
            }
            else{
                passwordErrorLabel.isHidden = true

            }
            if password.count < 6 {
                passwordErrorLabel.isHidden = false
                passwordErrorLabel.text = "Password deve conter pelo menos 6 caracteres."
                return
            }
            else{
                passwordErrorLabel.isHidden = true

            }
            // criação do utilizador, por defeito o registo verifica se o email está bem formatado e se
            // a pass tem pelo menos 6 caracteres
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    
                    // TODO tratamento de erros do servidor
                    print("\(error.localizedDescription)")
                    return
                }
                print("Successfull Registration")
                
                // recebemos o uid atribuido ao utilizador
                guard let uid = result?.user.uid else { return }
                
                // guarda o uid do user nos userDefaults
                let userDefaults = UserDefaults.standard
                userDefaults.set(uid, forKey: "myUID")
                
                // valores para serem guardados na base de dados
                let values = ["email": email, "firstName": firstName, "lastName": lastName]
                
                // envia os valores para a BD
                REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
                    print("Successfully updated user info")
                }
                self.navigationController?.pushViewController(UserMenuViewController(), animated: true)
            }
            Auth.auth().fetchSignInMethods(forEmail: email) { signInMethods, error in
                if let error = error {
                    // Handle error
                    print("\(error.localizedDescription)")
                    return
                }
                
                if let signInMethods = signInMethods, !signInMethods.isEmpty {
                    emailErrorLabel.isHidden = false
                    return
                } else{
                    emailErrorLabel.isHidden = true
                }
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
            registerButton,
            emailErrorLabel,
            passwordErrorLabel,
            lastNameErrorLabel,
            firstNameErrorLabel,
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
            
            emailErrorLabel.topAnchor.constraint(equalTo: emailRegisterField.bottomAnchor,constant:2),
            emailErrorLabel.leadingAnchor.constraint(equalTo: emailRegisterField.leadingAnchor,constant:5),
            
            firstNameErrorLabel.topAnchor.constraint(equalTo: firstNameRegisterField.bottomAnchor,constant:2),
            firstNameErrorLabel.leadingAnchor.constraint(equalTo: firstNameRegisterField.leadingAnchor,constant:5),
            
            lastNameErrorLabel.topAnchor.constraint(equalTo: lastNameRegisterField.bottomAnchor,constant:2),
            lastNameErrorLabel.leadingAnchor.constraint(equalTo: lastNameRegisterField.leadingAnchor,constant:5),
            
            passwordErrorLabel.topAnchor.constraint(equalTo: confirmPassRegisterField.bottomAnchor, constant:2),
                passwordErrorLabel.leadingAnchor.constraint(equalTo: confirmPassRegisterField.leadingAnchor, constant:5),
        
        ])
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?NSValue else { return }
        keyboardHeight = keyboardSize.cgRectValue.height
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -self.keyboardHeight / 2
        }
    }
        
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
}
