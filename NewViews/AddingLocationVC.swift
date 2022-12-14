//
//  AddingLocationVC.swift
//  OnTheMap
//
//  Created by Dhruv Shah
//

import UIKit
import CoreLocation

class AddingLocationVC: UIViewController {
    let confirmingLocationSegueId = "confirmingLocationSegue"
    var newLocation = CLLocationCoordinate2D()
    
    @IBOutlet weak var errorLabelView: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorLabelView.isHidden = true
    }

    //Location Button Pressed
    @IBAction func findLocationRequest(_ sender: Any) {
        
        if self.urlTextField.text == nil || self.urlTextField.text == "" {
            self.showErrorAlert("Please insert a URL for this location")
        } else {
            let geoCoder = CLGeocoder()
            activityIndicator.startAnimating()
            geoCoder.geocodeAddressString(self.locationTextField.text ?? "", completionHandler: { (placemark, error) in
                if error != nil {
                    self.showErrorAlert(error!.localizedDescription)
                    self.activityIndicator.stopAnimating()
                } else {
                    if let newPlacemark = placemark?.first, let newLoc = newPlacemark.location?.coordinate {
                        self.newLocation = newLoc
                        self.performSegue(withIdentifier: self.confirmingLocationSegueId, sender: self)
                    } else {
                        print("There was an error while searching for coordinate(s)!")
                    }
                }
            })
        }
        
    }
    
    //Cancel
    @IBAction func cancelNewLocation(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    //Error Alert
    func showErrorAlert(_ message: String) {
        self.errorLabelView.text = "ERROR Occurred: \(message)"
        self.errorLabelView.isHidden = false
    }
    
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.confirmingLocationSegueId {
            let controller = segue.destination as! ConfirmingLocationVC
            controller.newLocation = self.newLocation
            controller.newLocationString = self.locationTextField.text ?? ""
            controller.newLocationURL = URL(string: self.urlTextField.text ?? "")
        }
    }

}

