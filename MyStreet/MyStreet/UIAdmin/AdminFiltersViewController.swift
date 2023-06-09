//
//  AdminFiltersViewController.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 21/03/2023.
//

import UIKit
import CoreLocation


class AdminFiltersViewController: UIViewController, CLLocationManagerDelegate {
    
    let occurrenceService = OccurrenceService()
//    var occurrenceToDisplay: [Occurrence]
    
    
//    var setTypeTitle: String!
    var setTypeButton = UIButton(frame: .zero)
    var setRadiusButton = UIButton(frame: .zero)
    var setStatusButton = UIButton(frame: .zero)
    
    enum FilterOccurrenceType: String {
        case light = "Iluminação Pública"
        case garbage = "Recolha de Lixo"
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
    
    enum FilterOccurrenceState: String {
        case close = "true"
        case open = "false"
        case none = ""
    }
    
    var locationManager: CLLocationManager!
    var hasRequestedAuthorization = false
    var userCurrentLocation: CLLocation?
    
    private var typeFilter: FilterOccurrenceType = .none
    private var distanceFilter: FilterOccurrenceDistance = .none
    private var stateFilter: FilterOccurrenceState = .none
    
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
    
    func filterOccurrencesDistance(from occurrences: [Occurrence]) -> [Occurrence] {
        switch distanceFilter {
        case .distance500, .distance1000, .distance2000, .distance5000, .distance10000:
            //filtrar
            var filterOccurrences: [Occurrence] = []
            for occ in self.occurrencesFiltered {
                let point = CLLocation(latitude: Double(occ.latitude)!, longitude: Double(occ.longitude)!)
                if point.distance(from: userCurrentLocation!) < Double(distanceFilter.rawValue)! {
                    filterOccurrences.append(occ)
                    print(occ.title)
                }
            }
            return filterOccurrences
        default:
            return occurrences
        }
    }
    
    func filterOccurrencesStatus(from occurrences: [Occurrence]) -> [Occurrence] {
        var filteredOccurrences: [Occurrence] = []

        switch stateFilter {
        case .open:
            filteredOccurrences = occurrences.filter { $0.state }
            return filteredOccurrences
        case .close:
            filteredOccurrences = occurrences.filter { !$0.state }
            return filteredOccurrences
        default:
            return occurrences
        }
        
    }
    
    func getOccurrences() {
        DispatchQueue.main.async {
                self.occurrenceService.getOccurrencesFromDatabase { occurrences,isEmpty in
                    self.occurrencesToFilter = occurrences
                    print("table reloaded")
                }
            }
    }
    
    init() {
        

        super.init(nibName: nil, bundle: nil)
        
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.backButtonTitle = ""
        getOccurrences()
        // MARK: - GET LOCATION
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        
        requestLocation()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.typeNotificationReceivedAdmin(_:)), name: NSNotification.Name(rawValue: "myTypeKeyAdmin"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.radiusNotificationReceivedAdmin(_:)), name: NSNotification.Name(rawValue: "myRadiusKeyAdmin"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.statusNotificationReceivedAdmin(_:)), name: NSNotification.Name(rawValue: "myStatusKeyAdmin"), object: nil)
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        navigationItem.title = "Filtragem ocorrências"
        
