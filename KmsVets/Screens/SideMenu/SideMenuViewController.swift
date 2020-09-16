//
//  SideMenuViewController.swift
//  Star Cars
//
//  Created by SUBHASH KUMAR on 10/09/20.
//

import UIKit


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
        ["title":"Home" as AnyObject,"image": "home" as AnyObject]
        ,["title":"Profile" as AnyObject,"image": "userprofile" as AnyObject]
        ,["title":"History" as AnyObject,"image": "history" as AnyObject]
        ,["title":"About Us" as AnyObject,"image": "aboutus" as AnyObject]
        ,["title":"Contact Us" as AnyObject,"image": "phone" as AnyObject]
        ,["title":"FAQ" as AnyObject,"image": "faqs" as AnyObject],
         ["title":"Logout" as AnyObject,"image": "logout" as AnyObject]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
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
        case "Home":
            
            //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home_VC") as! Home_VC
            //            //        navigationController?.pushViewController(vc, animated: true)
            //            //        self.present(vc, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(vc, animated: true)
            //
            
            break
        case "Profile":
            
            //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVc") as! ProfileVc
            //            //        navigationController?.pushViewController(vc, animated: true)
            //            //        self.present(vc, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
            
            break
            
        case "History":
            //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
            //            //        navigationController?.pushViewController(vc, animated: true)
            //            //        self.present(vc, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(vc, animated: true)
            //
            
            break
        case "About Us":
            //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "aboutUsVc") as! aboutUsVc
            //            //        navigationController?.pushViewController(vc, animated: true)
            //            //        self.present(vc, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "FAQ":
            //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FaqVC") as! FaqVC
            //            //        navigationController?.pushViewController(vc, animated: true)
            //            //        self.present(vc, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case "Contact Us":
            //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "contactVc") as! contactVc
            //            //        navigationController?.pushViewController(vc, animated: true)
            //            //        self.present(vc, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(vc, animated: true)
            break
            
            
            
        case "Logout":
            
            let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to logout", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                //                UserDefaults.standard.removeObject(forKey: "UserID")
                //                UserDefaults.standard.removeObject(forKey: "Emailid")
                //                UserDefaults.standard.removeObject(forKey: "mobile")
                //                UserDefaults.standard.removeObject(forKey: "username")
                //                UserDefaults.standard.removeObject(forKey: "password")
                
                
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
