//
//  PaymentViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 26/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import WebKit


class PaymentViewController: BaseViewController, WKUIDelegate,WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    //MARK:-
    var merchantKey = Payment.MERCHANT_ID
    var salt = Payment.SALT
    var PayUBaseUrl = Payment.PAY_U_BASEURL
    let productInfo = Payment.PRODUCT_NAME
    let sUrl = Payment.S_URL   //By this URL we match whether payment got success or failure
    let fUrl = Payment.F_URL   //By this URL we match whether payment got success or failure
    let service_provider = Payment.Service_Provider
    var txnid1: String! = ""    //Its an unique id which can give order a specific order number.
    var firstName : String? //Details of user whose is purchasing order
    var email : String?  //Details of user whose is purchasing order
    var phone  = ""
    var totalPriceAmount : String?
    //MARK:-
    
    var screen : String?
    var order_id : String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleForNavigation(title: "", isHidden: true)
        phone = UserDefaults.standard.string(forKey: "mobile") ?? ""
        self.webView.uiDelegate = self
        webView.navigationDelegate = self
        
        self.webView.configuration.preferences.javaScriptEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initPayment()
    }
    
    //MARK:- initPayment
    func initPayment() {
        
        if ((totalPriceAmount?.isEmpty) == nil) {
            totalPriceAmount = "0"
        }
        if ((firstName?.isEmpty) == nil) {
            firstName = UserDefaults.standard.string(forKey: "name") ?? ""
        }
        if ((email?.isEmpty) == nil) {
            email = UserDefaults.standard.string(forKey: "email") ?? ""
        }
        
        txnid1 = "\(productInfo)\(String(Int(NSDate().timeIntervalSince1970)))"
        //Generating Hash Key
        let hashValue = String.localizedStringWithFormat("%@|%@|%@|%@|%@|%@|||||||||||%@",merchantKey,txnid1,totalPriceAmount!,productInfo,firstName!,email!,salt)
        
        
        let hash = self.sha1(string: hashValue)
        let postStr = "txnid=\(txnid1 ?? "")&key=\(merchantKey)&amount=\(totalPriceAmount ?? "")&productinfo=\(productInfo)&firstname=\(firstName ?? "")&email=\(email ?? "")&phone=\(phone)&surl=\(sUrl)&furl=\(fUrl)&hash=\(hash)&service_provider=\(service_provider)"
        
        let url = NSURL(string: String.localizedStringWithFormat("\(PayUBaseUrl)/_payment"))
        let request = NSMutableURLRequest(url: url! as URL)
        
        do {
            let postLength = String.localizedStringWithFormat("%lu",postStr.count)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Current-Type")
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            request.httpBody = postStr.data(using: String.Encoding.utf8)
            
            self.webView.load(request as URLRequest)
        }
        
        catch let error as NSError
        {
            
            print(error)
            
        }
    }
    
    func sha1(string:String) -> String {
        let cstr = string.cString(using: String.Encoding.utf8)
        let data = NSData(bytes: cstr, length: string.count)
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA512_DIGEST_LENGTH))
        CC_SHA512(data.bytes, CC_LONG(data.length), &digest)
        let hexBytes = digest.map { String(format: "%02x", $0) }
        return hexBytes.joined(separator: "")
    }
    
    //MARK:- initPayment End
    
    
    
    //MARK:- Extra
    func redirectToPaymentSuccessScreen() {
        //todo
        if screen == "asking" {
            let storyBoard = UIStoryboard.init(name: "Payment", bundle: nil)
            if let successVc = storyBoard.instantiateViewController(withIdentifier: "TransactionSuccessViewController") as? TransactionSuccessViewController {
                successVc.order_id = order_id
                successVc.screen = screen
                self.navigationController?.pushViewController(successVc, animated: true)
            }
        }
    }
    
    
    
    //MARK:- Webkit delegates
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        let requestURL = webView.url
        let requestString:String = (requestURL?.absoluteString)!
        if requestString.contains("https://www.payumoney.com/mobileapp/payumoney/success.php") {
            print("success payment done")
            self.redirectToPaymentSuccessScreen()
        }else if requestString.contains("https://www.payumoney.com/mobileapp/payumoney/failure.php") {
            print("====>>>>>>>>>>>>>payment failure")
        }
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            print("link")
            
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        print("no link")
        
        if((webView.url?.absoluteString.contains("https://www.payumoney.com/mobileapp/payumoney/failure.php"))! && navigationAction.navigationType.rawValue == -1){
            print("user transaction failure")
        }
        
        //cross pressed
        if((webView.url?.absoluteString.contains("https://checkout.citruspay.com/payu/checkout"))! && navigationAction.navigationType.rawValue == -1){
            print("user click the button")
            
            self.redirectToPaymentSuccessScreen()
            //once success page completes delete above line and uncomment below line
  ////////////-------------->
//            self.navigationController?.popToRootViewController(animated: false)
        }
        
        decisionHandler(WKNavigationActionPolicy.allow)
        
    }
        
    private func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation, withError error: NSError) {
        print("webView:\(webView) didFailNavigation:\(navigation) withError:\(error)")
        
    }
    
    //MARK:- Webkit delegates End
    
}

