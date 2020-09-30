//
//  MyCalenderViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 30/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import FSCalendar


protocol MyCalenderProtocol {
    func returnSelectedDate(selectedDate : String)
}


class MyCalenderViewController: UIViewController,FSCalendarDataSource, FSCalendarDelegate {

    @IBOutlet weak var fscalender: FSCalendar!
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var navtitleLbl: UILabel!
        
    var myCalDelegate : MyCalenderProtocol?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fscalender.delegate = self
        fscalender.dataSource = self
        backbtn.addTarget(self, action: #selector(backbtnAction), for: .touchUpInside)
        
    }
    
    
    @objc func backbtnAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
            print(date)
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatterPrint.string(from: date)
        
        //return value after selection
        myCalDelegate?.returnSelectedDate(selectedDate: dateStr)
        titleLbl.text = dateStr
        self.dismiss(animated: true, completion: nil)
    }
}
