//
//  AddCardViewController.swift
//  indexCards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import ChameleonFramework



class AddCardViewController: UIViewController {

    @IBOutlet weak var questionTF: UITextField!
    @IBOutlet weak var answerTF: UITextField!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    
    
    
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       questionTF.delegate = self
        answerTF.delegate = self
        DBService.manager.delegate = self
        self.view.backgroundColor = UIColor(gradientStyle: .leftToRight, withFrame: UIScreen.main.bounds, andColors: [FlatMint(), FlatWatermelon()])
        cancelButton.backgroundColor = UIColor.clear
        addButton.backgroundColor = UIColor.clear
    }

    @IBAction func addCardPressed(_ sender: UIButton) {
        if questionTF.text == "" || questionTF.text == " " || answerTF.text == " " || answerTF.text == " "{
            
            let alertController = UIAlertController(title: "Error!", message: "Invalid Input", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        DBService.manager.addCard(question: questionTF.text!, answer: answerTF.text!, category: category, correct: false)
   }
    
    

    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        questionTF.resignFirstResponder()
        answerTF.resignFirstResponder()
    }
    

}

extension AddCardViewController: DBServiceDelegate{
    func didAddCard() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didFailToAddCard() {
        let alertController = UIAlertController(title: "Error!", message: "Card question already exists", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
}




extension AddCardViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" || textField.text == " "{
            
            let alertController = UIAlertController(title: "Error!", message: "Invalid Input", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            
        }
        
        questionTF.resignFirstResponder()
        answerTF.resignFirstResponder()
        return true
    }
    
}



