//
//  NewViewController.swift
//  How Old Are Ya'
//
//  Created by Thomas Hill on 10/23/18.
//  Copyright © 2018 Computer Magic. All rights reserved.
//

import UIKit

let date = Date()
let calendar = Calendar.current
let year = calendar.component(.year, from: date)
let month = calendar.component(.month, from: date)
let day = calendar.component(.day, from: date)

var birthYear : Int = 0
var birthMonth : Int = 0
var birthDay : Int = 0

class NewViewController: UIViewController {
    
    @IBOutlet weak var currentDateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrent() {
        currentDateLabel.text = "Today is \(month)/\(day)/\(year)"
        currentDateLabel.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func doItButton(_ sender: UIButton) {
        //getCurrent()
    }
    
    

}
