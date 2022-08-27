//
//  MapVC.swift
//  OnTheMap
//
//  Created by Dhruv Shah on 22/03/22.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
    //Map Data Variables
    var annotations = [MKPointAnnotation]()
    let annotationReuseId = "pin"
    var locations = [LocationResults]()
    
    //Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var networkBusy: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        if MapPins.mapPins.isEmpty {
            self.loadMapData()
        }
        self.locations = MapPins.mapPins
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mapView.addAnnotations(self.annotations)
        
    }
    
    //MapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: self.annotationReuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: self.annotationReuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .blue
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let urlToOpen = URL(string: view.annotation?.subtitle! ?? "") {
               UIApplication.shared.open(urlToOpen)
            }
        }
    }
    
    //Displaying Map Data
    func translateDictionaryToAnnotations(){
        for loc in locations {
            let lat = CLLocationDegrees(loc.latitude)
            let long = CLLocationDegrees(loc.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(loc.firstName) \(loc.lastName)"
            annotation.subtitle = loc.mediaURL
            
            annotations.append(annotation)
        }
    }
    
    func loadMapData() {
        self.networkBusy.startAnimating()
        UdacityAPI.getMapDataRequest(completion: { (studentLocationsArray, error) in
            if error != nil {
                self.showDownloadFailure(error?.localizedDescription ?? "")
            } else {
                MapPins.mapPins = studentLocationsArray
                self.locations = MapPins.mapPins
                self.translateDictionaryToAnnotations()
            }
            self.networkBusy.stopAnimating()
        })
    }
    
    //Actions
    @IBAction func refreshDataFromNetwork(_ sender: Any) {
        
        self.loadMapData()
        self.mapView.addAnnotations(self.annotations)
    }
    
    @IBAction func logout(_ sender: Any) {
       
        UdacityAPI.deleteSessionRequest()
        self.dismiss(animated: true, completion: {})
    }
    

    //Error Handling
    func showDownloadFailure(_ message: String) {
        let alertVC = UIAlertController(title: "Download Failure", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}

