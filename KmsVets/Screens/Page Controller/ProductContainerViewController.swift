//
//  ProductContainerViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 25/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//


import UIKit
import Segmentio

class ProductContainerViewController: BaseViewController {
    
    var segmentioStyle = SegmentioStyle.imageOverLabel
    
    @IBOutlet private var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var segmentioView: Segmentio!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var scrollView: UIScrollView!
    
    var catgoryData = [[String: Any]]()
    var controllerArray : [UIViewController] = []
    var indexSelected = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    private lazy var viewControllers: [UIViewController] = {
        return self.preparedViewControllers()
    }()
    
    // MARK: - Init
    
    class func create() -> ProductContainerViewController {
        let board = UIStoryboard(name: "ProductHome", bundle: nil)
        return board.instantiateViewController(withIdentifier: String(describing: self)) as! ProductContainerViewController
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.getCategory()
        
        
        if appDelegate.catgoryData.count > 0 {
            self.catgoryData = []
            self.catgoryData = appDelegate.catgoryData
            DispatchQueue.main.async { () -> Void in
                self.setUpController()
            }
        }
        
        
        switch segmentioStyle {
        case .onlyLabel, .imageBeforeLabel, .imageAfterLabel:
            segmentViewHeightConstraint.constant = 50
        case .onlyImage:
            segmentViewHeightConstraint.constant = 100
        default:
            break
        }
    }
    
 
    
    
    //MARK:- Setup controller
    func setUpController() {
        setupScrollView()
        
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView, titleArray: appDelegate.contentSliderArray,
            segmentioStyle: segmentioStyle
        )
        
        
        SegmentioBuilder.setupBadgeCountForIndex(segmentioView, index: 0)
        
        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            if let scrollViewWidth = self?.scrollView.frame.width {
                let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
                self?.scrollView.setContentOffset(
                    CGPoint(x: contentOffsetX, y: 0),
                    animated: true
                )
            }
            
//            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: ["SegmentIndex":"\(segmentIndex)"])

        }
        segmentioView.selectedSegmentioIndex = selectedSegmentioIndex()
    }
    
    // Example viewControllers
    
    private func preparedViewControllers() -> [UIViewController] {
        
        
        self.controllerArray.removeAll()
        
        for pageInfo in self.catgoryData {
            let controller = ProdcutListViewController.create()
            controller.categoryDict = pageInfo
            
            let category = pageInfo["id"] as? String ?? "33"
            let data = self.returnSelectedCategoryData(categoryId: category)

            controller.productItemArray = data
                self.controllerArray.append(controller)
        }
        return self.controllerArray
        
    }
    
    func returnSelectedCategoryData(categoryId : String) -> [[String: Any ]] {
        
        var data = [[String: Any]]()
        
        print(appDelegate.latestProductArray.count)
        
        for items in appDelegate.latestProductArray {
            if items["category_id"] as! String == categoryId {
                data.append(items)
            }
        }
        
        return data
    }
    
    private func selectedSegmentioIndex() -> Int {
        return 0
    }
    
    // MARK: - Setup container view
    
    private func setupScrollView() {
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width * CGFloat(viewControllers.count),
            height: containerView.frame.height
        )
        
        for (index, viewController) in viewControllers.enumerated() {
            viewController.view.frame = CGRect(
                x: UIScreen.main.bounds.width * CGFloat(index),
                y: 0,
                width: view.frame.width,
                height: view.frame.height
            )
            addChild(viewController)
            scrollView.addSubview(viewController.view, options: .useAutoresize) // module's extension
            viewController.didMove(toParent: self)
        }
    }
    
    // MARK: - Actions
    
    private func goToControllerAtIndex(_ index: Int) {
        segmentioView.selectedSegmentioIndex = index
    }
}

extension ProductContainerViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
}

