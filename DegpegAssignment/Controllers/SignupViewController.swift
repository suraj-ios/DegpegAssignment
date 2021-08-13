//
//  SignupViewController.swift
//  DegpegAssignment
//
//  Created by Suraj Singh on 13/08/21.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginTextLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.registerButton.backgroundColor = UIColor.white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.openLoginScreenFunc))
        tapGesture.numberOfTapsRequired = 1
        self.loginTextLabel.addGestureRecognizer(tapGesture)
        self.loginTextLabel.isUserInteractionEnabled = true
        
        self.emailTextField.setLeftPaddingPoints(15)
        self.passwordTextField.setLeftPaddingPoints(15)
        
    }
    
    @objc func openLoginScreenFunc(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    
    @IBAction func registerAccountButtonFunc(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { authResult, error in
          if let error = error as? NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
                let alert = UIAlertView(title: "Alert", message: "The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            case .emailAlreadyInUse:
              // Error:
                let alert = UIAlertView(title: "Alert", message: "The email address is already in use by another account.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            case .invalidEmail:
              // Error:
                let alert = UIAlertView(title: "Alert", message: "The email address is badly formatted.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            case .weakPassword:
              // Error:
                let alert = UIAlertView(title: "Alert", message: "The password must be 6 characters long or more.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            default:
                print("Error: \(error.localizedDescription)")
                let alert = UIAlertView(title: "Alert", message: error.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
          } else {
            print("User signs up successfully")
            //let newUserInfo = Auth.auth().currentUser
            //let email = newUserInfo?.email
            
            self.openLoginScreen()
            
          }
        }
    }
    
    func openLoginScreen(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    
}
