//
//  OccurrenceTypeFilterViewControllerModal.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 23/03/2023.
//

import UIKit

class OccurrenceTypeFilterViewControllerModal: UIViewController {
    
    var lightButton: UIButton! = nil
    var garbageButton: UIButton! = nil
    var animalsButton: UIButton! = nil
    var pavementButton: UIButton! = nil
    var othersButton: UIButton! = nil
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    let defaultHeight: CGFloat = 350
    var closeButton: UIButton! = nil
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let action = UIAction() {_ in
            self.dismiss(animated: true)
        }
        
        lightButton = makeTypeButtons(type: "Iluminação Pública")
        garbageButton = makeTypeButtons(type: "Recolha de Lixo")
        animalsButton = makeTypeButtons(type: "Animais Abandonados")
        pavementButton = makeTypeButtons(type: "Piso em Mau Estado")
        othersButton = makeTypeButtons(type: "Outros")
        
        let image = UIImage(systemName: "xmark.circle")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        
        closeButton = UIButton(type: .system, primaryAction: action)
        closeButton.setImage(image, for: .normal)
        closeButton.layer.cornerRadius = 8
        
        setupView()
        setupConstraints()
    }
    
    func makeTypeButtons(type: String) -> UIButton {
        let action = UIAction() {_ in
            let userInfo = [ "text" : type ]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "myTypeKey"), object: nil, userInfo: userInfo)
            self.dismiss(animated: true)
        }
        
        let button = UIButton(type: .system, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.setTitle(type, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.layer.cornerRadius = 8
        button.setTitleColor(UIColor.label, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        return button
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupConstraints() {
        
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        view.addSubview(closeButton)
        view.addSubview(lightButton)
        view.addSubview(garbageButton)
        view.addSubview(animalsButton)
        view.addSubview(pavementButton)
        view.addSubview(othersButton)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            lightButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            lightButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            lightButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            lightButton.heightAnchor.constraint(equalToConstant: 40),
            
            garbageButton.topAnchor.constraint(equalTo: lightButton.bottomAnchor, constant: 10),
            garbageButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            garbageButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            garbageButton.heightAnchor.constraint(equalToConstant: 40),
            
            animalsButton.topAnchor.constraint(equalTo: garbageButton.bottomAnchor, constant: 10),
            animalsButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            animalsButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            animalsButton.heightAnchor.constraint(equalToConstant: 40),
            
            pavementButton.topAnchor.constraint(equalTo: animalsButton.bottomAnchor, constant: 10),
            pavementButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            pavementButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            pavementButton.heightAnchor.constraint(equalToConstant: 40),
            
            othersButton.topAnchor.constraint(equalTo: pavementButton.bottomAnchor, constant: 10),
            othersButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            othersButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            othersButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
}
