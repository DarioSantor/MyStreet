//
//  UserMenuViewController.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 20/03/2023.
//

import UIKit

class UserMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        navigationItem.setHidesBackButton(true, animated: false)
        
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        let actionReportButton = UIAction() {_ in
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        let reportButton = UIButton(type: .system, primaryAction: actionReportButton)
        reportButton.backgroundColor = .secondarySystemBackground
        reportButton.setTitle("Reportar ocorrência", for: .normal)
        reportButton.setTitleColor(UIColor.label, for: .normal)
        reportButton.layer.cornerRadius = 8
        reportButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        reportButton.translatesAutoresizingMaskIntoConstraints = false
        
        let allIssuesAction = UIAction() {_ in
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        let allIssuesButton = UIButton(type: .system, primaryAction: allIssuesAction)
        allIssuesButton.backgroundColor = .secondarySystemBackground
        allIssuesButton.setTitle("Ver ocorrências", for: .normal)
        allIssuesButton.setTitleColor(UIColor.label, for: .normal)
        allIssuesButton.layer.cornerRadius = 8
        allIssuesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        allIssuesButton.translatesAutoresizingMaskIntoConstraints = false
        
        let myIssuesAction = UIAction() {_ in
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        let myIssuesButton = UIButton(type: .system, primaryAction: myIssuesAction)
        myIssuesButton.backgroundColor = .secondarySystemBackground
        myIssuesButton.setTitle("Minhas ocorrências", for: .normal)
        myIssuesButton.setTitleColor(UIColor.label, for: .normal)
        myIssuesButton.layer.cornerRadius = 8
        myIssuesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        myIssuesButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logo)
        view.addSubview(reportButton)
        view.addSubview(allIssuesButton)
        view.addSubview(myIssuesButton)
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 150),
            logo.heightAnchor.constraint(equalToConstant: 150),
            
            reportButton.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 80),
            reportButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            reportButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            reportButton.heightAnchor.constraint(equalToConstant: 40),
            
            allIssuesButton.topAnchor.constraint(equalTo: reportButton.bottomAnchor, constant: 20),
            allIssuesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            allIssuesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            allIssuesButton.heightAnchor.constraint(equalToConstant: 40),
            
            myIssuesButton.topAnchor.constraint(equalTo: allIssuesButton.bottomAnchor, constant: 20),
            myIssuesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myIssuesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            myIssuesButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
