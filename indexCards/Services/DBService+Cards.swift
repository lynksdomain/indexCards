//
//  DBService+Cards.swift
//  indexCards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

extension DBService{
    
    
    func addCard(question: String, answer: String, category: String, correct: Bool){
        for card in cards{
            if card.question == question{
                self.delegate?.didFailToAddCard!()
                return
            }
        }
        guard let currentUser = AuthUserService.getCurrentUser() else {print("could not get current user"); return}
        let ref = cardRef.childByAutoId()
        let card = Card(question: question, answer: answer, uID: currentUser.uid, category: category, correct: correct, cardID: ref.key)
        ref.setValue(["question": card.question,
                      "answer": card.answer,
                      "uID": card.uID,
                      "category": card.category,
                      "correct": card.correct,
                      "cardID": card.cardID
                      ])
        self.delegate?.didAddCard!()
    }
    
    
    func editCard(){
        
    }
    
    
    
    
    public func getCards(completion: @escaping (_ category: [Card]) -> Void) {
        cardRef.observe(.value) { (dataSnapshot) in
            var cards = [Card]()
            guard let cardSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for cardSnapshot in cardSnapshots {
                guard let cardObject = cardSnapshot.value as? [String: Any] else {
                    return
                }

                guard let question = cardObject["question"] as? String,
                let answer = cardObject["answer"] as? String,
                let uID = cardObject["uID"] as? String,
                let category = cardObject["category"] as? String,
                let correct = cardObject["correct"] as? Bool,
                let cardID = cardObject["cardID"] as? String
                else { print("error getting posts");return}

                let thisCard = Card(question: question, answer: answer, uID: uID, category: category, correct: correct, cardID: cardID)
                cards.append(thisCard)

            }
            guard let userId = AuthUserService.getCurrentUser()?.uid else {print("cant get current users categories"); return}
            cards = cards.filter{ $0.uID ==  userId}
            DBService.manager.cards = cards
            completion(cards)
        }
    }


    
    
    
    
    
}
