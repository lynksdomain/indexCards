//
//  AppUser.swift
//  indexCards
//
//  Created by C4Q on 2/14/18.
//  Copyright © 2018 C4Q. All rights reserved.
//
import UIKit
import FirebaseAuth

class AppUser: NSObject {
    let email: String
    let uID: String
   
    init(email: String, uID: String) {
        self.email = email; self.uID = uID
    }
}

