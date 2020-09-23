//
//  SideMenuViewController.swift
//  Star Cars
//
//  Created by SUBHASH KUMAR on 10/09/20.
//

import UIKit
import SideMenu


class SideMenuTblCell: UITableViewCell {
    @IBOutlet var cellIcon: UIImageView!
    @IBOutlet var cellTitleLbl: UILabel!
}

class SideMenuImgCell: UITableViewCell {
    @IBOutlet var cellLargeIcon: UIImageView!
}


class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var sidemenuTblVw: UITableView!
    
    var dataArr : Array<Dictionary<String,AnyObject>> = [
        ["title":"My Profile" as AnyObject,"image": "home" as AnyObject]
        ,["title":"My Order" as AnyObject,"image": "userprofile" as AnyObject]
        ,["title":"My Service Order" as AnyObject,"image": "history" as AnyObject]
        ,["title":"Booking for a new Puppy" as AnyObject,"image": "aboutus" as AnyObject]
        ,["title":"New puppy history" as AnyObject,"image": "" as AnyObject]
        ,["title":"Booking for a surgery" as AnyObject,"image": "faqs" as AnyObject]
        ,["title":"Surgery History" as AnyObject,"image": "logout" as AnyObject]
        ,["title":"Asking a Question" as AnyObject,"image": "logout" as AnyObject]
        ,["title":"Question History" as AnyObject,"image": "logout" as AnyObject]
        ,["title":"Contact Us" as AnyObject,"image": "phone" as AnyObject]
        ,["title":"About Us" as AnyObject,"image": "logout" as AnyObject]
        ,["title":"Suggestion/Complaint" as AnyObject,"image": "logout" as AnyObject]
        ,["title":"Logout" as AnyObject,"image": "logout" as AnyObject]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
        return dataArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let imgcell:SideMenuImgCell! = tableView.dequeueReusableCell(withIdentifier: "SideMenuImgCell") as? SideMenuImgCell
        
        
        if indexPath.section == 0 {
            //            imgcell.imageView?.image = UIImage(named: "")
        }
            
        else {
            let cell:SideMenuTblCell! = tableView.dequeueReusableCell(withIdentifier: "SideMenuTblCell") as? SideMenuTblCell
            
            let cellDict = dataArr[indexPath.row] as Dictionary<String,AnyObject>
            cell.cellIcon.image = UIImage.init(named: cellDict["image"] as? String ?? "")
            cell.cellTitleLbl.text = cellDict["title"] as? String ?? ""
            return cell
            
        }
        
        
        return imgcell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 190
        }
        
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuItem =  dataArr[indexPath.row]["title"] as? String ?? ""
        
        switch menuItem {
        case "My Profile":
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            if let getProfile = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
                self.navigationController?.pushViewController(getProfile, animated: true)
            }
            
            break
        case "My Order":
            
            //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVc") as! ProfileVc
            //            //        navigationController?.pushViewController(vc, animated: true)
            //            //        self.present(vc, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
            
            break
            
        case "My Service Order":
            //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
            //            //        navigationController?.pushViewController(vc, animated: true)
            //            //        self.present(vc, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(vc, animated: true)
            //
            
            break
        case "Booking for a new Puppy":
               
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            if let getbookingpuppy = storyBoard.instantiateViewController(withIdentifier: "BookingNewPuppyViewController") as? BookingNewPuppyViewController {
                self.navigationController?.pushViewController(getbookingpuppy, animated: true)
            }
            break
        case "New puppy history":
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            if let genewpuppyhistory = storyBoard.instantiateViewController(withIdentifier: "NewPuppyHistoryViewController") as? NewPuppyHistoryViewController {
                self.navigationController?.pushViewController(genewpuppyhistory, animated: true)
            }
            break
            
        case "Booking for a surgery":
                    let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                    if let bookForSurgery = storyBoard.instantiateViewController(withIdentifier: "BookingForSurgeryViewController") as? BookingForSurgeryViewController {
                        self.navigationController?.pushViewController(bookForSurgery, animated: true)
                    }
            break
            
        case "Surgery History":
                    let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                    if let bookForSurgeryHistory = storyBoard.instantiateViewController(withIdentifier: "BookingSurgeryHistoryViewController") as? BookingSurgeryHistoryViewController {
                        self.navigationController?.pushViewController(bookForSurgeryHistory, animated: true)
                    }
            break
        case "Contact Us":
                    let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                    if let getcontact = storyBoard.instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController {
                        self.navigationController?.pushViewController(getcontact, animated: true)
                    }
            break
        case "About Us":
                    let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                    if let aboutus = storyBoard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                        self.navigationController?.pushViewController(aboutus, animated: true)
                    }
            break
            
        case "Suggestion/Complaint":
                    let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                    if let suggestion = storyBoard.instantiateViewController(withIdentifier: "SuggestionViewController") as? SuggestionViewController {
                        self.navigationController?.pushViewController(suggestion, animated: true)
                    }
            break
            
            
            
            
            
        case "Logout":
            
            let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to logout", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                UserDefaults.standard.removeObject(forKey: "id")
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
                let navigationController = UINavigationController(rootViewController: newViewController)
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.window!.rootViewController = navigationController
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
            break
            
        default:
            break
            
        }
        
    }
    
}

