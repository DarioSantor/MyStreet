//
//  OcurrencyListViewController.swift
//  MyStreet
//
//  Created by Correia, Jose Bastos on 20/03/2023.
//

import UIKit

class OccurrenceListViewController: UIViewController {
    
    private let occurrenceTableView = UITableView()
    let occurrenceService = OccurrenceService()
    var occurrencesToDisplay: [Occurrence] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.occurrenceService.getOccurrencesFromDatabase { occurrences, isEmpty in
                self.occurrencesToDisplay = occurrences
                self.occurrenceTableView.reloadData()
                print("table reloaded")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        occurrenceTableView.separatorStyle = .none
        NSLayoutConstraint.activate([
            occurrenceTableView.topAnchor.constraint(equalTo: view.topAnchor),
            occurrenceTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            occurrenceTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            occurrenceTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            occurrenceTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        DispatchQueue.main.async {
            self.occurrenceService.getOccurrencesFromDatabase { occurrences, isEmpty in
                if isEmpty {
                    let alertController = UIAlertController(title: "Não foram encontradas ocorrências", message: "Não existem ocorrências", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)

                } else {
                    self.occurrencesToDisplay = occurrences
                    print("occurrences loaded: \(self.occurrencesToDisplay.count)")
                    self.occurrenceTableView.reloadData()
                }
            }
            }
    }
    
    @objc func didTapFilters() {
        print("gotofiltrers")
        self.navigationController?.pushViewController(OccurrenceFilterViewController(allOccurrences: occurrencesToDisplay), animated: true)
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
        cell.selectionStyle = .none
        cell.configure(occurrence: occurrencesToDisplay[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let occurrence = occurrencesToDisplay[indexPath.row]
        let detailVC = OcurrenceDetailViewController(selectedOccurrence: occurrence)
//        detailVC.selectedIndexPath = indexPath
        navigationController?.pushViewController(detailVC, animated: true)
    }
    

}
   
