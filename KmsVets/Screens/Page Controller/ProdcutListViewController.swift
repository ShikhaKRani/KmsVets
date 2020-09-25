//
//  ProdcutListViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 25/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ProdcutListViewController: UIViewController {
    
    
    @IBOutlet weak var itemTableView: UITableView!
    
    
    class func create() -> ProdcutListViewController {
        let mainStoryboard = UIStoryboard(name: "ProductHome", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! ProdcutListViewController
        
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableView.rowHeight = UITableView.automaticDimension
        itemTableView.estimatedRowHeight = 100
        
        
//        if let disaster = disaster {
//            cardNameLabel.text = disaster.cardName
//            hints = disaster.hints
//        }
    }
    
}


//MARK:- Delegate and Datasource

extension ProdcutListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductItemCell", for: indexPath) as! ProductItemCell
        
//        cell.hintLabel?.text = hints?[indexPath.row]
        return cell
    }
    
}


//MARK:- Cell
class ProductItemCell: UITableViewCell {
    
    
    
}


