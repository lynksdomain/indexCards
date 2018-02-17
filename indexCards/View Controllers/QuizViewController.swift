//
//  QuizViewController.swift
//  indexCards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class QuizViewController: UIViewController {

    var front = FrontCard()
    var back = BackCard()
    var cards: [Card]!
    var showingFront = true
    var currentCard: Card?
    
    
    
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCard = cards[0]
        front.question.text = currentCard?.question
        self.mainView.addSubview(front)
        front.snp.makeConstraints { (make) in
            make.edges.equalTo(mainView.snp.edges)
        }
      
    }

    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        if (showingFront) {
            UIView.transition(from: front, to: back, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, completion: { (result) in
                self.mainView.addSubview(self.back)
                self.back.snp.makeConstraints { (make) in
                    make.edges.equalTo(self.mainView.snp.edges)
                }
               self.back.answer.text = self.currentCard?.answer
            })
            showingFront = false
        }else {
            UIView.transition(from: back, to: front, duration: 1, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: { (result) in
                self.mainView.addSubview(self.front)
                self.front.snp.makeConstraints { (make) in
                    make.edges.equalTo(self.mainView.snp.edges)
                }
                self.front.question.text = self.currentCard!.question
            })
            showingFront = true
        }
    }
    
    @IBAction func endQuizPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
    @IBAction func nextCardPressed(_ sender: UIButton) {
        if showingFront == true{
        currentCard = cards[1]
        self.mainView.addSubview(self.front)
        self.front.snp.makeConstraints { (make) in
            make.edges.equalTo(self.mainView.snp.edges)
        }
        self.front.question.text = self.currentCard!.question
        showingFront = true
        }else{
            currentCard = cards[1]
            UIView.transition(from: back, to: front, duration: 1, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: { (result) in
                self.mainView.addSubview(self.front)
                self.front.snp.makeConstraints { (make) in
                    make.edges.equalTo(self.mainView.snp.edges)
                }
                self.front.question.text = self.currentCard!.question
            })
            showingFront = true
            
        }
    }
    
}
