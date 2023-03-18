//
//  LoginViewController.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 13/03/2023.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let register = UIButton()
        register.setTitle("Registar", for: .normal)
        register.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        
        view.addSubview(register)
        
        register.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            register.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            register.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func registerTapped() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

