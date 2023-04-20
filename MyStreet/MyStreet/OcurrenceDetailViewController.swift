//
//  OcurrenceDetailView.swift
//  MyStreet
//
//  Created by Cerqueira, Fabio Galante on 24/03/2023.
//

import UIKit
import Firebase
import Kingfisher

class OcurrenceDetailViewController: UIViewController {
    private var stateField = UILabel()
    private let observationField = CustomTextField(fieldType: .reportObservation)
    private let descriptionField = UITextView()
    private var reportImage = UIImageView(image: UIImage())
    private var selectedOccurrence: Occurrence
    private var checkImg = UIImageView(image: UIImage(systemName: "xmark.circle.fill")?.withTintColor(.red))
    
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
        
        checkImg.layer.borderColor = CGColor(gray: 10, alpha: 5)
        checkImg.backgroundColor = .secondarySystemBackground
        checkImg.layer.cornerRadius = 8
        
        descriptionField.backgroundColor = .secondarySystemBackground
        descriptionField.font = UIFont.systemFont(ofSize: 20)
        descriptionField.text = " Descrição"
        descriptionField.text = selectedOccurrence.description
        descriptionField.textColor = .label
        descriptionField.layer.cornerRadius = 8
        descriptionField.isEditable = false
        
        stateField.textAlignment = .center
        stateField.textColor = UIColor.lightGray
        stateField.font = UIFont.systemFont(ofSize: 20)
        stateField.layer.cornerRadius = 8
        stateField.clipsToBounds = true
        configureStateField()
        
        reportImage.backgroundColor = .secondarySystemBackground
        reportImage.layer.cornerRadius = 8
        reportImage.contentMode = .scaleAspectFit
        
        let items = [
            descriptionField,
            reportImage,
            customCell,
        ]
        
        for item in items {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
        
        NSLayoutConstraint.activate([
            
            customCell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant:20),
            customCell.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant:20),
            customCell.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-20),
            customCell.heightAnchor.constraint(equalToConstant: 120),
            
            descriptionField.topAnchor.constraint(equalTo: customCell.bottomAnchor,constant:20),
            descriptionField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:20),
            descriptionField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:-20),
            descriptionField.heightAnchor.constraint(equalToConstant:200),
            
            reportImage.topAnchor.constraint(equalTo: descriptionField.bottomAnchor,constant:20),
            reportImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:20),
            reportImage.heightAnchor.constraint(equalToConstant: 200),
            reportImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:-20),
            
        ])
        if isUserAdmin {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(didTapDelete))
            view.addSubview(observationField)
            observationField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(stateField)
            stateField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(checkImg)
            checkImg.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                checkImg.topAnchor.constraint(equalTo: observationField.bottomAnchor,constant:20),
                checkImg.trailingAnchor.constraint(equalTo: observationField.trailingAnchor),
                checkImg.widthAnchor.constraint(equalToConstant: 40),
                checkImg.heightAnchor.constraint(equalToConstant: 40),
                stateField.topAnchor.constraint(equalTo: observationField.bottomAnchor,constant:20),
                stateField.heightAnchor.constraint(equalTo: checkImg.heightAnchor),
                stateField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
                stateField.trailingAnchor.constraint(equalTo: checkImg.trailingAnchor),
                observationField.topAnchor.constraint(equalTo: reportImage.bottomAnchor,constant:20),
                observationField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
                observationField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
                observationField.heightAnchor.constraint(equalToConstant: 40),
            ])
            
            let tapStatus = UITapGestureRecognizer(target: self, action: #selector(didTapStatusChanger))
            checkImg.addGestureRecognizer(tapStatus)
            checkImg.isUserInteractionEnabled = true
        }
        
        else if self.selectedOccurrence.userUID == UserDefaults.standard.string(forKey: "myUID") {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(userDidTapDelete))
        }
    }
    
    @objc func didTapStatusChanger() {
        
        print(selectedOccurrence.state)
        let pathToChangeState = REF_OCCURRENCES.child(selectedOccurrence.ref)
        let statusUpdate = ["observation": self.observationField.text ?? "Sem observações.", "state": !selectedOccurrence.state] as [String : Any]
        selectedOccurrence.state = !selectedOccurrence.state
        pathToChangeState.updateChildValues(statusUpdate)
        print(selectedOccurrence.state)
        configureStateField()
    }
    
    @objc func didTapDelete() {
        let pathToChangeState = REF_OCCURRENCES.child(selectedOccurrence.ref)
        pathToChangeState.removeValue()
        self.navigationController?.pushViewController(AdminFiltersViewController(), animated: true)
    }
    
    @objc func userDidTapDelete() {
        let pathToChangeState = REF_OCCURRENCES.child(selectedOccurrence.ref)
        pathToChangeState.removeValue()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureStateField() {
        stateField.text = selectedOccurrence.state ? "Em aberto..." : "Resolvido!"
        stateField.textColor = selectedOccurrence.state ? .red : .green
        
        checkImg.tintColor = selectedOccurrence.state ? .red : .green
        checkImg.image = selectedOccurrence.state ? UIImage(systemName: "xmark.circle.fill") : UIImage(systemName: "checkmark.circle.fill")
    }
}
