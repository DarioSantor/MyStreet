//
//  ReportViewController.swift
//  MyStreet
//
//  Created by Cerqueira, Fabio Galante on 20/03/2023.
//

import UIKit

class ReportViewController: UIViewController {

    private let reportLocalizationField = CustomTextField(fieldType: .location)
    private let reportTitleField = CustomTextField(fieldType: .reportTitle)
    private let reportFilterField = CustomTextField(fieldType: .reportFilter)
    private let reportDescriptionField = CustomTextField(fieldType: .reportDescription)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let title = UILabel()
        title.text = "Reportar Ocorrência"
        let locationImg = UIImageView(image: UIImage(named: "gps"))
        locationImg.layer.borderWidth = 1
        
        let reportImage = UIImageView(image: UIImage())
        reportImage.layer.borderWidth = 1
        
        let submitBtn = UIButton()
        submitBtn.setTitle("SUBMETER", for: .normal)
        submitBtn.backgroundColor = .systemBlue
        submitBtn.layer.cornerRadius = 8
        
        
        let items = [
            title,
            reportLocalizationField,
            locationImg,
            reportTitleField,
            reportFilterField,
            reportDescriptionField,
            reportImage,
            submitBtn
        ]
        
        for item in items {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            reportLocalizationField.topAnchor.constraint(equalTo: title.bottomAnchor,constant:20),
            reportLocalizationField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportLocalizationField.trailingAnchor.constraint(equalTo: locationImg.leadingAnchor),
            reportLocalizationField.heightAnchor.constraint(equalToConstant:40),
            reportLocalizationField.widthAnchor.constraint(equalToConstant:290),

            
            locationImg.topAnchor.constraint(equalTo: title.bottomAnchor, constant:20),
            locationImg.leadingAnchor.constraint(equalTo: reportLocalizationField.trailingAnchor,constant:10),
            locationImg.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            locationImg.bottomAnchor.constraint(equalTo: reportLocalizationField.bottomAnchor),
            locationImg.heightAnchor.constraint(equalToConstant:40),

        
            reportTitleField.topAnchor.constraint(equalTo: reportLocalizationField.bottomAnchor,constant:10),
            reportTitleField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportTitleField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            reportTitleField.bottomAnchor.constraint(equalTo: reportFilterField.topAnchor,constant:-10),
            reportTitleField.heightAnchor.constraint(equalToConstant:40),

            
            reportFilterField.topAnchor.constraint(equalTo: reportTitleField.bottomAnchor),
            reportFilterField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportFilterField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            reportFilterField.bottomAnchor.constraint(equalTo: reportDescriptionField.topAnchor,constant:-10),
            reportFilterField.heightAnchor.constraint(equalToConstant:40),

            
            reportDescriptionField.topAnchor.constraint(equalTo: reportFilterField.bottomAnchor,constant:40),
            reportDescriptionField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportDescriptionField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            reportDescriptionField.heightAnchor.constraint(equalToConstant:200),
            
            reportImage.topAnchor.constraint(equalTo: reportDescriptionField.bottomAnchor,constant:40),
            reportImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportImage.heightAnchor.constraint(equalToConstant: 200),
            reportImage.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            
            submitBtn.topAnchor.constraint(equalTo: reportImage.bottomAnchor,constant:40),
            submitBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            submitBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),


        
        
        
        
        ])
        
    }

}
