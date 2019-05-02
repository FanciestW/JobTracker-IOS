//
//  JobLocationViewController.swift
//  JobTracker
//
//  Created by William Lin on 4/28/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class JobLocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!

    var jobLocation = ""
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = jobLocation
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        let geocoder = CLGeocoder()
        if geocoder.isGeocoding { geocoder.cancelGeocode() }
        geocoder.geocodeAddressString(jobLocation, completionHandler: { placemarks, error in
            if (error != nil) {
                return
            }
            let location = placemarks![0].location
            let region = MKCoordinateRegion(center: location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            let mapAnnotation = MKPointAnnotation()
            mapAnnotation.coordinate = location!.coordinate
            self.mapView.setCenter(location!.coordinate, animated: true)
            self.mapView.setRegion(region, animated: true)
            self.mapView.addAnnotation(mapAnnotation)
        })
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: (locations.last?.coordinate)!, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(region, animated: true)

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
