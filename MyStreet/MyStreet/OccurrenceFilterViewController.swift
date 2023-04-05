//
//  OccurrenceFilterViewController.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 22/03/2023.
//

import UIKit

class OccurrenceFilterViewController: UIViewController {
    
    
    
    enum FilterOccurrenceType: String {
        case light = "Iluminação Pública"
        case garbage = "Recolhe de Lixo"
        case animals = "Animais Abandonados"
        case asfalt = "Piso em Mau Estado"
        case other = "Outros"
        case none = "Todos os Tipos"
    }
    
    enum FilterOccurrenceDistance: String {
        case distance500 = "500"
        case distance1000 = "1000"
        case distance2000 = "2000"
        case distance5000 = "5000"
        case distance10000 = "10000"
        case none = ""
    }
    
    private var typeFilter: FilterOccurrenceType = .none
    private var distanceFilter: FilterOccurrenceDistance = .none
    
//    var setTypeTitle: String!
    var setTypeButton = UIButton(frame: .zero)
    var setRadiusButton = UIButton(frame: .zero)
    var occurrencesToFilter: [Occurrence] = []
    var occurrencesFiltered: [Occurrence] = []
    
    func filterOccurrencesType(from occurrences: [Occurrence]) -> [Occurrence] {
        switch typeFilter {
        case .light, .garbage, .animals, .asfalt, .other:
            let filteredOccurrences = occurrences.filter { $0.type == typeFilter.rawValue }
            return filteredOccurrences
        default:
            return occurrences
        }
    }
    
    
    init(allOccurrences: [Occurrence]) {
        self.occurrencesToFilter = allOccurrences
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .label
//        navigationItem.setHidesBackButton(true, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.typeNotificationReceived(_:)), name: NSNotification.Name(rawValue: "myTypeKey"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.radiusNotificationReceived(_:)), name: NSNotification.Name(rawValue: "myRadiusKey"), object: nil)
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        
//        navigationItem.hidesBackButton = false
        navigationItem.backButtonTitle = ""
//
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "oi", style: .plain, target: nil, action: nil)
        
        
        self.navigationItem.title = "Filtragem ocorrências"
        self.navigationItem.backBarButtonItem?.title = ""
        
        let typeAction = UIAction() {_ in
            let vc = OccurrenceTypeFilterViewControllerModal()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
        let radiusAction = UIAction() {_ in
            let vc = OccurrenceRadiusFilterViewControllerModal()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
        let action = UIAction() {_ in
            
            // MARK: - SETTING ENUM TO EXECUTE FILTERS
            
            print(typeAction.attributes.isEmpty)
            
            switch self.setTypeButton.currentTitle! {
            case "Iluminação Pública":
                self.typeFilter = .light
            case "Recolha de Lixo":
                self.typeFilter = .garbage
            case "Animais Abandonados":
                self.typeFilter = .animals
            case "Piso em Mau Estado":
                self.typeFilter = .asfalt
            case "Outros":
                self.typeFilter = .other
            default:
                self.typeFilter = .none
            }
            
            switch self.setRadiusButton.currentTitle! {
            case "500 metros":
                self.distanceFilter = .distance500
            case "1 Kilómetro":
                self.distanceFilter = .distance1000
            case "2 Kilómetros":
                self.distanceFilter = .distance2000
            case "5 Kilómetros":
                self.distanceFilter = .distance5000
            case "10 Kilómetros":
                self.distanceFilter = .distance1000
            default:
                self.distanceFilter = .none
            }
            
            let filterTitles = "\(self.typeFilter.rawValue) \t \(self.distanceFilter.rawValue)"
            
            // TODO: - EXECUTE FILTER
            self.occurrencesFiltered = self.filterOccurrencesType(from: self.occurrencesToFilter)
            
            
            print("self.setTypeButton.currentTitle!\(self.setTypeButton.currentTitle!)")
            print("self.setTypeButton.currentTitle!\(self.setRadiusButton.currentTitle!)")
            
            let filteredOccVC = OccurrenceFilteredViewController(filteredOccurrences: self.occurrencesFiltered)
            filteredOccVC.setTitle(title: filterTitles)
            self.navigationController?.pushViewController(filteredOccVC, animated: true)
        }
        
        let image = UIImage(systemName: "arrowtriangle.down.circle")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        
        setTypeButton = UIButton(type: .system, primaryAction: typeAction)
        setTypeButton.translatesAutoresizingMaskIntoConstraints = false
        setTypeButton.backgroundColor = .lightGray
        setTypeButton.setTitle("Tipo", for: .normal)
        setTypeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        setTypeButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        setTypeButton.setImage(image, for: .normal)
        setTypeButton.layer.cornerRadius = 8
        setTypeButton.setTitleColor(UIColor.label, for: .normal)
        setTypeButton.imageView?.trailingAnchor.constraint(equalTo: setTypeButton.trailingAnchor, constant: -20.0).isActive = true
        setTypeButton.imageView?.centerYAnchor.constraint(equalTo: setTypeButton.centerYAnchor, constant: 0.0).isActive = true
        setTypeButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        setRadiusButton = UIButton(type: .system, primaryAction: radiusAction)
        setRadiusButton.translatesAutoresizingMaskIntoConstraints = false
        setRadiusButton.backgroundColor = .lightGray
        setRadiusButton.setTitle("Raio", for: .normal)
        setRadiusButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        setRadiusButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        setRadiusButton.setImage(image, for: .normal)
        setRadiusButton.layer.cornerRadius = 8
        setRadiusButton.setTitleColor(UIColor.label, for: .normal)
        setRadiusButton.imageView?.trailingAnchor.constraint(equalTo: setRadiusButton.trailingAnchor, constant: -20.0).isActive = true
        setRadiusButton.imageView?.centerYAnchor.constraint(equalTo: setRadiusButton.centerYAnchor, constant: 0.0).isActive = true
        setRadiusButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        let applyButton = UIButton(type: .system, primaryAction: action)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.backgroundColor = .systemBlue
        applyButton.setTitle("APLICAR", for: .normal)
        applyButton.setTitleColor(UIColor.label, for: .normal)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        applyButton.layer.cornerRadius = 8
        
        view.addSubview(setTypeButton)
        view.addSubview(setRadiusButton)
        view.addSubview(applyButton)
        
        NSLayoutConstraint.activate([
            setTypeButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            setTypeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setTypeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setTypeButton.heightAnchor.constraint(equalToConstant: 40),
            
            setRadiusButton.topAnchor.constraint(equalTo: setTypeButton.bottomAnchor, constant: 40),
            setRadiusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setRadiusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setRadiusButton.heightAnchor.constraint(equalToConstant: 40),
            
            applyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            applyButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
    
    
    
    
    @objc func typeNotificationReceived(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        print ("text: \(text)")
        setTypeButton.setTitle(text, for: .normal)
    }
    
    @objc func radiusNotificationReceived(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        print ("text: \(text)")
        setRadiusButton.setTitle(text, for: .normal)
    }
}
