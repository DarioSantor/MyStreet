//
//  OcurrencyListViewController.swift
//  MyStreet
//
//  Created by Correia, Jose Bastos on 20/03/2023.
//

import UIKit

class OccurrenceListViewController: UIViewController {
    
    private let occurrenceTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        
        occurrenceTableView.delegate = self
        occurrenceTableView.dataSource = self
        occurrenceTableView.register(CustomOcurrencetableViewCellTableViewCell.self, forCellReuseIdentifier: CustomOcurrencetableViewCellTableViewCell.identifier)
        
        view.addSubview(occurrenceTableView)
        
        occurrenceTableView.translatesAutoresizingMaskIntoConstraints = false
        occurrenceTableView.showsVerticalScrollIndicator = false
        NSLayoutConstraint.activate([
            occurrenceTableView.topAnchor.constraint(equalTo: view.topAnchor),
            occurrenceTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor), 
            occurrenceTableView.widthAnchor.constraint(equalToConstant: 320),
            occurrenceTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

extension OccurrenceListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        occurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: CustomOcurrencetableViewCellTableViewCell.identifier, for: indexPath) as! CustomOcurrencetableViewCellTableViewCell)
        cell.configure(occurence: occurrencies[indexPath.row])
        return cell
    }
}
