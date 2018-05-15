//
//  Card.swift
//  indexCards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation


struct Card{
    let question: String
    let answer: String
    let uID: String
    let category: String
    let correct: Bool
    let cardID: String
    
    init(question: String,answer: String, uID: String , category: String, correct: Bool, cardID: String) {
        self.question = question
        self.answer = answer
        self.uID = uID
        self.category = category
        self.correct = correct
        self.cardID = cardID
    }
}

