//
//  ViewController.swift
//  How Old Are Ya'
//
//  Created by Thomas Hill on 10/20/18.
//  Copyright © 2018 Computer Magic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var lblBirthDate: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let today = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCurrentDate()
        datePicker.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
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
        calculateBirthday()
    }
    func calculateBirthday() {
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
        self.lblAge.text = "\(ageYears!) years, \(ageMonths!) months, \(ageDays!) days"

        //        var time = Time(seconds: 150.0)
        //        print("seconds: \(time.seconds)")
        //        print("minutes: \(time.minutes)")
        //
        //        time.minutes = 5
        //        print("seconds: \(time.seconds)")
    }
}

