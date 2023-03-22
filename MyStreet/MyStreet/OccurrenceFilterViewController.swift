//
//  OccurrenceFilterViewController.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 22/03/2023.
//

import UIKit

class OccurrenceFilterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        navigationItem.title = "Filtragem ocorrências"
        
        let action = UIAction() {_ in
            self.navigationController?.pushViewController(UserMenuViewController(), animated: true)
        }
        
        let image = UIImage(systemName: "arrowtriangle.down.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        let setTypeButton = UIButton(type: .system, primaryAction: action)
        setTypeButton.translatesAutoresizingMaskIntoConstraints = false
        setTypeButton.backgroundColor = .gray
        setTypeButton.setTitle("Tipo", for: .normal)
        setTypeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        setTypeButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        setTypeButton.setImage(image, for: .normal)
        setTypeButton.layer.cornerRadius = 8
        setTypeButton.setTitleColor(UIColor.label, for: .normal)
        setTypeButton.imageView?.trailingAnchor.constraint(equalTo: setTypeButton.trailingAnchor, constant: -20.0).isActive = true
        setTypeButton.imageView?.centerYAnchor.constraint(equalTo: setTypeButton.centerYAnchor, constant: 0.0).isActive = true
        setTypeButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        let setRadiusButton = UIButton(type: .system, primaryAction: action)
        setRadiusButton.translatesAutoresizingMaskIntoConstraints = false
        setRadiusButton.backgroundColor = .gray
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
}
