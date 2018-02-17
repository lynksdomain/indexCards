//
//  CardTableViewController.swift
//  indexCards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController {
    var cards = [Card](){
        didSet{
            tableView.reloadData()
        }
    }
    var category: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        DBService.manager.getCards { (cards) in
            self.cards = cards.filter(){$0.category == self.category}
            if self.cards.count == 0{
                let alert = UIAlertController(title: "No Cards Found!", message: "Click the plus sign above and add your first card!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func startQuizPressed(_ sender: UIBarButtonItem) {
    }
  
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        let cardToSet = cards[indexPath.row]
        cell.textLabel?.text = "Question: \(cardToSet.question)"
        cell.detailTextLabel?.text = "Answer: \(cardToSet.answer)"
        return cell
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if cards.isEmpty && identifier == "QuizSegue"{
            let alert = UIAlertController(title: "No Cards Found!", message: "you must first add cards to take a quiz!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCardSegue"{
        if let destination = segue.destination as? AddCardViewController{
            destination.category = category
        }
    }else{
            if let destination = segue.destination as? QuizViewController{
                destination.cards = self.cards
            }
    
    
        }
}
}
