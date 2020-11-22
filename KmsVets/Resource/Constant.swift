//
//  Constant.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 14/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import Foundation
import UIKit


//MARK:- App Constant
struct AppConstant {
    //constant
    static let UserKey  = "5642vcb546gfnbvb7r6ewc211365vhh34"
}

struct Payment {
    static let PAY_U_BASEURL = "https://secure.payu.in"
    static let TestPayUMoneyBaseURL = "https://test.payu.in"
    
    static let PRODUCT_NAME = "KMSVETS"
    static let MERCHANT_ID = "c3B53agk"
    static let SALT = "k1TKelWnCT"
    static let S_URL = "https://www.payumoney.com/mobileapp/payumoney/success.php"
    static let F_URL = "https://www.payumoney.com/mobileapp/payumoney/failure.php"
    static let Service_Provider = "payu_paisa"
    
    
}

class AppClass {
    
    
    class func strikeOnlabel(yourText : String, yourLabel : UILabel) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: yourText)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        
        yourLabel.attributedText = attributeString
        
        
    }
    
    class var windowWidth: CGFloat {
        if let rootwindow = UIApplication.shared.delegate?.window, let view = rootwindow!.rootViewController?.view {
            return view.bounds.size.width
        }
        return 0
    }
    
    class var windowHeigth: CGFloat {
        if let rootwindow = UIApplication.shared.delegate?.window, let view = rootwindow!.rootViewController?.view {
            return view.bounds.size.height
        }
        return 0
    }
    
}
struct Colors {
    static let theme = UIColor(red: 01/255, green: 61/255, blue: 55/255, alpha: 1)
}

//MARK:- String Constant
struct StringConstant {  
    
    //Identifier
    static let  CustomerInformationCell = "CustomerInformationCell"
    static let  ProfileViewTableViewCell = "ProfileViewTableViewCell"
    static let  BookingNewPuppyTableViewCell = "BookingNewPuppyTableViewCell"
    static let  NewPuppyHistoryTableViewCell = "NewPuppyHistoryTableViewCell"
    static let  BookinfForSurgeryTableViewCell = "BookinfForSurgeryTableViewCell"
    static let  BookingSurgeryHistoryTableViewCell = "BookingSurgeryHistoryTableViewCell"
    static let  SuggestionTableViewCell = "SuggestionTableViewCell"
    static let  AskQuestionTableViewCell = "AskQuestionTableViewCell"
    
    
    
    static let  RuppeeSymbol = "₹"

    
    
    
    //title
    static let  Apptitle = "KMS Vets"
    static let FAQ = "At KMS vets, we are dedicated to providing a seamless shopping experience to all our customers. To help guide you through your online shopping with us, we have compiled a list of frequently asked questions and provided answers below. If you don’t find your question, you are always welcome to contact us and we will get back to you as soon as possible."
    
    
    static let FAQ_question1 = "Question: Can I know whether your Pharmacy is licensed?"
    static let FAQ_answer1 = "Answer: Certainly, we are a licensed pharmacy offering prescription medications online. Our license number: 00014/20/21/GZB-2015"
    
    static let FAQ_question2 = "Question: What are your hours of operation?"
    static let FAQ_answer2 = "Answer: Our website/App is open 24 hours a day, 7 days a week. Call Centre support is available from Monday to Sunday, 08:00 am to 10:00 pm IST."
    
    static let FAQ_question3 = "Question: What are Med Health's Privacy and Security Policies?"
    static let FAQ_answer3 = "Answer: At KMS vets, your privacy and security are extremely important to us. We are committed to protecting the confidentiality of your personal information (your name, address, email address or credit card information) and we never share them with any other person or company. It is used solely by our authorized  personnel to process your order.\n\nPlease note that all information provided to us is subject to doctor–patient privilege laws. Being compliant with PCI DSS Level 3, we use the latest electronic security measures and our servers are protected by secure firewalls to prevent unauthorized access to your personal data."
    
    static let FAQ_question4 = "Question: What is KMS vets’s return and refund policy?"
    static let FAQ_answer4 = "Answer: At KMS vets, we do our best to ensure that you are completely satisfied with our products. And we are happy to issue a full refund based on the conditions listed below: "
    
