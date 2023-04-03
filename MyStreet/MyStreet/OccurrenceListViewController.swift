//
//  OcurrencyListViewController.swift
//  MyStreet
//
//  Created by Correia, Jose Bastos on 20/03/2023.
//

import UIKit

class OccurrenceListViewController: UIViewController {
    
    private let occurrenceTableView = UITableView()
    var occurrencesToDisplay: [Occurrence] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOccurrencesFromDatabase()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Ver Ocorrências"
        navigationItem.backButtonTitle = ""
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .done, target: self, action: #selector(didTapFilters))

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
    
    @objc func didTapFilters() {
        print("gotofiltrers")
        self.navigationController?.pushViewController(OccurrenceFilterViewController(), animated: true)
    }
}

extension OccurrenceListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG - \(occurrencesToDisplay.count)")
        return occurrencesToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: CustomOcurrencetableViewCellTableViewCell.identifier, for: indexPath) as! CustomOcurrencetableViewCellTableViewCell)
        cell.configure(occurence: occurrencesToDisplay[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let occurrence = occurrencesToDisplay[indexPath.row]
        let detailVC = OcurrenceDetailViewController(selectedOccurrence: occurrence)
        detailVC.selectedIndexPath = indexPath
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func getOccurrencesFromDatabase() {
        REF_OCCURRENCES.observeSingleEvent(of: .value) { (snapshot) in
            var occurrences = [Occurrence]()
            guard let snapshotValue = snapshot.value as? [String: Any] else {
                print("Snapshot value is nil")
                return
            }
            for occurrence in snapshotValue {
                guard let occurrenceData = occurrence.value as? [String: Any],
                      let title = occurrenceData["title"] as? String,
                      let location = occurrenceData["location"] as? String,
                      let type = occurrenceData["type"] as? String,
                      let description = occurrenceData["description"] as? String else {
                    print("Invalid occurrence data")
                    continue
                }
                let newOccurrence = Occurrence(title: title, location: location, type: type, description: description)
                occurrences.append(newOccurrence)
            }
            self.occurrencesToDisplay = occurrences
            print("DEBUG - getOccurrencesFunc\(self.occurrencesToDisplay)")
            self.occurrenceTableView.reloadData()
        }
    }

}

   
