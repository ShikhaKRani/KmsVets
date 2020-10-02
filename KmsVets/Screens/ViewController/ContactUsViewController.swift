//
//  ContactUsViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 22/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ContactUsViewController: BaseViewController {
    var data : [[String : Any]]?
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        getContact()
        self.title = "Contact us"
        // Do any additional setup after loading the view.
    }
    
    func getContact() {
        
        self.showHud("Booking in Progress")
        ServiceClient.sendRequest(apiUrl: APIUrl.GET_CONTACT,postdatadictionary: ["" : ""], isArray: false) { (response) in

           if let res = response as? [String : Any] {
               print(res)
            self.data = res["data"] as? [[String: Any]] ?? [[:]]
            if self.data?.count ?? 0 > 0{
                let dict = self.data?[0]
                DispatchQueue.main.async { () -> Void in
                self.emailLabel.text = dict?["email"] as? String
                self.mobileLabel.text = dict?["phone"] as? String
                }
            }
            self.hideHUD()
           }
       }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



