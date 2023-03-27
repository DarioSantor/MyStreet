//
//  OcurrenceFilteredViewController.swift
//  MyStreet
//
//  Created by Correia, Jose Bastos on 25/03/2023.
//

import UIKit

class OccurrenceFilteredViewController: UIViewController {
    
    private let occurrenceTableView = UITableView()
    
    enum FilterOccurrenceType {
        case light
        case garbage
        case animals
        case asfalt
        case other
    }
    
    enum FilterOccurrenceDistance: Int {
        case distance500 = 500
        case distance1000 = 1000
        case distance2000 = 2000
        case distance5000 = 5000
        case distance10000 = 10000
    }
    
    private let typeFilter: FilterOccurrenceType
    private let distanceFilter: FilterOccurrenceDistance
    
    private var occurencesToDisplay: [Occurrence] = []

    
    init(typeFilter: FilterOccurrenceType, distanceFilter: FilterOccurrenceDistance, occurrences: [Occurrence]) {
        self.typeFilter = typeFilter
        self.distanceFilter = distanceFilter
        super.init()
        self.occurencesToDisplay = filteredOccurences(from: occurrences)
        
        
        
        
    }
    
    private func filteredOccurences(from occurrences: [Occurrence]) -> [Occurrence] {
        switch typeFilter {
        case .light:
            let filteredOccurrences = occurrences.filter { $0.type == "Iluminação Pública" }
            return filteredOccurrences
        case .garbage:
            let filteredOccurrences = occurrences.filter { $0.type == "Recolhe de Lixo" }
            return filteredOccurrences
        case .animals:
            let filteredOccurrences = occurrences.filter { $0.type == "Animais Abandonados" }
            return filteredOccurrences
        case .asfalt:
            let filteredOccurrences = occurrences.filter { $0.type == "Piso em Mau Estado" }
            return filteredOccurrences
        case .other:
            let filteredOccurrences = occurrences.filter { $0.type == "Outros" }
            return filteredOccurrences
        default:
            return occurrences
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
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

extension OccurrenceFilteredViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        occurrences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: CustomOcurrencetableViewCellTableViewCell.identifier, for: indexPath) as! CustomOcurrencetableViewCellTableViewCell)
        cell.configure(occurence: occurrences[indexPath.row])
        return cell
    }
}
