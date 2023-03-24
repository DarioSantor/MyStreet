//
//  ReportViewController.swift
//  MyStreet
//
//  Created by Cerqueira, Fabio Galante on 20/03/2023.
//

import UIKit

class ReportViewController: UIViewController,UITextViewDelegate {

    private let reportLocalizationField = CustomTextField(fieldType: .location)
    private let reportTitleField = CustomTextField(fieldType: .reportTitle)
    private let reportFilterField = CustomTextField(fieldType: .reportFilter)
    private let reportDescriptonField = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        reportDescriptonField.delegate = self
        
        let title = UILabel()
        title.text = "Reportar Ocorrência"
        let locationImg = UIImageView(image: UIImage(named: "gps")?.withTintColor(UIColor.label))

        locationImg.backgroundColor = .secondarySystemBackground
        locationImg.layer.borderColor = CGColor(gray: 10, alpha: 5)
        locationImg.layer.cornerRadius = 8

        reportDescriptonField.backgroundColor = .secondarySystemBackground
        reportDescriptonField.font = UIFont.systemFont(ofSize: 20)
        reportDescriptonField.text = " Descrição"
        reportDescriptonField.textColor = UIColor.lightGray
        reportDescriptonField.layer.cornerRadius = 8
        
        
        
        let reportImage = UIImageView(image: UIImage())
        reportImage.backgroundColor = .secondarySystemBackground
        reportImage.layer.cornerRadius = 8


        
        let reportAction = UIAction {_ in
            guard let localization = self.reportLocalizationField.text else { return }
            guard let title = self.reportTitleField.text else { return }
            guard let type = self.reportFilterField.text else { return }
            guard let description = self.reportDescriptonField.text else { return }
            
            let values = ["localization": localization, "title": title, "type": type, "description": description]
            
            let userDefaults = UserDefaults.standard
            
            let uid = userDefaults.object(forKey: "myUID")
            
            REF_ISSUES.child(uid as! String).updateChildValues(values) { (error, ref) in
                print("Successfully updated issue info")
            }
            self.navigationController?.pushViewController(ConfirmationViewController(), animated: true)
        }
        
        let submitBtn = UIButton(type: .system, primaryAction: reportAction)
        submitBtn.setTitle("SUBMETER", for: .normal)
        submitBtn.backgroundColor = .systemBlue
        submitBtn.setTitleColor(UIColor.label, for: .normal)
        submitBtn.layer.cornerRadius = 8
        submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        
        let items = [
            title,
            reportLocalizationField,
            locationImg,
            reportTitleField,
            reportFilterField,
            reportDescriptonField,
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
            reportLocalizationField.trailingAnchor.constraint(equalTo: locationImg.leadingAnchor,constant:-20),
            reportLocalizationField.heightAnchor.constraint(equalToConstant:40),
            
            locationImg.topAnchor.constraint(equalTo: title.bottomAnchor, constant:20),
            locationImg.leadingAnchor.constraint(equalTo: reportLocalizationField.trailingAnchor,constant:20),
            locationImg.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            locationImg.bottomAnchor.constraint(equalTo: reportLocalizationField.bottomAnchor),
            locationImg.heightAnchor.constraint(equalToConstant:40),
            locationImg.widthAnchor.constraint(equalToConstant:40),


            reportTitleField.topAnchor.constraint(equalTo: reportLocalizationField.bottomAnchor,constant:10),
            reportTitleField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportTitleField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            reportTitleField.bottomAnchor.constraint(equalTo: reportFilterField.topAnchor,constant:-10),
            reportTitleField.heightAnchor.constraint(equalToConstant:40),
            
            reportFilterField.topAnchor.constraint(equalTo: reportTitleField.bottomAnchor),
            reportFilterField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportFilterField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            reportFilterField.bottomAnchor.constraint(equalTo: reportDescriptonField.topAnchor,constant:-10),
            reportFilterField.heightAnchor.constraint(equalToConstant:40),
            
            reportDescriptonField.topAnchor.constraint(equalTo: reportFilterField.bottomAnchor,constant:40),
            reportDescriptonField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportDescriptonField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            reportDescriptonField.heightAnchor.constraint(equalToConstant:200),
            
            reportImage.topAnchor.constraint(equalTo: reportDescriptonField.bottomAnchor,constant:10),
            reportImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportImage.heightAnchor.constraint(equalToConstant: 200),
            reportImage.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            
            submitBtn.topAnchor.constraint(equalTo: reportImage.bottomAnchor,constant:40),
            submitBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            submitBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),

        ])
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = " Descrição"
            textView.textColor = UIColor.lightGray
            textView.alpha = 0.7
        }
    }
}
