//
//  SearchProductViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 29/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class SearchCell : UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
}

class SearchProductViewController: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    var latestProductArray = [[String: Any]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.tableFooterView = UIView()
        searchTableView.separatorStyle = .none
        searchTextField.delegate = self
        self.crossBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        setUpNav()
        
    }
    
    
    func setUpNav() {
        
        let homebutton = UIButton(type: .custom)
        homebutton.setImage(UIImage(named: "home22"), for: .normal)
        homebutton.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        homebutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        let barButtonItem2 = UIBarButtonItem(customView: homebutton)

        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 20
        self.navigationItem.leftBarButtonItems = [barButtonItem2,space]
        
        self.title = "Search Product"
   
    }
    
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- Textfield delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count ?? 0 > 1 {
        self.searchFromProductList(searchString: textField.text)
        }
        
        return true
    }
    
    
    
    func searchFromProductList( searchString : String?) {
        
        self.showHud("")
        ServiceClient.sendRequest(apiUrl: APIUrl.PRODUCT_CATEGORY_LIST,postdatadictionary: ["userId" : UserDefaults.standard.string(forKey: "id") ?? "", "search" : searchString ?? ""], isArray: true) { (response) in
            
            print(response)
            if let res = response as? [[String : Any]] {
                self.latestProductArray.removeAll()
                for items in res {
                    self.latestProductArray.append(items)
                }
                
                DispatchQueue.main.async { () -> Void in
                    self.searchTableView.reloadData()
                    
                    self.hideHUD()
                }
            }
        }
        
    }
    
    
}


extension SearchProductViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestProductArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.searchTableView.dequeueReusableCell(withIdentifier: "SearchCell") as? SearchCell
        let dict = latestProductArray[indexPath.row]
        
        cell?.titleLbl.text = dict["title"] as? String
        cell?.selectionStyle = .none

        return cell!
    }
    
    
    
}
