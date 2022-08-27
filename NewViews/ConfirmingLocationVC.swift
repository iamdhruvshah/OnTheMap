//
//  ConfirmingLocationVC.swift
//  OnTheMap
//
//  Created by Dhruv Shah on 22/03/22.
//

import UIKit
import MapKit

class ConfirmingLocationVC: UIViewController, MKMapViewDelegate {

    //Map Data
    var newLocation = CLLocationCoordinate2D()
    var newLocationString = ""
    var newLocationURL = URL(string: "")
    var proposedAnnotation = MKPointAnnotation()

    @IBOutlet weak var confirmMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.confirmMapView.delegate = self
        self.proposedAnnotation.coordinate = self.newLocation
        self.proposedAnnotation.title = newLocationString
        self.proposedAnnotation.subtitle = newLocationURL?.absoluteString
        self.confirmMapView.centerCoordinate = self.newLocation
        self.confirmMapView.addAnnotations([proposedAnnotation])
    }
    

    @IBAction func finishAndPost(_ sender: Any) {
        UdacityAPI.postNewStudenLocation(newLatitude: self.newLocation.latitude, newLongitude: self.newLocation.longitude, locationString: self.newLocationString, locationMediaURL: self.newLocationURL?.absoluteString ?? "",  completion: {(results, error) in
            if error != nil {
            } else {
            }
        })
        
        UdacityAPI.getMapDataRequest(completion: { (studentLocationsArray, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                MapPins.mapPins = studentLocationsArray
            }
        })

        self.dismiss(animated: true, completion: {})
    }
}
