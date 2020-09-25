//
//  ProductContainerViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 25/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//


import UIKit
import Segmentio

class ProductContainerViewController: UIViewController {
    
    var segmentioStyle = SegmentioStyle.imageOverLabel
    
    @IBOutlet private var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var segmentioView: Segmentio!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var scrollView: UIScrollView!
    
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
        
        switch segmentioStyle {
        case .onlyLabel, .imageBeforeLabel, .imageAfterLabel:
            segmentViewHeightConstraint.constant = 50
        case .onlyImage:
            segmentViewHeightConstraint.constant = 100
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupScrollView()
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle
        )
        SegmentioBuilder.setupBadgeCountForIndex(segmentioView, index: 1)
        
        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            if let scrollViewWidth = self?.scrollView.frame.width {
                let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
                self?.scrollView.setContentOffset(
                    CGPoint(x: contentOffsetX, y: 0),
                    animated: true
                )
            }
        }
        segmentioView.selectedSegmentioIndex = selectedSegmentioIndex()
    }
    
    // Example viewControllers
    
    private func preparedViewControllers() -> [ProdcutListViewController] {
        
        let dogFoodController = ProdcutListViewController.create()
//        dogFoodController.disaster = Disaster(
//            cardName: "Before tornado",
//            hints: Hints.tornado
//        )

        let catFoodController = ProdcutListViewController.create()
//        earthquakesController.disaster = Disaster(
//            cardName: "Before earthquakes",
//            hints: Hints.earthquakes
//        )

        let dogAccessoryController = ProdcutListViewController.create()
//        extremeHeatController.disaster = Disaster(
//            cardName: "Before extreme heat",
//            hints: Hints.extremeHeat
//        )

        let dogMedicineController = ProdcutListViewController.create()
//        eruptionController.disaster = Disaster(
//            cardName: "Before eruption",
////            hints: Hints.eruption
//        )

        let catmedicineController = ProdcutListViewController.create()
//        catmedicineController.disaster = Disaster(
//            cardName: "Before floods",
////            hints: Hints.floods
//        )


        return [
            dogFoodController,
            catFoodController,
            dogAccessoryController,
            dogMedicineController,
            catmedicineController
        ]
    }
    
    private func selectedSegmentioIndex() -> Int {
        return 1
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