    static let FAQ_question5 = "FULL REFUND POSSIBLE IF:"
    static let FAQ_answer5 = "you received a defective item; Contact within 48 hours of receiving the item\nthe ordered item(s) is lost or damaged during transit;\nthe ordered item(s) is past its expiry date.\nPlease Note: Mode of refund may vary depending on circumstances. If the mode of refund is by Credit/Debit Card or Net Banking, please allow 7 to 10 working days for the credit to appear in your account. While we regret any inconvenience caused by this time frame, it is the bank’s policy that delays the refund timing and we have no control over that. If the mode of refund is by e-wallet, credit should be available within 24 hours. \n \nAnd most Importantly, WITHOUT BILL NO TRANSACTION WILL BE INITIATED."
    
    static let FAQ_question6 = "Question: Why is the image shown on the website different from the item I received?"
    static let FAQ_answer6 = "Answer: Although we make every effort to ensure product images on our website are identical to the item you receive, occasionally actual product color may vary from the image shown. We cannot guarantee the accurate representation of the product because not all computer monitors may have the same color settings. Please note that product image on our site is for illustrative purpose only."
    
    static let FAQ_question7 = "Question: Are medications available at Med-Health safe?"
    static let FAQ_answer7 = "Answer: Yes. The medications that you purchase at our pharmacy are of the highest quality. The prescription medications we provide are procured from world-class and well-recognized pharmaceutical companies such as GlaxoSmithKline, Pfizer, Wyeth, Merck, Ranbaxy, Dr. Reddy’s, Nicholas Piramal, Sun Pharmacy and other global industry giants. They are manufactured under government supervision, prepackaged in factory-sealed blister packs and untouched by human hands."
    
    static let FAQ_question8 = "Question: Why do the pills I ordered from Med-Health look different from those I get from my local pharmacy?"
    static let FAQ_answer8 = "Annswer: According to the trademark laws, generic pill is not allowed to look exactly like its brand-name version. So the pills (generic version) you received normally will look different from their branded counterparts, even though both contain the same active ingredient(s) and work in the same way exactly."
    
    static let FAQ_question9 = "Question: What is the meaning of Generic Drugs?"
    static let FAQ_answer9 = "Answer: Generic Drugs, also known as Generics or Generic Medications, are drugs that are marketed without brand names and are considered identical as their brand-name counterparts in all respects such as strength, dose, active ingredients, intended use, route of administration, efficacy, bioavailability and safety. As required by the CDSCO, India’s regulatory body for pharmaceuticals, Generics must meet the same rigid standards as set for brand-name counterparts."
    
    static let FAQ_question10 = "Question: How long will it take to deliver my order?"
    static let FAQ_answer10 = "Answer: Delivery times may vary depending on the delivery location as well as the type of product you order."
    
    static let FAQ_question11 = "Question: What are your delivery charges?"
    static let FAQ_answer11 = "Answer: - Delivery charges for ALL orders: Rs. 25\n\n- FREE Delivery on Medicine orders of Rs. 1000 or more."
    
    static let FAQ_question12 = "Question: What is Cash on Delivery(COD)?"
    static let FAQ_answer12 = "Answer: Cash on Delivery (COD) is a payment method by which you can pay for your ordered item(s) in cash when the courier company delivers the item(s) to you at your delivery address."
    
    static let FAQ_question13 = "Question: How do I cancel my order?"
    static let FAQ_answer13 = "Answer: If you wish to cancel your order, you can send an email request to “KMS vetsteam@gmail.com; Please note that in case your order has already been charged or delivered, we cannot cancel it."
    
    static let FAQ_question14 = "Question: Is it possible to cancel my order after it has been charged?"
    static let FAQ_answer14 = "Answer: No, you cannot cancel your order once your payment has been processed."
    
    static let FAQ_question15 = "Question: How is my order packaged?"
    static let FAQ_answer15 = "Answer: KMS vets   takes greatest possible care in packaging your order."
    
  //privacy policy
    
    static let PRIVACY_question1 = "Our Mission is to make healthcare understandable, accessible and affordable"
    static let PRIVACY_answer1 = "We want you to understand the medicines that you take and that you give your loved ones.\n\nBuying medicines may require you to try 5 medical stores which are miles apart. We want you to be able to do it with a click.\n\nMedicines can be expensive. We want you to know about medicines which have the same composition as prescribed by your doctor but can be considerably cheaper."
    
