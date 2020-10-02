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
import CoreLocation
import MapKit


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

class HomeViewController: BaseViewController , CLLocationManagerDelegate {
    
    @IBOutlet weak var collectionView: BJAutoScrollingCollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!

    @IBOutlet var homeshopcategoryTblVw: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var locationManager: CLLocationManager!

    var bannerData: [[String: Any]] = [[:]]
    var catgoryData = [[String: Any]]()
    var latestProductArray = [[String: Any]]()
    var productTitleArray = [String]()
    
    var latitude : Double?
    var logitude : Double?
    var fulladdressString : String = ""

    
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myLocation()
        self.setTitleForNavigation(title: fulladdressString, isHidden: false)
        self.fetchBannerImageFromServer()
        self.pageControl.currentPage = 0
        self.setUpNav()
        initCollectionView()
        
    }
    
    
    func myLocation() {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    // location Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.logitude = location.coordinate.longitude
        self.latitude = location.coordinate.latitude

        self.getAddressFromLatLon(pdblLatitude: "\(self.latitude ?? 0.0)", withLongitude: "\(self.logitude ?? 0.0)")
        
        
//        self.map.setRegion(region, animated: true)
    }
    
    
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let pm = placemarks! as [CLPlacemark]
                                        
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            print(pm.country)
                                            print(pm.locality)
                                            print(pm.subLocality)
                                            print(pm.thoroughfare)
                                            print(pm.postalCode)
                                            print(pm.subThoroughfare)
                                            var addressString : String = ""
                                            
                                            if pm.subLocality != nil {
                                                addressString = addressString + pm.subLocality! + ", "
                                            }
                                            if pm.thoroughfare != nil {
                                                addressString = addressString + pm.thoroughfare! + ", "
                                            }
                                            if pm.locality != nil {
                                                addressString = addressString + pm.locality! + ", "
                                            }
                                            if pm.country != nil {
                                                addressString = addressString + pm.country! + ", "
                                            }
                                            if pm.postalCode != nil {
                                                addressString = addressString + pm.postalCode! + " "
                                            }
                                            
                                            
                                            print(addressString)
                                            self.fulladdressString = addressString
                                            
                                            self.title = self.fulladdressString
                                        }
                                    })
        
    }
    
    
    func setUpNav() {
        
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "cart22"), for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        button.addTarget(self, action: #selector(redirectToCart), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)

        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "search"), for: .normal)
        button2.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        button2.addTarget(self, action: #selector(redirectToSearchScreen), for: .touchUpInside)

        let barButtonItemright = UIBarButtonItem(customView: button2)

        let space2 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space2.width = 20
        self.navigationItem.rightBarButtonItems = [barButtonItem,space2,barButtonItemright]
        
        
        
   
    }
    
    @objc func redirectToCart() {
        
        let storyBoard = UIStoryboard.init(name: "ProductHome", bundle: nil)
        if let cartVC = storyBoard.instantiateViewController(withIdentifier: "ProductCartViewController") as? ProductCartViewController {
            
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
    }
    
    @objc func redirectToSearchScreen() {
        
        let storyBoard = UIStoryboard.init(name: "ProductHome", bundle: nil)
        if let searchVC = storyBoard.instantiateViewController(withIdentifier: "SearchProductViewController") as? SearchProductViewController {
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    

    @objc func homeBarButtonAction() {
       
       self.openAlert(title: "Alert",
                             message: "Are you sure you want to remove items from Cart?",
                             alertStyle: .alert,
                             actionTitles: ["Okay", "Cancel"],
                             actionStyles: [.default, .cancel],
                             actions: [
                                 {_ in
                                      print("okay click")
                                 },
                                 {_ in
                                      print("cancel click")
                                 }
                            ])
      
   }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitleForNavigation(title: "KMS Vets", isHidden: false)
        self.getCategory()
        self.getProductList(categoryId:" ")
        self.title = self.fulladdressString

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
                    self.scrollReload()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    
    
    func getCategory() {
        
        
        self.showHudwithDelay("")
        ServiceClient.sendRequest(apiUrl: APIUrl.GET_CATEGORY,postdatadictionary: ["" : ""], isArray: false) { (response) in

            if let res = response as? [String : Any] {
                self.catgoryData = []
                self.catgoryData = res["data"] as? [[String: Any]] ?? [[:]]
                print(self.catgoryData)
                
                self.latestProductArray.removeAll()
                self.productTitleArray.removeAll()
                for info in self.catgoryData {
                    self.productTitleArray.append(info["name"] as? String ?? "")
                }
                DispatchQueue.main.async { () -> Void in
                    self.homeshopcategoryTblVw.reloadData()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.catgoryData = self.catgoryData
                }
                self.hideHUD()
            }
       }
    }
    
    
    func getProductList(categoryId : String?) {
        
        self.showHudwithDelay("")
        //"id"
        ServiceClient.sendRequest(apiUrl: APIUrl.PRODUCT_CATEGORY_LIST,postdatadictionary: ["userId" : UserDefaults.standard.string(forKey: "id") ?? "", "search" : categoryId ?? ""], isArray: true) { (response) in
            
            print(response)
            if let res = response as? [[String : Any]] {
                
                for items in res {
                    self.latestProductArray.append(items)

                }
                
                DispatchQueue.main.async { () -> Void in
                    print(self.latestProductArray)
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.latestProductArray = self.latestProductArray
                    appDelegate.contentSliderArray  = self.productTitleArray
                    
                }
                
                self.hideHUD()
            }
        }
    }
    
    
    func initCollectionView() {
        
        self.collectionView.scrollInterval = 2 //Step 2
        self.collectionViewFlowLayout.scrollDirection = .horizontal
        self.collectionViewFlowLayout.minimumInteritemSpacing = 0
        self.collectionViewFlowLayout.minimumLineSpacing = 0
    }
    
    func scrollReload() {
        self.collectionView.reloadData()
        self.collectionView.startScrolling() //Step 3
        self.startUpdatingPager()
    }
    
    func setTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updatePager), userInfo: nil, repeats: true)
    }
    
    func startUpdatingPager() {
        if !self.timer.isValid {
            if self.bannerData.count > 0 {
                stopUpdatingScrolling()
                setTimer()
            }
        }
    }
    
    func stopUpdatingScrolling() { if timer.isValid { self.timer.invalidate() } }

    var counter = 1
    @objc func updatePager() {
        
        if counter < self.bannerData.count  {
            self.pageControl.currentPage = counter
            counter = counter + 1
        }else{
            counter = 0
            self.pageControl.currentPage = counter
        }
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
        return 160
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier: String = "CustomImageCollectionCell"
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomImageCollectionViewCell
        
        let dict = self.bannerData[indexPath.row]
        
        let urlString  =  "\(AppURL.SLIDER_URL)/\(dict["image"] ?? "")"
                    cell.imageView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "medicine.jpeg") ,options: .refreshCached, completed: nil)
        
//        cell.imageView.image = self.imagesArray[indexPath.row]
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bannerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
    }
}

