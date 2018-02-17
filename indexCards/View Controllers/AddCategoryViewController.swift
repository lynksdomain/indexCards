//
//  AddCategoryViewController.swift
//  indexCards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    @IBOutlet weak var categoryTF: UITextField!
    
    @IBAction func addCategoryPressed(_ sender: UIButton) {
        DBService.manager.addCategory(name: categoryTF.text!)
        
    }
    
     @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
     }
   
}
