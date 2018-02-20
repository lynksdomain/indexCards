//
//  ViewController.swift
//  indexCards
//
//  Created by C4Q on 2/14/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import ChameleonFramework

class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        self.emailTF.resignFirstResponder()
        self.passTF.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthUserService.manager.delegate = self
        emailTF.delegate = self
        passTF.delegate = self
        self.view.backgroundColor = UIColor(gradientStyle: .leftToRight, withFrame: UIScreen.main.bounds, andColors: [FlatMint(), FlatWatermelon()])
        loginButton.backgroundColor = UIColor.clear
        signupButton.backgroundColor = UIColor.clear
        loginButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.setTitleColor(UIColor.white, for: .normal)
        
        
    }
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        AuthUserService.manager.createUser(withEmail: emailTF.text!, password: passTF.text!)
        
        
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        AuthUserService.manager.signIn(withEmail: emailTF.text!, password: passTF.text!)
    }
    

}

extension LoginViewController: AuthUserServiceDelegate{
    func didSignIn(_ userService: AuthUserService, user: AppUser) {
        
       present(categoryTableViewController.storyboardInstance(), animated: true, completion: nil)
    }
    func didFailSigningIn(_ userService: AuthUserService, error: Error) {
        let alertController = UIAlertController(title: "Error!", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func didFailCreatingUser(_ userService: AuthUserService, error: Error) {
        let alertController = UIAlertController(title: "Error!", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func didCreateUser(_ userService: AuthUserService, user: AppUser) {
        
        let alertController = UIAlertController(title: "Success!", message: "User Created!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            self.resignFirstResponder()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTF.resignFirstResponder()
        self.passTF.resignFirstResponder()
        return true
    }
    
}




extension LoginViewController{
   public static func storyboardInstance() -> LoginViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return vc
    }
}

