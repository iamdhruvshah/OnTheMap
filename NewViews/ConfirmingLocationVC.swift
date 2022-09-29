//
//  ConfirmingLocationVC.swift
//  OnTheMap
//
//  Created by Dhruv Shah
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
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: self.proposedAnnotation.coordinate, span: span)
        self.confirmMapView.setRegion(region, animated: true)
        self.confirmMapView.addAnnotations([proposedAnnotation])
    }
    
    func showAlert(_ message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alertVC, animated: true)
        }
    }
    
    @IBAction func finishAndPost(_ sender: Any) {
        UdacityAPI.postNewStudenLocation(newLatitude: self.newLocation.latitude, newLongitude: self.newLocation.longitude, locationString: self.newLocationString, locationMediaURL: self.newLocationURL?.absoluteString ?? "") { (results, error) in
            if error != nil {
                self.showAlert(error!.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            UdacityAPI.getMapDataRequest(completion: { (studentLocationsArray, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    MapPins.mapPins = studentLocationsArray
                }
            })
        }
    }
}
