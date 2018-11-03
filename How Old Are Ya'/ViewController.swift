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
    @IBOutlet weak var lblDaysOld: UILabel!
    @IBOutlet weak var lblMonthsOld: UILabel!
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
        lblCurrentDate.textColor = UIColor.red
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        let convertedDate = dateFormatter.string(from: today)
        lblCurrentDate.text = convertedDate
    }
    @objc func datePickerValueChanged (datePicker: UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.medium
        dateformatter.timeStyle = DateFormatter.Style.none
        let dateValue = dateformatter.string(from: datePicker.date)
        lblBirthDate.text = "Your Birth Date: \(dateValue)"
        lblReset.isHidden = false
        calculateBirthday()
        calculateDays()
        calculateMonths()
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
            let alertView = UIAlertController(title: "Error", message: "Please select a date less than today!", preferredStyle: .alert)
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
    func calculateDays() {
        let difference = Calendar.current.dateComponents([.day], from: datePicker.date, to: today).day
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let result = formatter.string(from: NSNumber(value: difference!))
        if difference == 0 {
            lblDaysOld.text = "Days"
        } else if difference == 1 {
            lblDaysOld.text = "You are \(String(describing: result!)) Day Old"
        } else {
            lblDaysOld.text = "You are \(String(describing: result!)) Days Old"
        }
    }
    func calculateMonths() {
        let difference = Calendar.current.dateComponents([.month], from: datePicker.date, to: today).month
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let result = formatter.string(from: NSNumber(value: difference!))
        if difference == 0 {
            lblMonthsOld.text = "Months"
        } else if difference == 1 {
            lblMonthsOld.text = "You are \(String(describing: result!)) Month Old"
        } else {
            lblMonthsOld.text = "You are \(String(describing: result!)) Months Old"
        }
    }
    
//    func calulateNext() {
//        let diffInDays = Calendar.current.dateComponents([.day], from: datePicker.date, to: today).day
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = 0
//
//        lblNextYear.text = "\(String(describing: diffInDays!))"
//
//        //lblNextYear.text = dateFormatter.string(from: datePicker.date)
//        //lblNextYear.text = computeNewDate(from: datePicker.date, to: Date())
//    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        datePicker.date = today;
        lblBirthDate.text = ""
        lblAge.text = ""
        lblDaysOld.text = ""
        lblMonthsOld.text = ""
        lblNextYear.text = ""
        lblReset.isHidden = true
    }
}

