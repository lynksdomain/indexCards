//
//  DBService.swift
//  indexCards
//
//  Created by C4Q on 2/14/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

@objc protocol DBServiceDelegate: class {
   @objc optional func didFailToAddCategory()
   @objc optional func didAddCategory()
    @objc optional func didAddCard()
    @objc optional func didFailToAddCard()
    
}

class DBService: NSObject {
    
    private override init() {
        
        rootRef = Database.database().reference()
        usersRef = rootRef.child("users")
        categoryRef = rootRef.child("categories")
        cardRef = rootRef.child("cards")
        super.init()
        
    }
    
    static let manager = DBService()
   
    var categories = [Category]()
    
    var cards = [Card]()
    
    
    var cardRef: DatabaseReference!
    var categoryRef: DatabaseReference!
    var rootRef: DatabaseReference!
    var usersRef: DatabaseReference!
   
    public weak var delegate: DBServiceDelegate?
    
   
    
    
}
