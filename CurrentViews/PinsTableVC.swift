//
//  PinsTableVC.swift
//  OnTheMap
//
//  Created by Dhruv Shah on 22/03/22.
//

import UIKit


class PinsTableVC: UITableViewController {

    var locations = [LocationResults]()
    var networkActivity = UIActivityIndicatorView()
    
    //Loading functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addActivityIndicator()
        if MapPins.mapPins.isEmpty {
            self.loadMapData()
        }
        self.locations = MapPins.mapPins
    }
    
    func addActivityIndicator() {
        self.networkActivity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        self.networkActivity.style = UIActivityIndicatorView.Style.medium
        self.networkActivity.center = self.view.center
        self.networkActivity.hidesWhenStopped = true
        self.view.addSubview(self.networkActivity)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    //Table view data source
    func loadMapData() {
        self.networkActivity.startAnimating()
        UdacityAPI.getMapDataRequest(completion: { (studentLocationsArray, error) in
            if error != nil {
                self.showDownloadFailure(error?.localizedDescription ?? "")
            } else {
                MapPins.mapPins = studentLocationsArray
            }
            self.networkActivity.stopAnimating()
        })
    }
    
    //Table View Control
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapPinCell", for: indexPath) as! TableCell
        cell.title.text = "\(self.locations[indexPath.row].firstName) \(self.locations[indexPath.row].lastName)"
        cell.subtitle.text = "\(self.locations[indexPath.row].mediaURL)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urlToOpen = URL(string: self.locations[indexPath.row].mediaURL) {
           UIApplication.shared.open(urlToOpen)
        }
    }
    
    //IBActions
    @IBAction func refreshMapData(_ sender: Any) {
        
        self.loadMapData()
        self.locations = MapPins.mapPins
        self.tableView.reloadData()
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

