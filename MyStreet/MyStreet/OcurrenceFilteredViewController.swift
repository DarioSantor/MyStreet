//
//  OcurrenceFilteredViewController.swift
//  MyStreet
//
//  Created by Correia, Jose Bastos on 25/03/2023.
//

import UIKit

class OccurrenceFilteredViewController: UIViewController {
    
    private let occurrenceTableView = UITableView()
    
    
//    private let typeFilter: FilterOccurrenceType
//    private let distanceFilter: FilterOccurrenceDistance
    
    private var occurrencesToDisplay: [Occurrence] = []

    func setTitle(title: String) {
        self.navigationItem.title = title
        print("set title runned")
    }
    
    init(filteredOccurrences: [Occurrence]) {
//        self.typeFilter = typeFilter
//        self.distanceFilter = distanceFilter
        
        self.occurrencesToDisplay = filteredOccurrences
        
//        print("occurrences\t\(filteredOccurrences)")
        super.init(nibName: nil, bundle: nil)
//        self.occurrencesToDisplay = filteredOccurrences(from: allOccurrences)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        occurrenceTableView.separatorStyle = .none

        view.backgroundColor = .systemBackground
        navigationItem.backButtonTitle = ""
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
    
//    @objc func didTapFilters() {
//        self.navigationController?.pushViewController(OccurrenceFilterViewController(), animated: true)
//    }
    
    
    
}

extension OccurrenceFilteredViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return occurrencesToDisplay.count > 0 ? occurrencesToDisplay.count : 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: CustomOcurrencetableViewCellTableViewCell.identifier, for: indexPath) as! CustomOcurrencetableViewCellTableViewCell)
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
