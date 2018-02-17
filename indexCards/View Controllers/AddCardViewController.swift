//
//  AddCardViewController.swift
//  indexCards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController {

    @IBOutlet weak var questionTF: UITextField!
    @IBOutlet weak var answerTF: UITextField!
    
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(category)
        // Do any additional setup after loading the view.
    }

    @IBAction func addCardPressed(_ sender: UIButton) {
        DBService.manager.addCard(question: questionTF.text!, answer: answerTF.text!, category: category)
    }
    
    

    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
