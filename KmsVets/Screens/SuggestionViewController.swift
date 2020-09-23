//
//  SuggestionViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 23/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class SuggestionViewController: BaseViewController {
    
    
    var nameString : String?
    var mobileString : String?
    var descString : String?
    
    @IBOutlet weak var suggestionTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobileString = UserDefaults.standard.string(forKey: "mobile") ?? ""
        nameString = UserDefaults.standard.string(forKey: "name") ?? ""
        // Do any additional setup after loading the view.
    }
    

    

}

extension SuggestionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.suggestionTableView.dequeueReusableCell(withIdentifier: "imgCell") as? SuggestionTableViewCell
       // let dict = self.dataArray?[indexPath.row]
        
        

        if indexPath.row == 1 {
            let cell = self.suggestionTableView.dequeueReusableCell(withIdentifier: "fieldCell") as? SuggestionTableViewCell
            
            cell?.nameField.text = nameString
            cell?.mobileField.text = mobileString
            cell?.mobileField.isEnabled = false
            cell?.selectionStyle = .none
            return cell!
        }
        
        
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}


