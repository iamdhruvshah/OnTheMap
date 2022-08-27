//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Dhruv Shah on 22/03/22.
//

import UIKit

class LoginVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    let segueToMapViewID = "Logged In Successfully"
    let udacityURL = URL(string: "https://www.udacity.com")!
    
    //Load or unload View
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewState(isViewClickable: true)
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        self.emailTextField.text = nil
        self.passwordTextField.text = nil
        self.updateViewState(isViewClickable: true)
    }
    
    //IBActions
    @IBAction func loginRequested(_ sender: Any) {
        
        self.updateViewState(isViewClickable: false)
        UdacityAPI.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLogInResponse(success:errorMessage:))
    }
    
    @IBAction func sendToUdacity(_ sender: Any) {
        
        UIApplication.shared.open(self.udacityURL)
        
    }
    
    //Supporting Network Functions
    func postUdacitySession() -> Void {
        
    }
    
    func confirmLogIn(success: Bool, error: Error?) {
        if success {
            performSegue(withIdentifier: "LogInSuccessSegue", sender: self)
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failure", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        show(alertVC, sender: nil)
        updateViewState(isViewClickable: true)
    }
    
    //Completion Handlers
    func handleLogInResponse(success: Bool, errorMessage: String?) {
        if success {
            UdacityAPI.getUserInformationRequest(completion: confirmLogIn(success:error:))
        } else {
            showLoginFailure(message: errorMessage ?? "")
        }
    }
    
    
    //Supporting View Fuctions
    func updateViewState(isViewClickable: Bool) -> Void {
        loginButton.isEnabled = isViewClickable
        emailTextField.isEnabled = isViewClickable
        passwordTextField.isEnabled = isViewClickable
        if !isViewClickable {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
  
}
