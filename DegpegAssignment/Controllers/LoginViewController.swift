//
//  LoginViewController.swift
//  DegpegAssignment
//
//  Created by Suraj Singh on 13/08/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupTextLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.loginButton.backgroundColor = UIColor.white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.openSignupScreenFunc))
        tapGesture.numberOfTapsRequired = 1
        self.signupTextLabel.addGestureRecognizer(tapGesture)
        self.signupTextLabel.isUserInteractionEnabled = true
        
        self.emailTextField.setLeftPaddingPoints(15)
        self.passwordTextField.setLeftPaddingPoints(15)
        
    }
    
    @objc func openSignupScreenFunc(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard?.instantiateViewController(identifier: "SignupViewController") as! SignupViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    
    @IBAction func loginAccountButtonFunc(_ sender: Any) {
        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (authResult, error) in
          if let error = error as? NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
              // Error:
                let alert = UIAlertView(title: "Alert", message: "Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            case .userDisabled:
              // Error:
                let alert = UIAlertView(title: "Alert", message: "The user account has been disabled by an administrator.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            case .wrongPassword:
              // Error:
                let alert = UIAlertView(title: "Alert", message: "The password is invalid or the user does not have a password.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            case .invalidEmail:
              // Error:
                let alert = UIAlertView(title: "Alert", message: "Indicates the email address is malformed.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            default:
                print("Error: \(error.localizedDescription)")
                let alert = UIAlertView(title: "Alert", message: error.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
          } else {
            print("User signs in successfully")
            //let userInfo = Auth.auth().currentUser
            //let email = userInfo?.email
            
            let defaults = UserDefaults.standard
            defaults.setValue("true", forKey: "LoggedIn")
            defaults.synchronize()
            
            self.openHomePageScreen()
            
          }
        }
    }
    
    func openHomePageScreen(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        let navBar = UINavigationController(rootViewController: destination)
        navBar.modalPresentationStyle = .fullScreen
        self.present(navBar, animated: false, completion: nil)
    }
    
}
