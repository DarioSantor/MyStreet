//
//  OccurrenceUserListViewController.swift
//  MyStreet
//
//  Created by Correia, Jose Bastos on 25/03/2023.
//

import UIKit

class OccurrenceUserListViewController: UIViewController {
    
    private let occurrenceTableView = UITableView()
    let occurrenceService = OccurrenceService()
    var occurrencesToDisplay: [Occurrence] = [] {
        didSet {
            if !occurrencesToDisplay.isEmpty {
                filterOcc()
            }
        }
    }
    var userOccurrencies: [Occurrence] = []
    
    private func filterOcc() {
//        userOccurrencies = occurrencesToDisplay.filter( $0.userUID == UserDefaults.standard.string(forKey: "myUID"))
        
        for occ in occurrencesToDisplay {
            if occ.userUID == UserDefaults.standard.string(forKey: "myUID") {
                userOccurrencies.append(occ)
            }
        }
        occurrenceTableView.reloadData()
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .done, target: self, action: #selector(didTapFilters))
        
        occurrenceTableView.delegate = self
        occurrenceTableView.dataSource = self
        occurrenceTableView.register(CustomOcurrencetableViewCellTableViewCell.self, forCellReuseIdentifier: CustomOcurrencetableViewCellTableViewCell.identifier)
        
        view.addSubview(occurrenceTableView)
        
        occurrenceTableView.translatesAutoresizingMaskIntoConstraints = false
        occurrenceTableView.showsVerticalScrollIndicator = false
        occurrenceTableView.separatorStyle = .none
        NSLayoutConstraint.activate([
            occurrenceTableView.topAnchor.constraint(equalTo: view.topAnchor),
            occurrenceTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            occurrenceTableView.widthAnchor.constraint(equalToConstant: 320),
            occurrenceTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        DispatchQueue.main.async {
                self.occurrenceService.getOccurrencesFromDatabase { occurrences in
                    self.occurrencesToDisplay = occurrences
//                    self.occurrenceTableView.reloadData()
                    print("table reloaded")
                }
            }
    }
    
//    @objc func didTapFilters() {
//        print("gotofiltrers")
//        self.navigationController?.pushViewController(OccurrenceFilterViewController(allOccurrences: occurrencesToDisplay), animated: true)
//    }
}

extension OccurrenceUserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if occurrencesToDisplay.isEmpty {
//            let alertController = UIAlertController(title: "Não foram encontradas ocorrências", message: "Não existem ocorrências", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//                self.navigationController?.popViewController(animated: true)
//            }
//            alertController.addAction(okAction)
//            present(alertController, animated: true, completion: nil)
//        }
        return userOccurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: CustomOcurrencetableViewCellTableViewCell.identifier, for: indexPath) as! CustomOcurrencetableViewCellTableViewCell)
        cell.selectionStyle = .none
        cell.configure(occurrence: userOccurrencies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let occurrence = userOccurrencies[indexPath.row]
        let detailVC = OcurrenceDetailViewController(selectedOccurrence: occurrence)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
