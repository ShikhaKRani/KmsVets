//
//  BookingNewPuppyViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 18/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import DropDown
import Alamofire



class BookingNewPuppyViewController: BaseViewController {
    @IBOutlet weak var bookingnewppuppyTableView: UITableView!
    
    
    let dropDown = DropDown();
    var petsBreed = ""
    var petArray : [[String: Any]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchPetList()
        
        // Do any additional setup after loading the view.
    }
    
    //http://wisdompetclinic.xyz/visitapi/index.php/getpet_list
    
    func fetchPetList() {
        
        let params = ["key":"5642vcb546gfnbvb7r6ewc211365vhh34"] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: APIUrl.GET_PET_LIST)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Array<Dictionary<String, AnyObject>>
                let dict = json[0]
                let dataArray = dict["data"]
                self.petArray = dataArray as! [[String : Any]]
                print(self.petArray)


            } catch {
                print("error")
            }
        })
        
        task.resume()
    }
    
    @objc func dropdownAction (sender : UIButton) {
        guard let cell = sender.superview?.superview as? BookingNewPuppyTableViewCell else {
            return
        }
        
        self.dropDown.anchorView = cell.petbreedTextfield.plainView
        self.dropDown.bottomOffset = CGPoint(x: 0, y: (sender).bounds.height)
        self.dropDown.dataSource.removeAll()
        //self.dropDown.dataSource = self.petArray
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            
            print(item)
            cell.petbreedTextfield.text = item
            self.petsBreed = item
        }
        self.dropDown.show()
    }
    

}

extension BookingNewPuppyViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.bookingnewppuppyTableView.dequeueReusableCell(withIdentifier: StringConstant.BookingNewPuppyTableViewCell) as? BookingNewPuppyTableViewCell
        
//        cell?.userName.delegate = self
//        cell?.fullName.delegate = self
//        cell?.userEmail.delegate = self
//        cell?.userZipcode.delegate = self
//        cell?.userAddress.delegate = self
//        cell?.userCity.delegate = self
//        cell?.userMobile.delegate = self
        
        //cell?.userMobile.isUserInteractionEnabled = false

        cell?.dropDownBtn?.addTarget(self, action: #selector(dropdownAction(sender:)), for: .touchUpInside)

        //cell?.profileupdateButton.addTarget(self, action: #selector(updateBtnAtion), for: .touchUpInside)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
