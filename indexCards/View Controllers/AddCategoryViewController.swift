//
//  AddCategoryViewController.swift
//  indexCards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import ChameleonFramework

class AddCategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DBService.manager.delegate = self
        self.view.backgroundColor = UIColor(gradientStyle: .leftToRight, withFrame: UIScreen.main.bounds, andColors: [FlatMint(), FlatWatermelon()])
        cancelButton.backgroundColor = UIColor.clear
        addButton.backgroundColor = UIColor.clear
       
    }

    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var categoryTF: UITextField!
    
    @IBAction func addCategoryPressed(_ sender: UIButton) {
        if categoryTF.text == "" || categoryTF.text == " "{
            
            let alertController = UIAlertController(title: "Error!", message: "Invalid Category Name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        DBService.manager.addCategory(name: categoryTF.text!)
        
        
    }
    
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        categoryTF.resignFirstResponder()
    }
    
    
    
    
     @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
     }
   
}

extension AddCategoryViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" || textField.text == " "{
            
            let alertController = UIAlertController(title: "Error!", message: "Invalid Category Name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            
        }
        
        categoryTF.resignFirstResponder()
        return true
        
        
    }
}




extension AddCategoryViewController: DBServiceDelegate{
    func didFailToAddCategory() {
        let alertController = UIAlertController(title: "Error!", message: "category already exists", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func didAddCategory() {
        self.dismiss(animated: true, completion:  nil)
    }
    
}

