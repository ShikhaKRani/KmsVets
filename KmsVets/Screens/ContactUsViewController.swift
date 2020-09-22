//
//  ContactUsViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 22/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ContactUsViewController: BaseViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        getContact()

        // Do any additional setup after loading the view.
    }
    
    func getContact() {
        
        //self.showHud("Booking in Progress")
        ServiceClient.sendRequest(apiUrl: APIUrl.GET_CONTACT,postdatadictionary: ["component":"json", "action": "get_contact"], isArray: false) { (response) in

        
       
           if let res = response as? [String : Any] {
               print(res)
            //let message = res["msg"] as? String
            self.hideHUD()

            //self.displayMessage(message: message)
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
