//
//  OcurrencyListViewController.swift
//  MyStreet
//
//  Created by Correia, Jose Bastos on 20/03/2023.
//

import UIKit

class OcurrencyListViewController: UIViewController {
    
    private let issueTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        
        
    }
}

Ocurency
