//
//  ReportViewController.swift
//  MyStreet
//
//  Created by Cerqueira, Fabio Galante on 20/03/2023.
//

import UIKit

class ReportViewController: UIViewController,UITextViewDelegate {

    private let reportLocationField = CustomTextField(fieldType: .location)
    private let reportTitleField = CustomTextField(fieldType: .reportTitle)
    var setTypeButton = UIButton(frame: .zero)
    private let reportDescriptonField = UITextView()
    var buttonText: String? = ""
    
    private var keyboardHeight: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        reportDescriptonField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let title = UILabel()
        title.text = "Reportar Ocorrência"
        let locationImg = UIImageView(image: UIImage(named: "gps")?.withTintColor(UIColor.label))
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.typeNotificationReceived(_:)), name: NSNotification.Name(rawValue: "myTypeKey"), object: nil)

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
        
        
        let typeAction = UIAction() {_ in
            let vc = OccurrenceTypeFilterViewControllerModal()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
        let image = UIImage(systemName: "arrowtriangle.down.circle")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        
        setTypeButton = UIButton(type: .system, primaryAction: typeAction)
        setTypeButton.translatesAutoresizingMaskIntoConstraints = false
        setTypeButton.backgroundColor = .secondarySystemBackground
        setTypeButton.setTitle("Tipo", for: .normal)
        setTypeButton.tintColor = .lightGray
        setTypeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        setTypeButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        setTypeButton.setImage(image, for: .normal)
        setTypeButton.layer.cornerRadius = 8

        setTypeButton.setTitleColor(UIColor.label, for: .normal)
        setTypeButton.imageView?.trailingAnchor.constraint(equalTo: setTypeButton.trailingAnchor, constant: -20.0).isActive = true
        setTypeButton.imageView?.centerYAnchor.constraint(equalTo: setTypeButton.centerYAnchor, constant: 0.0).isActive = true
        setTypeButton.imageView?.translatesAutoresizingMaskIntoConstraints = false


        
        let reportAction = UIAction {_ in
            guard let location = self.reportLocationField.text else { return }
            guard let title = self.reportTitleField.text else { return }
            guard let type = self.buttonText else { return }
            guard let description = self.reportDescriptonField.text else { return }
            
            let values = ["location": location, "title": title, "type": type, "description": description]
            
            let userDefaults = UserDefaults.standard
            
            let uid = userDefaults.object(forKey: "myUID")
            
            REF_OCCURRENCES.child(uid as! String).updateChildValues(values) { (error, ref) in
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
            reportLocationField,
            locationImg,
            reportTitleField,
            reportDescriptonField,
            reportImage,
            submitBtn,
            setTypeButton

        ]
        
        for item in items {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            reportLocationField.topAnchor.constraint(equalTo: title.bottomAnchor,constant:20),
            reportLocationField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportLocationField.trailingAnchor.constraint(equalTo: locationImg.leadingAnchor,constant:-20),
            reportLocationField.heightAnchor.constraint(equalToConstant:40),
            
            locationImg.topAnchor.constraint(equalTo: title.bottomAnchor, constant:20),
            locationImg.leadingAnchor.constraint(equalTo: reportLocationField.trailingAnchor,constant:20),
            locationImg.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            locationImg.bottomAnchor.constraint(equalTo: reportLocationField.bottomAnchor),
            locationImg.heightAnchor.constraint(equalToConstant:40),
            locationImg.widthAnchor.constraint(equalToConstant:40),


            reportTitleField.topAnchor.constraint(equalTo: reportLocationField.bottomAnchor,constant:10),
            reportTitleField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportTitleField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            reportTitleField.bottomAnchor.constraint(equalTo: setTypeButton.topAnchor,constant:-10),
            reportTitleField.heightAnchor.constraint(equalToConstant:40),
            
            setTypeButton.topAnchor.constraint(equalTo: reportTitleField.bottomAnchor),
            setTypeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setTypeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setTypeButton.heightAnchor.constraint(equalToConstant: 40),
            setTypeButton.bottomAnchor.constraint(equalTo: reportDescriptonField.topAnchor,constant:-10),
            
            reportDescriptonField.topAnchor.constraint(equalTo: setTypeButton.bottomAnchor,constant:40),
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
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?NSValue else { return }
        keyboardHeight = keyboardSize.cgRectValue.height
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -self.keyboardHeight
        }
    }
        
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    
       
	}
    @objc func typeNotificationReceived(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        print ("text: \(text)")
        buttonText = text
        setTypeButton.setTitle(text, for: .normal)
    }
    
}

