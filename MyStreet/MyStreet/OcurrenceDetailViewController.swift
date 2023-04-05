//
//  OcurrenceDetailView.swift
//  MyStreet
//
//  Created by Cerqueira, Fabio Galante on 24/03/2023.
//

import UIKit
import Kingfisher

class OcurrenceDetailViewController: UIViewController {
    private let stateField = UILabel()
    private let observationField = CustomTextField(fieldType: .reportObservation)
    private let descriptonField = UITextView()
//    var selectedIndexPath: IndexPath?
    private var reportImage = UIImageView(image: UIImage())

    
    private let selectedOccurrence: Occurrence
        
        init(selectedOccurrence: Occurrence) {
            self.selectedOccurrence = selectedOccurrence
            if let imageUrl = selectedOccurrence.imageUrl, let url = URL(string: imageUrl) {
                self.reportImage.kf.setImage(with: url)
            } else {
                self.reportImage.image = UIImage(systemName: "photo.fill")
            }

            
            
            super.init(nibName: nil, bundle: nil)
            
        }
       
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Ver Ocorrências"
        let customCell = CustomOcurrencetableViewCellTableViewCell()
        customCell.configure(occurrence: selectedOccurrence)
        let checkImg = UIImageView(image: UIImage(named:"checkmark"))

        checkImg.layer.borderColor = CGColor(gray: 10, alpha: 5)
        checkImg.backgroundColor = .secondarySystemBackground
        checkImg.layer.cornerRadius = 8

        descriptonField.backgroundColor = .secondarySystemBackground
        descriptonField.font = UIFont.systemFont(ofSize: 20)
        descriptonField.text = " Descrição"
        descriptonField.text = selectedOccurrence.description
        descriptonField.textColor = UIColor.lightGray
        descriptonField.layer.cornerRadius = 8
        
        stateField.text = "  Estado"
        stateField.backgroundColor = .secondarySystemBackground
        stateField.textColor = UIColor.lightGray
        stateField.font = UIFont.systemFont(ofSize: 20)
        stateField.layer.cornerRadius = 8
        stateField.clipsToBounds = true
        
        reportImage.backgroundColor = .secondarySystemBackground
        reportImage.layer.cornerRadius = 8
        reportImage.contentMode = .scaleAspectFit
        
        
        let items = [
            descriptonField,
            reportImage,
            observationField,
            customCell,
        ]
        
        for item in items {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
        
        NSLayoutConstraint.activate([
            
            customCell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant:20),
            customCell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customCell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customCell.heightAnchor.constraint(equalToConstant: 120),
            
            descriptonField.topAnchor.constraint(equalTo: customCell.bottomAnchor,constant:20),
            descriptonField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            descriptonField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            descriptonField.heightAnchor.constraint(equalToConstant:200),

            reportImage.topAnchor.constraint(equalTo: descriptonField.bottomAnchor,constant:20),
            reportImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportImage.heightAnchor.constraint(equalToConstant: 200),
            reportImage.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            
            observationField.topAnchor.constraint(equalTo: reportImage.bottomAnchor,constant:20),
            observationField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            observationField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            observationField.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        var checkUserType = LoginViewController()
        if checkUserType.isUserAdmin {
            view.addSubview(stateField)
            stateField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(checkImg)
            checkImg.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                checkImg.topAnchor.constraint(equalTo: observationField.bottomAnchor,constant:20),
                checkImg.leadingAnchor.constraint(equalTo: stateField.trailingAnchor,constant:20),
                checkImg.widthAnchor.constraint(equalToConstant: 40),
                checkImg.heightAnchor.constraint(equalToConstant: 40),
                stateField.topAnchor.constraint(equalTo: observationField.bottomAnchor,constant:20),
                stateField.heightAnchor.constraint(equalToConstant:40),
                stateField.widthAnchor.constraint(equalToConstant: 290),
                stateField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            ])
        }
        
//        let url = URL(string: occu)
//        reportImage.setImage(with: occurrence.set)
        
    }
}
