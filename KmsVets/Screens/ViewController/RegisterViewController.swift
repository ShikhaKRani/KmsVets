//
//  RegisterViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 21/11/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {    
    @IBOutlet weak var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}

extension RegisterViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "NewRegisterTableViewCell") as? NewRegisterTableViewCell
        
        cell!.selectionStyle = .none
        return cell!
    }
    
    
}
