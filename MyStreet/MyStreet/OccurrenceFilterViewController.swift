//
//  OccurrenceFilterViewController.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 22/03/2023.
//

import UIKit

class OccurrenceFilterViewController: UIViewController {
    
    var setTypeTitle: String!
    var setTypeButton = UIButton(frame: .zero)
    var setRadiusButton = UIButton(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .label
//        navigationItem.setHidesBackButton(true, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.typeNotificationReceived(_:)), name: NSNotification.Name(rawValue: "myTypeKey"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.radiusNotificationReceived(_:)), name: NSNotification.Name(rawValue: "myRadiusKey"), object: nil)
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
//        navigationItem.hidesBackButton = false
//        navigationItem.backButtonTitle = "oi"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "oi", style: .plain, target: nil, action: nil)
        
        
        self.navigationItem.title = "Filtragem ocorrências"
        self.navigationItem.backBarButtonItem?.title = ""
//        navigationItem.backButtonTitle = ""

        
        let typeAction = UIAction() {_ in
            let vc = OccurrenceTypeFilterViewControllerModal()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
        let radiusAction = UIAction() {_ in
            let vc = OccurrenceRadiusFilterViewControllerModal()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
        let action = UIAction() {_ in
//            let vc = OccurrenceFilteredViewController(typeFilter: .light, distanceFilter: .distance500, occurrences: self.occ, title: self.setTypeButton.currentTitle!)
//            vc.modalPresentationStyle = .overCurrentContext
//            self.present(vc, animated: true)
            
            // MARK: - TROQUEI PARA UM PUSH PQ NAO CONSEGUIA TER NAVBAR NO MODAL
            
            print(typeAction.attributes.isEmpty)
            
            self.navigationController?.pushViewController(OccurrenceFilteredViewController(typeFilter: .light, distanceFilter: .distance500, occurrences: occurrences, title: self.setTypeButton.currentTitle!), animated: true)
        }
        
        let image = UIImage(systemName: "arrowtriangle.down.circle")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        
        setTypeButton = UIButton(type: .system, primaryAction: typeAction)
        setTypeButton.translatesAutoresizingMaskIntoConstraints = false
        setTypeButton.backgroundColor = .lightGray
        setTypeButton.setTitle("Tipo", for: .normal)
        setTypeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        setTypeButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        setTypeButton.setImage(image, for: .normal)
        setTypeButton.layer.cornerRadius = 8
        setTypeButton.setTitleColor(UIColor.label, for: .normal)
        setTypeButton.imageView?.trailingAnchor.constraint(equalTo: setTypeButton.trailingAnchor, constant: -20.0).isActive = true
        setTypeButton.imageView?.centerYAnchor.constraint(equalTo: setTypeButton.centerYAnchor, constant: 0.0).isActive = true
        setTypeButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        setRadiusButton = UIButton(type: .system, primaryAction: radiusAction)
        setRadiusButton.translatesAutoresizingMaskIntoConstraints = false
        setRadiusButton.backgroundColor = .lightGray
        setRadiusButton.setTitle("Raio", for: .normal)
        setRadiusButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        setRadiusButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        setRadiusButton.setImage(image, for: .normal)
        setRadiusButton.layer.cornerRadius = 8
        setRadiusButton.setTitleColor(UIColor.label, for: .normal)
        setRadiusButton.imageView?.trailingAnchor.constraint(equalTo: setRadiusButton.trailingAnchor, constant: -20.0).isActive = true
        setRadiusButton.imageView?.centerYAnchor.constraint(equalTo: setRadiusButton.centerYAnchor, constant: 0.0).isActive = true
        setRadiusButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        let applyButton = UIButton(type: .system, primaryAction: action)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.backgroundColor = .systemBlue
        applyButton.setTitle("APLICAR", for: .normal)
        applyButton.setTitleColor(UIColor.label, for: .normal)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        applyButton.layer.cornerRadius = 8
        
        view.addSubview(setTypeButton)
        view.addSubview(setRadiusButton)
        view.addSubview(applyButton)
        
        NSLayoutConstraint.activate([
            setTypeButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            setTypeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setTypeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setTypeButton.heightAnchor.constraint(equalToConstant: 40),
            
            setRadiusButton.topAnchor.constraint(equalTo: setTypeButton.bottomAnchor, constant: 40),
            setRadiusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setRadiusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setRadiusButton.heightAnchor.constraint(equalToConstant: 40),
            
            applyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            applyButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
    
    @objc func typeNotificationReceived(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        print ("text: \(text)")
        setTypeButton.setTitle(text, for: .normal)
    }
    
    @objc func radiusNotificationReceived(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        print ("text: \(text)")
        setRadiusButton.setTitle(text, for: .normal)
    }
}
