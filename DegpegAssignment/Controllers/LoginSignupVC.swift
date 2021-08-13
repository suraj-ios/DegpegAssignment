//
//  ViewController.swift
//  DegpegAssignment
//
//  Created by Suraj Singh on 13/08/21.
//

import UIKit

class LoginSignupVC: UIViewController {
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        self.registerButton.backgroundColor = UIColor.white
        self.loginButton.backgroundColor = UIColor.white
        
    }
    
    //Summery//
    //Register onClick Button action to open Signup Screen//
    @IBAction func registerButtonFunc(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard?.instantiateViewController(identifier: "SignupViewController") as! SignupViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
        
    }
    
    //Summery//
    //Login onClick Button action to open Login Screen//
    @IBAction func loginButtonFunc(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    
}

