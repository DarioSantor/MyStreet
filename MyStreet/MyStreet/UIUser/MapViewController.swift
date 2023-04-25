//
//  MapViewController.swift
//  MyStreet
//
//  Created by Dario Santos on 17/04/2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    var userLocation: CLLocation?
    var completionHandler: ((CLLocation) -> Void)?
    private let mapView = MKMapView()
    var closeButton: UIButton! = nil
    
    init(location: CLLocation) {
        self.userLocation = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        mapView.showsUserLocation = true
        let action = UIAction() {_ in
            self.dismiss(animated: true)
        }
        let image = UIImage(systemName: "xmark.circle")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        closeButton = UIButton(type: .system, primaryAction: action)
        closeButton.setImage(image, for: .normal)
        closeButton.layer.cornerRadius = 8
        mapView.delegate = self
        print("DEBUG - ULMVC\(String(describing: userLocation))")
        view.addSubview(mapView)
        view.addSubview(closeButton)
        let location = CLLocationCoordinate2D(latitude: userLocation?.coordinate.latitude ?? 38.75286157642966, longitude: userLocation?.coordinate.longitude ?? -9.184752546055385)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])

        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        mapView.addGestureRecognizer(longPressRecognizer)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler(_:)))
        view.addGestureRecognizer(panGesture)
    }

    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let point = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            completionHandler?(location)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func panGestureHandler(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .ended && gesture.translation(in: view).y > 0 {
            dismiss(animated: true, completion: nil)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let location = userLocation.location {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
}
