//
//  HomeViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 12/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SDWebImage

class HomePageDogFoodCell: UITableViewCell {
    @IBOutlet var viewDog: UIView!
    @IBOutlet var imageDogFood: UIImageView!
    @IBOutlet var foodLabel: UILabel!
}

class HomePageServicesCell: UITableViewCell {
    @IBOutlet var viewService: UIView!
    @IBOutlet var imageService: UIImageView!
    @IBOutlet var serviceLabel: UILabel!
}

class HomeViewController: BaseViewController {
    
    @IBOutlet var imgCollectionView: UICollectionView!
    @IBOutlet var homeshopcategoryTblVw: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var bannerData: [[String: Any]] = [[:]]
    var catgoryData = [[String: Any]]()
    var latestProductArray = [[String: Any]]()
    var productTitleArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleForNavigation(title: "KMS Vets", isHidden: false)
        self.fetchBannerImageFromServer()
        self.pageControl.currentPage = 0
        self.imgCollectionView.bringSubviewToFront(self.pageControl)
        
        self.getCategory()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitleForNavigation(title: "KMS Vets", isHidden: false)
    }
    
    func fetchBannerImageFromServer() {
        
        let parameters = [
            "component": "json",
            "action":"get_slider_image"
        ]
        
        AF.request(APIUrl.GET_SLIDER_IMAGE, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let responseDict = value as? NSDictionary {
                    print(responseDict)
                    self.bannerData = responseDict["data"] as! [[String : Any]]
                    self.pageControl.numberOfPages = self.bannerData.count
                    
                    self.startTimer()
                    self.imgCollectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    func getCategory() {
        
        self.showHud("Loading..")
        ServiceClient.sendRequest(apiUrl: APIUrl.GET_CATEGORY,postdatadictionary: ["" : ""], isArray: false) { (response) in

            if let res = response as? [String : Any] {
                self.catgoryData = res["data"] as? [[String: Any]] ?? [[:]]
                print(self.catgoryData)
                
                self.latestProductArray.removeAll()
                for info in self.catgoryData {
                    self.getProductList(categoryId: info["id"] as? String)
                    self.productTitleArray.append(info["name"] as? String ?? "")
                }
                
                DispatchQueue.main.async { () -> Void in
                self.homeshopcategoryTblVw.reloadData()
                }
                self.hideHUD()
            }
       }
    }
    
    
    func getProductList(categoryId : String?) {
        
        self.showHud("Load Product..")
        ServiceClient.sendRequest(apiUrl: APIUrl.PRODUCT_CATEGORY_LIST,postdatadictionary: ["userId" : UserDefaults.standard.string(forKey: "id") ?? "", "id" : categoryId ?? ""], isArray: true) { (response) in
            
            print(response)
            if let res = response as? [[String : Any]] {
                
                for items in res {
                    self.latestProductArray.append(items)

                }
                
                DispatchQueue.main.async { () -> Void in
                    print(self.latestProductArray)

                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.latestProductArray = self.latestProductArray
                    appDelegate.contentSliderArray  = self.productTitleArray ?? [""]
                }
                
                self.hideHUD()
            }
        }
    }
    
    
    
    
    func startTimer() {
        let _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    var counter = 0
    @objc func autoScroll() {
        
        if self.counter < self.bannerData.count {
            let indexPath = IndexPath(item: counter, section: 0)
            
            self.imgCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.pageControl.currentPage = self.counter
            self.counter = self.counter + 1
        }else{
            self.counter = 0
            let indexPath = IndexPath(item: counter, section: 0)
            self.imgCollectionView.scrollToItem(at:indexPath, at: .left, animated: true)
            self.pageControl.currentPage = self.counter
        }
        
    }
    
}


//MARK:- CollectionView Delegate
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollCell", for: indexPath) as! BannerCollCell
        let dict = self.bannerData[indexPath.row]
            
        let urlString  =  "\(AppURL.SLIDER_URL)/\(dict["image"] ?? "")"
            cell.bannerCellImg.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "medicine.jpeg") ,options: .refreshCached, completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            let collectionViewWidth = imgCollectionView.bounds.width
            let collectionHeight = imgCollectionView.bounds.height
            return CGSize(width: (collectionViewWidth), height: (collectionHeight))
                    
    }
    
}

//MARK:- CollectionView Delegate


extension HomeViewController {
    
    //MARK:- Side Menu Set up
    
    func settingUpSideMenuUI() {
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        setupSideMenu()

    }
    private func setupSideMenu() {
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)

    }
    //MARK:- Side Menu Set up
}

//MARK:- Table View Delegate
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.homeshopcategoryTblVw.dequeueReusableCell(withIdentifier: "HomePageDogFoodCell") as? HomePageDogFoodCell
        cell?.selectionStyle = .none

        
        if indexPath.row == 0 {

            if self.catgoryData.count > 0 {
                
                let dict = self.catgoryData[0]
                let urlString  =  "\(AppURL.SLIDER_URL)/\(dict["icon"] ?? "")"
                cell?.imageDogFood.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "medicine.jpeg") ,options: .refreshCached, completed: nil)

                cell?.foodLabel.text = "\(dict["name"] ?? "")"
            }
                
        }
        
        if indexPath.row == 1{
            let cell = self.homeshopcategoryTblVw.dequeueReusableCell(withIdentifier: "HomePageServicesCell") as? HomePageServicesCell
            cell?.selectionStyle = .none
            return cell!
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if indexPath.row == 0 {
            
            let storyBoard = UIStoryboard.init(name: "ProductHome", bundle: nil)
            if let getProfile = storyBoard.instantiateViewController(withIdentifier: "ProductHomeViewController") as? ProductHomeViewController {
                self.navigationController?.pushViewController(getProfile, animated: true)
            }
            
            //ProductHomeViewController
            
            
        }
        else if indexPath.row == 1 {
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            if let getProfile = storyBoard.instantiateViewController(withIdentifier: "ServicesListViewController") as? ServicesListViewController {
                self.navigationController?.pushViewController(getProfile, animated: true)
            }
            
        }
        
    }
    
}


