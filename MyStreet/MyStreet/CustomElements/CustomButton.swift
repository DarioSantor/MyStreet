//
//  CustomButton.swift
//  MyStreet
//
//  Created by Correia, Jose Bastos on 19/03/2023.
//

import UIKit

class CustomButton: UIButton {
    
    init(title: String, bgColor: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true // ??
        self.backgroundColor = bgColor

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
