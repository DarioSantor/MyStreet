//
//  CustomTextField.swift
//  MyStreet
//
//  Created by Correia, Jose Bastos on 19/03/2023.
//

import UIKit

class CustomTextField: UITextField {

    enum CustomTextFieldType {
        case email
        case password
        case firstName
        case lastName
        case confirmPass
    }
    
    private let authFieldType: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        self.authFieldType = fieldType
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 8
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.font = UIFont.systemFont(ofSize: 22)
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        
        switch fieldType {
        case .email:
            self.placeholder = "Email"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
        case .password:
            self.placeholder = "Password"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        case .confirmPass:
            self.placeholder = "Confirm Password"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        case .firstName:
            self.placeholder = "Primeiro Nome"
            self.keyboardType = .alphabet
            self.textContentType = .givenName
        case .lastName:
            self.placeholder = "Último Nome"
            self.keyboardType = .alphabet
            self.textContentType = .familyName
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
