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
    var occurrencesToDisplay: [Occurrence] = []
//    var occurrences2 = [Occurrence(title:"Lâmpada partida", location: "Rua da Frente", type: "Iluminação Pública", description: "Lâmpada partida"),
//                       Occurrence(title:"Lâmpada partida", location: "Rua da Frente", type: "Iluminação Pública", description: "Lâmpada partida"),
//                       Occurrence(title:"Lâmpada partida", location: "Rua da Frente", type: "Iluminação Pública", description: "Lâmpada partida"),
//                       Occurrence(title:"Lâmpada partida", location: "Rua da Frente", type: "Iluminação Pública", description: "Lâmpada partida"),
//                       Occurrence(title:"Lâmpada partida", location: "Rua da Frente", type: "Iluminação Pública", description: "Lâmpada partida"),
//                       Occurrence(title:"Lâmpada partida", location: "Rua da Frente", type: "Iluminação Pública", description: "Lâmpada partida"),
//                       Occurrence(title:"Lâmpada partida", location: "Rua da Frente", type: "Iluminação Pública", description: "Lâmpada partida"),
//                       Occurrence(title:"Lâmpada partida", location: "Rua da Frente", type: "Iluminação Pública", description: "Lâmpada partida")]

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
        DispatchQueue.main.async {
                self.occurrenceService.getOccurrencesFromDatabase { occurrences in
                    self.occurrencesToDisplay = occurrences
                    self.occurrenceTableView.reloadData()
                    print("table reloaded")
                    print(self.occurrencesToDisplay)
                }
            }
    }
    
    @objc func didTapFilters() {
        print("gotofiltrers")
        self.navigationController?.pushViewController(OccurrenceFilterViewController(), animated: true)
    }
}

extension OccurrenceUserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return occurrencesToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: CustomOcurrencetableViewCellTableViewCell.identifier, for: indexPath) as! CustomOcurrencetableViewCellTableViewCell)
        cell.configure(occurrence: occurrencesToDisplay[indexPath.row])
        return cell
    }
}
