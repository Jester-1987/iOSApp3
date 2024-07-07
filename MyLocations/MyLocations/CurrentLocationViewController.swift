//
//  ViewController.swift
//  MyLocations
//
//  Created by Nicole Groeger on 2024-07-02.
//

import UIKit
import CoreLocation

class CurrentLocationViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    
    // MARK: - Actions
    @IBAction func getLocation() {
        let authStatus = locationManager.authorizationStatus
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            if authStatus == .denied || authStatus == .restricted {
              showLocationServicesDeniedAlert()
              return
            }

        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("didFailWithError \(error.localizedDescription)")
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        let newLocation = locations.last!
        print("didUpdateLocations \(newLocation)")
    }
    
    // MARK: - Helper Methods
    func showLocationServicesDeniedAlert() {
      let alert = UIAlertController(
        title: "Location Services Disabled",
        message: "Please enable location services for this app in Settings.",
        preferredStyle: .alert)

      let okAction = UIAlertAction(
        title: "OK",
        style: .default,
        handler: nil)
      alert.addAction(okAction)

      present(alert, animated: true, completion: nil)
    }

}

