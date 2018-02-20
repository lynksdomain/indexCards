//
//  QuizViewController.swift
//  indexCards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import ChameleonFramework

class QuizViewController: UIViewController {

    var front = FrontCard()
    var back = BackCard()
    var cards: [Card]!
    var showingFront = true
    var currentCard: Card?
    var pickedCards = [Int]()
    
    
    
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetUp()
    }
    
    
    @IBOutlet weak var nextCard: UIButton!
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        self.flipTheCardView()
    }
    
    @IBAction func endQuizPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
  
    

    
    @IBAction func nextCardPressed(_ sender: UIButton) {
        if cards.count == pickedCards.count{
            let alert = UIAlertController(title: "You've Reached The End!", message: "Would you like to try again?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
                self.pickedCards.removeAll()
                self.setTheNextCard()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (result) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion:{
                
            })
            return
        }
        setTheNextCard()
    }
    

}


extension QuizViewController{
    
    
    func initialSetUp(){
        self.view.backgroundColor = UIColor(gradientStyle: .leftToRight, withFrame: UIScreen.main.bounds, andColors: [FlatMint(), FlatWatermelon()])
        currentCard = randomCard()
        front.question.text = currentCard?.question
        self.mainView.addSubview(front)
        front.snp.makeConstraints { (make) in
            make.edges.equalTo(mainView.snp.edges)
        }
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 1
        mainView.layer.shadowOffset = CGSize.zero
        mainView.layer.shadowRadius = 10
        nextCard.backgroundColor = UIColor.clear
        nextCard.setTitleColor(UIColor.white, for: .normal)
    }
    
    
    func randomCard() -> Card {
        while true {
            let randomNum = Int(arc4random_uniform(UInt32(cards.count)))
            
            if !pickedCards.contains(randomNum){
                pickedCards.append(randomNum)
                return cards[randomNum]
            }
        }
    }
    
    
    
    func setTheNextCard(){
        if showingFront == true{
            currentCard = randomCard()
            self.mainView.addSubview(self.front)
            self.front.snp.makeConstraints { (make) in
                make.edges.equalTo(self.mainView.snp.edges)
            }
            self.front.question.text = self.currentCard!.question
            showingFront = true
        }else{
            currentCard = randomCard()
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
    
    
    func flipTheCardView(){
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
    
    
    
    
}