        let typeAction = UIAction() {_ in
            let vc = OccurrenceTypeFilterAdminViewControllerModal()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
        let radiusAction = UIAction() {_ in
            let vc = OccurrenceRadiusFilterAdminViewControllerModal()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
        let statusAction = UIAction() {_ in
            let vc = OccurrenceStatusFilterAdminViewControllerModal()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
        let action = UIAction() {_ in
            
            
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
            case "< 500 metros":
                self.distanceFilter = .distance500
            case "< 1 Kilómetro":
                self.distanceFilter = .distance1000
            case "< 2 Kilómetros":
                self.distanceFilter = .distance2000
            case "< 5 Kilómetros":
                self.distanceFilter = .distance5000
            case "< 10 Kilómetros":
                self.distanceFilter = .distance10000
            default:
                self.distanceFilter = .none
            }
            
            switch self.setStatusButton.currentTitle! {
            case "Resolvidas":
                self.stateFilter = .close
            case "Por Resolver":
                self.stateFilter = .open
            default:
                self.stateFilter = .none
            }
            
//            let filterTitles = "\(self.typeFilter.rawValue) \t \(self.distanceFilter.rawValue) \t \(self.stateFilter.rawValue)"


            // TODO: - EXECUTE FILTER
            self.occurrencesFiltered = self.filterOccurrencesType(from: self.occurrencesToFilter)
            
            self.occurrencesFiltered = self.filterOccurrencesDistance(from: self.occurrencesFiltered)
            
            self.occurrencesFiltered = self.filterOccurrencesStatus(from: self.occurrencesFiltered)
            self.reportAlert()
            
            print("self.setTypeButton.currentTitle!\(self.setTypeButton.currentTitle!)")
            print("self.setRadiusButton.currentTitle!\(self.setRadiusButton.currentTitle!)")
            print("self.setStatuButton.currentTitle!\(self.setStatusButton.currentTitle!)")
            
            
            
            let filteredOccVC = OccurrenceFilteredViewController(filteredOccurrences: self.occurrencesFiltered)
//            filteredOccVC.setTitle(title: filterTitles)
            
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
        
        setStatusButton = UIButton(type: .system, primaryAction: statusAction)
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.backgroundColor = .lightGray
        setStatusButton.setTitle("Estado", for: .normal)
        setStatusButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        setStatusButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        setStatusButton.setImage(image, for: .normal)
        setStatusButton.layer.cornerRadius = 8
        setStatusButton.setTitleColor(UIColor.label, for: .normal)
        setStatusButton.imageView?.trailingAnchor.constraint(equalTo: setStatusButton.trailingAnchor, constant: -20.0).isActive = true
        setStatusButton.imageView?.centerYAnchor.constraint(equalTo: setStatusButton.centerYAnchor, constant: 0.0).isActive = true
        setStatusButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        let applyButton = UIButton(type: .system, primaryAction: action)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.backgroundColor = .systemBlue
        applyButton.setTitle("APLICAR", for: .normal)
        applyButton.setTitleColor(UIColor.label, for: .normal)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        applyButton.layer.cornerRadius = 8
        
        view.addSubview(setTypeButton)
        view.addSubview(setRadiusButton)
        view.addSubview(setStatusButton)
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
            
            setStatusButton.topAnchor.constraint(equalTo: setRadiusButton.bottomAnchor, constant: 40),
            setStatusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setStatusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setStatusButton.heightAnchor.constraint(equalToConstant: 40),
            
            applyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            applyButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
    
    @objc func typeNotificationReceivedAdmin(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        print ("text: \(text)")
        setTypeButton.setTitle(text, for: .normal)
    }
    
    @objc func radiusNotificationReceivedAdmin(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        print ("text: \(text)")
        setRadiusButton.setTitle(text, for: .normal)
    }
    
    @objc func statusNotificationReceivedAdmin(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        print ("text: \(text)")
        setStatusButton.setTitle(text, for: .normal)
    }
    
    func reportAlert() {
        if occurrencesFiltered.isEmpty {
            let alertController = UIAlertController(title: "Não foram encontradas ocorrências", message: "Não existem ocorrências", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func requestLocation() {
        if CLLocationManager.locationServicesEnabled() {
            let authorizationStatus = locationManager.authorizationStatus
            switch authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
            case .notDetermined:
                if !hasRequestedAuthorization {
                    hasRequestedAuthorization = true
                    locationManager.requestWhenInUseAuthorization()
                }
            case .denied, .restricted:
                print("User didn't allow localization service.")
                break
            @unknown default:
                print("Something went wrong.")
                break
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("User didn't allow localization service.")
            break
        case .notDetermined:
            // Do nothing
            break
        @unknown default:
            break
        }
    }

}


extension AdminFiltersViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()
        print("user latitude = \(location.coordinate.latitude)")
        print("user longitude = \(location.coordinate.longitude)")
        print("user location \(location)")
//        self.occurrenceLatitude = String(format: "%f", location.coordinate.latitude)
//        self.occurrenceLongitude = String(format: "%f", location.coordinate.longitude)
        self.userCurrentLocation = location
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                print(placemark.subLocality!)
                print(placemark.postalCode!)
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)

            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}