    static let PRIVACY_question2 = "CONVENIENCE"
    static let PRIVACY_answer2 = "Heavy traffic, lack of parking, monsoons, shop closed, forgetfulness… these are some of the reasons that could lead to skipping of vital medications. Since taking medicines regularly is a critical component of managing chronic medical conditions, it’s best not to run out of essential medicines. Just log on to KMS vets.co.in, Or Our App ,place your order online and have your medicines delivered to you – without leaving the comfort of your home.\n\nWhat’s more, with easy access to reliable drug information, you get to know all about your medicine at netmeds.com, and once you’re a KMS vets customer, you’ll get regular refill reminders, so you’ll never again come up short of medicines."
    
    static let PRIVACY_question3 = "ONE-STOP SHOP"
    static let PRIVACY_answer3 = "At KMS vets , we not only provide you with a wide range of medicines listed under various categories, we also offer a wide choice of  OTC products including wellness products, vitamins, diet/fitness supplements, herbal products, pain relievers, diabetic care kits, baby/mother care products, beauty care products and surgical supplies"
    
    static let PRIVACY_question4 = "TRUST"
    static let PRIVACY_answer4 = "KMS vets  believes to create a legacy of success in the pharmaceutical industry. We are committed to provide safe, reliable and affordable medicines as well as a customer service philosophy that is worthy of our valued customers’ loyalty. We offer a superior online shopping experience, which includes ease of navigation and absolute transactional security."
        
    //tnc
    
    static let TERMS_question1 = "TERMS AND CONDITIONS"
    static let TERMS_answer1 = "The following are the Terms and Conditions, read together with the Privacy Policy, that govern your purchase and use of the products and services (the Products) from KMS vets, and constitute a legally binding agreement, between you (the Customer, the User or the Caregiver) and KMS vets a fully licensed Pharmacy."
    
    static let TERMS_question2 = "1. CREATING AN ACCOUNT"
    static let TERMS_answer2 = "1.1 To use certain features of the Website (e.g., ordering Products, posting rating/reviews), you must set up an account with KMS vets (KMS vets’s Account) and provide certain information about yourself as prompted by the Customer Information form, including, your name, gender, email address, account password, mobile phone number and billing/shipping address. All of your registration information is protected by our Privacy Policy.\n\n1.2 You represent and warrant that the information you submit during registration is truthful and accurate and that you will maintain the accuracy of such information.\n\n1.3 Your KMS vets  Account username and password are personal to you. You may not transfer your account and you will be responsible for the activities associated with your KMS vets Account.\n\n1.4 KMS vets will not be liable for any loss or damages as a result of your failure to maintain the confidentiality of your account credentials. If you suspect any unauthorized use of your KMS vets account, you shall immediately notify KMS vets team.\n\n1.5 It is your responsibility to keep your email address up-to-date on your account setup at KMS vets so that we can communicate with you electronically."
    
    static let TERMS_question3 = "2. PRIVACY POLICY"
    static let TERMS_answer3 = "2.2 We understand the privacy of all information you provide is of a primary importance. This is why we do everything possible to use it carefully and sensibly. This information is never shared with other companies or third party service providers."
    
    static let TERMS_question4 = "3. SECURITY POLICY"
    static let TERMS_answer4 = "All your transactions are 100% secure when you place an order online at KMS vets. Your personal information is encrypted by using 256-bit Secure Sockets Layer (SSL) encryption technology before being sent over the Internet, which ensures the privacy and high level of security of all your information."
    
    static let TERMS_question5 = "4. CUSTOMER ELIGIBILITY"
    static let TERMS_answer5 = "Our Customers or Users must be over 18 years of age and registered with us. KMS vets is not intended for children under the age of 18."
    
    static let TERMS_question6 = "5. PRICE AND PAYMENT"
    static let TERMS_answer6 = "5.1 All our product prices include all applicable statutory taxes.\n\n5.2 We make every effort to make sure that the pricing and availability of Products on our Website is accurate and up to date. However, rarely, there may be an error on the pricing of a product or an error related to product availability. In such cases, we are not responsible for any typographical errors and we reserve the right to cancel the sale.\n\n5.3 We reserve the right to correct any inaccuracies or omissions related to pricing and product availability/descriptions, even after you have submitted your order, and to change or update any other information at any time without prior notice.\n\n5.4 The following are our delivery charges:\n- Delivery charges for ALL orders: Rs. 25\n- FREE Delivery on Medicine orders of Rs. 1000 or more.\n\n5.5 Delivery times may vary depending on the delivery location as well as the type of product you order.\n\n5.6 You can make the payment via any one of the following methods of payment: Credit/Debit Card, Net Banking or Cash on Delivery.\n\n5.7 Credit/Debit Card and Net Banking Payments are processed via our online payment service partners."
    
