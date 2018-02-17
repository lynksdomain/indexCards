//
//  categoryTableViewController.swift
//  indexCards
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class categoryTableViewController: UITableViewController {
    
    var user: AppUser?
    let currentUser = AuthUserService.getCurrentUser()
    var myCategories = [Category](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Log Out", message: "are you sure you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            AuthUserService.manager.signOut()
            self.present(LoginViewController.storyboardInstance(), animated: true, completion: nil)
        }))
        
        
        
        self.present(alert, animated: true, completion: nil)
       
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        DBService.manager.getAppUser(with: currentUser!.uid) { (appUser) in
            self.user = appUser
        }
        
            DBService.manager.getAllCategories(completion: { (categories) in
                self.myCategories = DBService.manager.getCurrentUserCategories()
                if self.myCategories.count == 0{
                    let alert = UIAlertController(title: "No Categories Found!", message: "Click the plus sign above and add your first category!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myCategories.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryToSet = myCategories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryToSet.name
        return cell
    }
  
    
}

extension categoryTableViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CardTableViewController{
            let selectedCategory = myCategories[(tableView.indexPathForSelectedRow?.row)!]
            destination.category = selectedCategory.name
        }
        
    }
}





extension categoryTableViewController{
    
    public static func storyboardInstance() -> UINavigationController{
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "categoryTableViewController") as! categoryTableViewController
    let nav = UINavigationController(rootViewController: vc)
        return nav
    }
}
