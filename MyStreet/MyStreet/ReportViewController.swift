//
//  ReportViewController.swift
//  MyStreet
//
//  Created by Cerqueira, Fabio Galante on 20/03/2023.
//

import UIKit
import CoreLocation
import FirebaseStorage

class ReportViewController: UIViewController, UITextViewDelegate, CLLocationManagerDelegate {
    
    private let reportLocationField = CustomTextField(fieldType: .location)
    private let reportTitleField = CustomTextField(fieldType: .reportTitle)
    var setTypeButton = UIButton(frame: .zero)
    private let reportDescriptonField = UITextView()
    var buttonText: String? = ""
    var locationManager: CLLocationManager!
    let reportImage = UIImageView(image: UIImage(systemName: "camera"))
    var hasRequestedAuthorization = false

    
    private var keyboardHeight: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Reportar Ocorrência"
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        
        requestLocation()
        
        reportDescriptonField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let locationImg = UIImageView(image: UIImage(named: "gps")?.withTintColor(UIColor.label))
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.typeNotificationReceived(_:)), name: NSNotification.Name(rawValue: "myTypeKey"), object: nil)
        
        locationImg.backgroundColor = .secondarySystemBackground
        locationImg.layer.borderColor = CGColor(gray: 10, alpha: 5)
        locationImg.layer.cornerRadius = 8
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.locationImageTapped))
        locationImg.addGestureRecognizer(tapGR)
        locationImg.isUserInteractionEnabled = true
        
        reportDescriptonField.backgroundColor = .secondarySystemBackground
        reportDescriptonField.font = UIFont.systemFont(ofSize: 20)
        reportDescriptonField.text = " Descrição"
        reportDescriptonField.textColor = UIColor.lightGray
        reportDescriptonField.layer.cornerRadius = 8
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(reportImageTapped))
        reportImage.backgroundColor = .secondarySystemBackground
        reportImage.layer.cornerRadius = 8
        reportImage.addGestureRecognizer(tapGestureRecognizer)
        reportImage.isUserInteractionEnabled = true
        reportImage.contentMode = .scaleAspectFit
        
        let typeAction = UIAction() {_ in
            let vc = OccurrenceTypeFilterViewControllerModal()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
        let image = UIImage(systemName: "arrowtriangle.down.circle")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        
        setTypeButton = UIButton(type: .system, primaryAction: typeAction)
        setTypeButton.translatesAutoresizingMaskIntoConstraints = false
        setTypeButton.backgroundColor = .secondarySystemBackground
        setTypeButton.setTitle("Tipo", for: .normal)
        setTypeButton.tintColor = .lightGray
        setTypeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        setTypeButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        setTypeButton.setImage(image, for: .normal)
        setTypeButton.layer.cornerRadius = 8
        
        setTypeButton.setTitleColor(UIColor.label, for: .normal)
        setTypeButton.imageView?.trailingAnchor.constraint(equalTo: setTypeButton.trailingAnchor, constant: -20.0).isActive = true
        setTypeButton.imageView?.centerYAnchor.constraint(equalTo: setTypeButton.centerYAnchor, constant: 0.0).isActive = true
        setTypeButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        let reportAction = UIAction {_ in
            guard let location = self.reportLocationField.text,
                  let title = self.reportTitleField.text,
                  let type = self.buttonText,
                  let description = self.reportDescriptonField.text,
                  let imageToCompress = self.reportImage.image?.jpegData(compressionQuality: 0.5),
                  let currentUserUID = UserDefaults.standard.string(forKey: "myUID") else {
                print("early exit")
                return
            }
            
            // Store the image in Firebase Storage
            let filename = NSUUID().uuidString
            let storageRef = STORAGE_OCCURRENCES_IMAGES.child(filename)
            storageRef.putData(imageToCompress, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                } else {
                    // Get the download URL for the image and add it to the report data
                    storageRef.downloadURL { (url, error) in
                        if let error = error {
                            print("Error getting download URL: \(error.localizedDescription)")
                        } else {
                            guard let imageUrl = url else { return }
                            let values = ["location": location, "title": title, "type": type, "description": description, "userUID": currentUserUID, "imageUrl": imageUrl.absoluteString]

                            // Store the report data in Firebase Realtime Database
                            let newReportRef = REF_OCCURRENCES.childByAutoId()
                            newReportRef.setValue(values) { (error, ref) in
                                if let error = error {
                                    print("Error adding new report: \(error.localizedDescription)")
                                } else {
                                    print("Successfully added new report")
                                    self.navigationController?.pushViewController(ConfirmationViewController(), animated: true)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        let submitBtn = UIButton(type: .system, primaryAction: reportAction)
        submitBtn.setTitle("SUBMETER", for: .normal)
        submitBtn.backgroundColor = .systemBlue
        submitBtn.setTitleColor(UIColor.label, for: .normal)
        submitBtn.layer.cornerRadius = 8
        submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        
        let items = [
            reportLocationField,
            locationImg,
            reportTitleField,
            reportDescriptonField,
            reportImage,
            submitBtn,
            setTypeButton
        ]
        
        for item in items {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
        
        NSLayoutConstraint.activate([
            
            reportLocationField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant:20),
            reportLocationField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportLocationField.trailingAnchor.constraint(equalTo: locationImg.leadingAnchor,constant:-20),
            reportLocationField.heightAnchor.constraint(equalToConstant:40),
            
            locationImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:20),
            locationImg.leadingAnchor.constraint(equalTo: reportLocationField.trailingAnchor,constant:20),
            locationImg.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            locationImg.bottomAnchor.constraint(equalTo: reportLocationField.bottomAnchor),
            locationImg.heightAnchor.constraint(equalToConstant:40),
            locationImg.widthAnchor.constraint(equalToConstant:40),
            
            reportTitleField.topAnchor.constraint(equalTo: reportLocationField.bottomAnchor,constant:10),
            reportTitleField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportTitleField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            reportTitleField.bottomAnchor.constraint(equalTo: setTypeButton.topAnchor,constant:-10),
            reportTitleField.heightAnchor.constraint(equalToConstant:40),
            
            setTypeButton.topAnchor.constraint(equalTo: reportTitleField.bottomAnchor),
            setTypeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setTypeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setTypeButton.heightAnchor.constraint(equalToConstant: 40),
            setTypeButton.bottomAnchor.constraint(equalTo: reportDescriptonField.topAnchor,constant:-10),
            
            reportDescriptonField.topAnchor.constraint(equalTo: setTypeButton.bottomAnchor,constant:40),
            reportDescriptonField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportDescriptonField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            reportDescriptonField.heightAnchor.constraint(equalToConstant:200),
            
            reportImage.topAnchor.constraint(equalTo: reportDescriptonField.bottomAnchor,constant:10),
            reportImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            reportImage.heightAnchor.constraint(equalToConstant: 200),
            reportImage.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
            
            submitBtn.topAnchor.constraint(equalTo: reportImage.bottomAnchor,constant:40),
            submitBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            submitBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20),
        ])
    }
    
    @objc func locationImageTapped() {
        // TODO: Pick location in a map
    }
    
    @objc func reportImageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        print("image")

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(actionSheet, animated: true, completion: nil)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = " Descrição"
            textView.textColor = UIColor.lightGray
            textView.alpha = 0.7
        }
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?NSValue else { return }
        keyboardHeight = keyboardSize.cgRectValue.height
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -self.keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func typeNotificationReceived(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        print ("text: \(text)")
        buttonText = text
        setTypeButton.setTitle(text, for: .normal)
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()
        print("user latitude = \(location.coordinate.latitude)")
        print("user longitude = \(location.coordinate.longitude)")
        
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
                DispatchQueue.main.async {
                    self.reportLocationField.text = placemark.postalCode!
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

extension ReportViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            reportImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

