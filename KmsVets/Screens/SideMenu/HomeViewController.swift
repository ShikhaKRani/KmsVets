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

class HomeViewController: BaseViewController {
    
    @IBOutlet var imgCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var bannerData: [[String: Any]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleForNavigation(title: "KMS Vets", isHidden: false)
        self.fetchBannerImageFromServer()
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.imgCollectionView.bringSubviewToFront(self.pageControl)
        
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
                    
                    
                    self.startTimer()
                    self.imgCollectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    func startTimer() {
        
        _ =  Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let coll  = imgCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < bannerData.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    pageControl.currentPage = indexPath1?.row as! Int
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                    pageControl.currentPage = indexPath1?.row as! Int
                    
                }
                
            }
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


