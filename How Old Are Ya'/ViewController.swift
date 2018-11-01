//
//  ViewController.swift
//  How Old Are Ya'
//
//  Created by Thomas Hill on 10/20/18.
//  Copyright © 2018 Computer Magic. All rights reserved.
//

import UIKit

let today = Date()
let calendar = Calendar.current
let year = calendar.component(.year, from: today)
let month = calendar.component(.month, from: today)
let day = calendar.component(.day, from: today)

class ViewController: UIViewController {
    
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var lblBirthDate: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblNextYear: UILabel!
    @IBOutlet weak var lblReset: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBirthDate.text = ""
        lblAge.text = ""
        lblReset.isHidden = true
        showCurrentDate()
        datePicker.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
        lblAge.adjustsFontSizeToFitWidth = true
    }
    
    func showCurrentDate() {
        lblCurrentDate.text = "Today is \(month)/\(day)/\(year)"
        lblCurrentDate.adjustsFontSizeToFitWidth = true
    }
    
    @objc func datePickerValueChanged (datePicker: UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.medium
        dateformatter.timeStyle = DateFormatter.Style.none
        let dateValue = dateformatter.string(from: datePicker.date)
        lblBirthDate.text = "Your Birth Date: \(dateValue)"
        lblReset.isHidden = false
        calculateBirthday()
        calulateNext()
    }
    func calculateBirthday() {
        var txtYear = ""
        var txtMonth = ""
        var txtDay = ""
        //1 - get selected date from date picker
        let birthDate = self.datePicker.date
        //2 Set Alert
        if birthDate >= today
        {
            let alertView = UIAlertController(title: "Error", message: "Please enter a valid date", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertView.addAction(action)
            self.present(alertView, animated: false, completion: nil)
            return
        }
        //3 - create an instance of the user's current calendar
        let calendar = Calendar.current
        //4 - use calendar to get difference between two dates
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: birthDate, to: today)
        let ageYears = components.year
        let ageMonths = components.month
        let ageDays = components.day
        //5 - display age in label
        if ageYears == 1 {
            txtYear = "Year"
        }
        else {
            txtYear = "Years"
        }
        if ageMonths == 1 {
            txtMonth = "Month"
        }
        else {
            txtMonth = "Months"
        }
        if ageDays == 1 {
            txtDay = "Day"
        }
        else {
            txtDay = "Days"
        }
        self.lblAge.text = "You are \(ageYears!) \(txtYear), \(ageMonths!) \(txtMonth), \(ageDays!) \(txtDay) Old"
    }
    
    func calulateNext() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy"
//        let birthYear: String = dateFormatter.string(from: self.datePicker.date)
//        dateFormatter.dateFormat = "MM"
//        let birthMonth: String = dateFormatter.string(from: self.datePicker.date)
//        dateFormatter.dateFormat = "dd"
//        let birthDay: String = dateFormatter.string(from: self.datePicker.date)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day,.month,.year], from: self.datePicker.date)
        let day = components.day
        let month = components.month
        let year = components.year
//            let birthDay = String(day)
//            let monthString = String(month)
//            let yearString = String(year)
        
        let yearsToAdd = 1
        let currentDate = Date()
        
        var dateComponent = DateComponents()
                dateComponent.year = yearsToAdd
        
        //let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        lblNextYear.text = "\(day!) \(today)"
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        datePicker.date = today;
        lblBirthDate.text = ""
        lblAge.text = ""
        lblNextYear.text = ""
        lblReset.isHidden = true
    }
}

