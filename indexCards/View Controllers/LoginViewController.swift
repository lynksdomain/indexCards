//
//  ViewController.swift
//  indexCards
//
//  Created by C4Q on 2/14/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AuthUserService.manager.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        AuthUserService.manager.createUser(withEmail: emailTF.text!, password: passTF.text!)
        
        let alertController = UIAlertController(title: "Success!", message: "User Created!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            self.resignFirstResponder()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        AuthUserService.manager.signIn(withEmail: emailTF.text!, password: passTF.text!)
        
    }
    

}

extension LoginViewController: AuthUserServiceDelegate{
    func didSignIn(_ userService: AuthUserService, user: AppUser) {
       present(categoryTableViewController.storyboardInstance(), animated: true, completion: nil)
    }
    
}


extension LoginViewController{
   public static func storyboardInstance() -> LoginViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return vc
    }
}

