//
//  ViewController.swift
//  How Old Are Ya'
//
//  Created by Thomas Hill on 10/20/18.
//  Copyright © 2018 Computer Magic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnCalculateHandler(_ sender: UIButton) {
        //1 - get selected date from date picker
        let birthDate = self.datePicker.date
        //let birthHour = 12
        
        //2 - get today date
        let today = Date()
        
        // Set Alert
        if birthDate >= today
        {
            //display error and return
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
        let ageHours = Int(ageDays!) * 24
        
        //5 - display age in label
        self.lblAge.text = "\(ageYears!) years, \(ageMonths!) months, \(ageDays!) days \(ageHours) hours"
        
        var time = Time(seconds: 150.0)
        print("seconds: \(time.seconds)")
        print("minutes: \(time.minutes)")
        
        time.minutes = 5
        print("seconds: \(time.seconds)")
    }
    
}

