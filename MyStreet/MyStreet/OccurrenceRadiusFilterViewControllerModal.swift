//
//  OccurrenceRadiusFilterViewControllerModal.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 23/03/2023.
//

import UIKit

class OccurrenceRadiusFilterViewControllerModal: UIViewController {
    
    var distance500Button: UIButton! = nil
    var distance1kButton: UIButton! = nil
    var distance2kButton: UIButton! = nil
    var distance5kButton: UIButton! = nil
    var distance10kButton: UIButton! = nil
    
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
        
        distance500Button = makeTypeButtons(type: "500 metros")
        distance1kButton = makeTypeButtons(type: "1 Kilómetro")
        distance2kButton = makeTypeButtons(type: "2 Kilómetros")
        distance5kButton = makeTypeButtons(type: "5 Kilómetros")
        distance10kButton = makeTypeButtons(type: "10 Kilómetros")
        
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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "myRadiusKey"), object: nil, userInfo: userInfo)
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
        view.addSubview(distance500Button)
        view.addSubview(distance1kButton)
        view.addSubview(distance2kButton)
        view.addSubview(distance5kButton)
        view.addSubview(distance10kButton)
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
            
            distance500Button.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            distance500Button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            distance500Button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            distance500Button.heightAnchor.constraint(equalToConstant: 40),
            
            distance1kButton.topAnchor.constraint(equalTo: distance500Button.bottomAnchor, constant: 10),
            distance1kButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            distance1kButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            distance1kButton.heightAnchor.constraint(equalToConstant: 40),
            
            distance2kButton.topAnchor.constraint(equalTo: distance1kButton.bottomAnchor, constant: 10),
            distance2kButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            distance2kButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            distance2kButton.heightAnchor.constraint(equalToConstant: 40),
            
            distance5kButton.topAnchor.constraint(equalTo: distance2kButton.bottomAnchor, constant: 10),
            distance5kButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            distance5kButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            distance5kButton.heightAnchor.constraint(equalToConstant: 40),
            
            distance10kButton.topAnchor.constraint(equalTo: distance5kButton.bottomAnchor, constant: 10),
            distance10kButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            distance10kButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            distance10kButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
}
