//
//  QuizViewController.swift
//  indexCards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    
    var cards: [Card]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UIGestureRecognizer(target: self, action: #selector(flip))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)       
    }

    @objc func flip(){
        
    }
   
    
    
    
    @IBAction func endQuizPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextCardPressed(_ sender: UIButton) {
    }
    
}
