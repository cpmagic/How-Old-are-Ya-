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
let imgCake: UIImageView = {
    let theImageView = UIImageView()
    theImageView.image = UIImage(named: "cake.jpg")
    theImageView.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
    return theImageView }()

class ViewController: UIViewController {
    
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var lblBirthDate: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblYouAre: UILabel!
    @IBOutlet weak var lblMinutesOld: UILabel!
    @IBOutlet weak var lblHoursOld: UILabel!
    @IBOutlet weak var lblDaysOld: UILabel!
    @IBOutlet weak var lblWeeksOld: UILabel!
    @IBOutlet weak var lblMonthsOld: UILabel!
    @IBOutlet weak var lblYearsOld: UILabel!
    @IBOutlet weak var lblReset: UIButton!
    @IBOutlet weak var lblSelectBirthDate: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        showCurrentDate()
        datePicker.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
        view.addSubview(imgCake) //This add it the view controller without constraints
        imgCakeConstraints()
    }
    func updateUI() {
        lblBirthDate.isHidden = true
        lblAge.isHidden = true
        lblYouAre.isHidden = true
        lblMinutesOld.isHidden = true
        lblHoursOld.isHidden = true
        lblDaysOld.isHidden = true
        lblWeeksOld.isHidden = true
        lblMonthsOld.isHidden = true
        lblYearsOld.isHidden = true
        lblReset.isHidden = true
        lblSelectBirthDate.isHidden = false
        imgCake.isHidden = false
        datePicker.date = today
    }
    func showCurrentDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        let convertedDate = dateFormatter.string(from: today)
        lblCurrentDate.text = convertedDate
    }
    @objc func datePickerValueChanged (datePicker: UIDatePicker) {
        if datePicker.date >= today {
            updateUI()
        } else {
        lblYouAre.isHidden = false
        imgCake.isHidden = true
        lblSelectBirthDate.isHidden = true
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.full
        dateformatter.timeStyle = DateFormatter.Style.none
        let dateValue = dateformatter.string(from: datePicker.date)
        lblBirthDate.isHidden = false
        lblBirthDate.text = "\(dateValue)"
        lblBirthDate.adjustsFontSizeToFitWidth = true
        lblAge.isHidden = false
        lblAge.adjustsFontSizeToFitWidth = true
        lblReset.isHidden = false
        lblSelectBirthDate.isHidden = true
        calculateBirthday()
        calculateYears()
        calculateMonths()
        calculateWeeks()
        calculateDays()
        calculateHours()
        calculateMinutes()
        }
    }
    func calculateBirthday() {
        var txtYear = ""
        var txtMonth = ""
        var txtDay = ""
        let birthDate = self.datePicker.date
        if birthDate >= today
        {
            let alertView = UIAlertController(title: "Error", message: "Please select a date less than today!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertView.addAction(action)
            self.present(alertView, animated: false, completion: nil)
            return
        }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: birthDate, to: today)
        let ageYears = components.year
        let ageMonths = components.month
        let ageDays = components.day
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
        self.lblAge.text = "\(ageYears!) \(txtYear) - \(ageMonths!) \(txtMonth) - \(ageDays!) \(txtDay) Old"
    }
    func calculateYears() {
        let difference = Calendar.current.dateComponents([.year], from: datePicker.date, to: today).year
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let result = formatter.string(from: NSNumber(value: difference!))
        if difference == 0 {
            lblYearsOld.isHidden = true
        } else if difference == 1 {
            lblYearsOld.isHidden = false
            lblYearsOld.text = "\t\(String(describing: result!)) Year Old"
        } else {
            lblYearsOld.isHidden = false
            lblYearsOld.text = "\t\(String(describing: result!)) Years Old"
        }
    }
    func calculateMonths() {
        let difference = Calendar.current.dateComponents([.month], from: datePicker.date, to: today).month
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let result = formatter.string(from: NSNumber(value: difference!))
        if difference == 0 {
            lblMonthsOld.isHidden = true
        } else if difference == 1 {
            lblMonthsOld.isHidden = false
            lblMonthsOld.text = "\t\(String(describing: result!)) Month Old"
        } else {
            lblMonthsOld.isHidden = false
            lblMonthsOld.text = "\t\(String(describing: result!)) Months Old"
        }
    }
    func calculateWeeks() {
        let difference = Float(Calendar.current.dateComponents([.day], from: datePicker.date, to: today).day! / 7)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        let result = formatter.string(from: NSNumber(value: difference))
        if difference == 0 {
            lblWeeksOld.isHidden = true
        } else if difference == 1 {
            lblWeeksOld.isHidden = false
            lblWeeksOld.text = "\t\(String(describing: result!)) Week Old"
        } else {
            lblWeeksOld.isHidden = false
            lblWeeksOld.text = "\t\(String(describing: result!)) Weeks Old"
        }
    }
    func calculateDays() {
        let difference = Calendar.current.dateComponents([.day], from: datePicker.date, to: today).day
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let result = formatter.string(from: NSNumber(value: difference!))
        if difference == 0 {
            lblDaysOld.isHidden = true
        } else if difference == 1 {
            lblDaysOld.isHidden = false
            lblDaysOld.text = "\t\(String(describing: result!)) Day Old"
        } else {
            lblDaysOld.isHidden = false
            lblDaysOld.text = "\t\(String(describing: result!)) Days Old"
        }
    }
    func calculateHours() {
        let difference = Float(Calendar.current.dateComponents([.day], from: datePicker.date, to: today).day! * 24)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        let result = formatter.string(from: NSNumber(value: difference))
        if difference == 0 {
            lblHoursOld.isHidden = true
        } else if difference == 1 {
            lblHoursOld.isHidden = false
            lblHoursOld.text = "\t\(String(describing: result!)) Hours Old"
        } else {
            lblHoursOld.isHidden = false
            lblHoursOld.text = "\t\(String(describing: result!)) Hours Old"
        }
    }
    func calculateMinutes() {
        let difference = Float(Calendar.current.dateComponents([.day], from: datePicker.date, to: today).day! * 1440)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        let result = formatter.string(from: NSNumber(value: difference))
        if difference == 0 {
            lblMinutesOld.isHidden = true
        } else if difference == 1 {
            lblMinutesOld.isHidden = false
            lblMinutesOld.text = "\t\(String(describing: result!)) Minutes Old"
        } else {
            lblMinutesOld.isHidden = false
            lblMinutesOld.text = "\t\(String(describing: result!)) Minutes Old"
        }
    }
    @IBAction func btnReset(_ sender: UIButton) {
        updateUI()
    }
    
    //MARK: Layout Constraints
    func imgCakeConstraints() {
        imgCake.widthAnchor.constraint(equalToConstant: 203).isActive = true
        imgCake.heightAnchor.constraint(equalToConstant: 249).isActive = true
        imgCake.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgCake.topAnchor.constraint(equalTo: view.topAnchor, constant: +110).isActive = true
//      imgCake.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
    }
}
//  func calculateNextYear() {
//            var txtYear = ""
//            var txtMonth = ""
//            var txtDay = ""
//            let birthDate = self.datePicker.date
//            if birthDate >= today
//            {
//                let alertView = UIAlertController(title: "Error", message: "Please select a date less than today!", preferredStyle: .alert)
//                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alertView.addAction(action)
//                self.present(alertView, animated: false, completion: nil)
//                return
//            }
//            let calendar = Calendar.current
//            let components = calendar.dateComponents([.year, .month, .day], from: today, to: datePicker.date)
//            let ageYears = components.year
//            let ageMonths = components.month
//            let ageDays = components.day
//            if ageYears == -1 {
//                txtYear = "Year"
//            }
//            else {
//                txtYear = "Years"
//            }
//            if ageMonths == -1 {
//                txtMonth = "Month"
//            }
//            else {
//                txtMonth = "Months"
//            }
//            if ageDays == -1 {
//                txtDay = "Day"
//            }
//            else {
//                txtDay = "Days"
//            }
//        self.lblNextYear.text = "\(abs(ageYears!)) \(txtYear), \(abs(ageMonths!)) \(txtMonth), \(abs(ageDays!)) \(txtDay) until birthday"
//    }
