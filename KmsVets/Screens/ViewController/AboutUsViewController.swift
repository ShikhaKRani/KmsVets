//
//  AboutUsViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 23/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController {

    
    @IBAction func privacyButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let privacyVC = storyBoard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as? PrivacyPolicyViewController {
            self.navigationController?.pushViewController(privacyVC, animated: true)
        }
    }
    
    @IBAction func termsAndConditionActionButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let termsVC = storyBoard.instantiateViewController(withIdentifier: "TermsAndConditionsViewController") as? TermsAndConditionsViewController {
            self.navigationController?.pushViewController(termsVC, animated: true)
        }
       
    }
    
    @IBAction func faqButtonAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let faqVC = storyBoard.instantiateViewController(withIdentifier: "FAQViewController") as? FAQViewController {
            self.navigationController?.pushViewController(faqVC, animated: true)
        }
        
        
    }
    
    @IBAction func cancilationButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let cancelVC = storyBoard.instantiateViewController(withIdentifier: "CancellationAndRefundViewController") as? CancellationAndRefundViewController {
            self.navigationController?.pushViewController(cancelVC, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About us"

        self.view.backgroundColor = .tertiarySystemGroupedBackground
        // Do any additional setup after loading the view.
    }

}

