//
//  OcurrenceDetailView.swift
//  MyStreet
//
//  Created by Cerqueira, Fabio Galante on 24/03/2023.
//

import UIKit

class OcurrenceDetailViewController: UIViewController {
    private let stateField = CustomTextField(fieldType: .reportFilter)
    private let descriptonField = UITextView()
    
    
    
    init(viewModelOccurrence: Occurrence) {
        
        // TODO
        ///instantiate the variables with the vmoccurences
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let title = UILabel()
        title.text = "Reportar Ocorrência"
        let checkImg = UIImageView(image: UIImage(systemName: "checkmark")?.withTintColor(UIColor.label))

        checkImg.layer.borderColor = CGColor(gray: 10, alpha: 5)
        checkImg.layer.cornerRadius = 8

        descriptonField.backgroundColor = .secondarySystemBackground
        descriptonField.font = UIFont.systemFont(ofSize: 20)
        descriptonField.text = " Descrição"
        descriptonField.textColor = UIColor.lightGray
        descriptonField.layer.cornerRadius = 8
        
        
        
        let reportImage = UIImageView(image: UIImage())
        reportImage.backgroundColor = .secondarySystemBackground
        reportImage.layer.cornerRadius = 8
        
        
        let items = [
            title,
            stateField,
            descriptonField,
            reportImage,
            checkImg
        ]
        
        for item in items {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptonField.topAnchor.constraint(equalTo: title.bottomAnchor,constant:40),
            descriptonField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            descriptonField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            descriptonField.heightAnchor.constraint(equalToConstant:200),
            
            stateField.topAnchor.constraint(equalTo: reportImage.bottomAnchor,constant:20),
            stateField.heightAnchor.constraint(equalToConstant:40),

            
            reportImage.topAnchor.constraint(equalTo: descriptonField.bottomAnchor,constant:10),
            reportImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportImage.heightAnchor.constraint(equalToConstant: 200),
            reportImage.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            
            checkImg.topAnchor.constraint(equalTo: reportImage.bottomAnchor,constant:20),
            checkImg.leadingAnchor.constraint(equalTo: stateField.trailingAnchor,constant:20),
            checkImg.widthAnchor.constraint(equalToConstant: 40),
            checkImg.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}