    static let TERMS_question7 = "6. TERMS OF SALE"
    static let TERMS_answer7 = "6.1 KMS vets may accept or decline any order placed by a Customer in its absolute discretion without liability to you.\n\n6.2 KMS vets  reserves the right to discontinue any program or offer on its Website/App.\n\n6.3 We reserve the right, without prior notice, to limit the order quantity of any Products available on KMS vets.\n\n6.4 We acknowledge and you agree that you have fully and accurately disclosed your personal information and personal health information and consent to its use by the Pharmacy KMS vets and/or its affiliates. You confirm that you have had a physical examination by a physician and do not require a physical examination."
    
    static let TERMS_question8 = "YOU HAVE READ AND UNDERSTAND THESE TERMS AND AGREE THAT THEY SHALL BE BINDING UPON YOU AND YOUR ASSIGNS, HEIRS AND PERSONAL REPRESENTATIVES."
    static let TERMS_answer8 = "7.2 KMS vets will not dispense any prescription medication without a valid prescription from a licensed physician.\n\n7.3 If you are ordering prescription medication(s), you hereby confirm that you will send us a scanned copy of your valid prescription(s) via email, Whatsapp, and this prescription shall then be subject to the scrutiny of and approval by our qualified staff.\n\n7.4 The drug information provided in the KMS vets is for informative purposes only and this Website is not intended to provide diagnosis, treatment or medical advice. We are not liable for any adverse effects or harm to you as a result of your reliance on the information in the Website.\n\n7.5 KMS vets requires either the User or Customer or the Caregiver to confirm he/she is completely aware of the indications, side effects, drug interactions, effects of missed dose or overdose of the medicines he/she orders from us. It is imperative to seek professional advice from your physician before purchasing or consuming any medicine from KMS vets\n\n7.6 At KMS vets, a Caregiver can order prescription medicines on your behalf"
    
    static let TERMS_question9 = "RETURN POLICY"
    static let TERMS_answer9 = "We do our best to ensure that the products you order are delivered according to your specifications. However, should you receive an incomplete order, damaged or incorrect product(s), please notify KMS vets Customer Support immediately or within 10 working days of receiving the products, to ensure prompt resolution. Please note that KMS vets will not accept liability for such delivery issues if you fail to notify us within 3 working days of receipt.\n\nWe also understand that various circumstances may arise leading you to want to return a product or products that are not defective. In these cases, we may allow the return of unopened, unused products after deducting a 30% restocking charge, ONLY if you notify us within 10 working days of receipt."
    
    static let TERMS_question10 = "CONTACT INFORMATION"
    static let TERMS_answer10 = "Please contact us for any questions or comments regarding these Terms and Conditions.\nTelephone number: +91-7291055996\nE-mail: KMS vetsteam@gmail.com"
    
    //cancellation
    
    static let CANCEL_question1 = "Cancellation and Refund Policy:"
    static let CANCEL_answer1 = "1. In case of products the order can be cancelled any time before its delivery and the paid amount will be refunded by the same medium as it was paid.\n\n2. In case of services the order can be cancelled max 30 minutes before scheduled appointment. The advance payment will be refunded in the same manner as it was paid.\n\n3. In case of products the order can’t be cancelled after delivery of product. After delivery you need to contact us on given numbers for returning the item which will be picked up by our person at the fixed time after contacting you. The refund will be processed only when we get the item back by collecting person.\n\n4. If the product packing is opened or the product damaged, return and refund will not be possible.\n\n5.  In case of services no refund will be possible if cancellation is done just within 30 min of scheduled appointment time or after arrival of our service team at the decided location."

    
    
    
    
}

//MARK:- Color Constant
struct ColorConstant {
    
    static let themeColor = UIColor(red: 01/255, green: 61/255, blue: 55/255, alpha: 1)
    static let navThemeColor = UIColor(red: 01/255, green: 52/255, blue: 48/255, alpha: 1)
    
}


extension NSAttributedString
{
    convenience init(text: String, aligment: NSTextAlignment, color:UIColor) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        self.init(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor:color])
    }
}



