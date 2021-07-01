//
//  ViewController.swift
//  AlertDatePicker
//
//  Created by David Yoon on 2021/07/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblSelectedTime: UILabel!
    
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var count = 0
    var alarmTime: String?
    var delayAlert = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self , selector: timeSelector , userInfo: nil ,repeats: true)
    }
    
    
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        
        lblSelectedTime.text = "선택시간: " + formatter.string(from: datePickerView.date)
        
        formatter.dateFormat = "hh:mm aaa"
        alarmTime = formatter.string(from: datePickerView.date)
    }
    
    
    @objc func updateTime() {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        
        lblCurrentTime.text = "현재시간: " + formatter.string(from: date as Date)
        
        formatter.dateFormat = "hh:mm aaa"
        if(delayAlert == true) {
            count += 1
        }
        if (count == 59) {
            delayAlert = false
            count = 0
        }
        
        let currentTime = formatter.string(from: date as Date)
        print("\(alarmTime), \(currentTime), \(delayAlert), \(count)")
        if (alarmTime == currentTime && delayAlert == false) {
            let timeAlert = UIAlertController(title: "알림", message: "설정된 시간입니다", preferredStyle: UIAlertController.Style.alert)
            let delayAction = UIAlertAction(title: "알겠습니다.", style: UIAlertAction.Style.default, handler: {
                Alert in self.delayAlert = true
            })
            timeAlert.addAction(delayAction)
            present(timeAlert, animated: true, completion: nil)
        }
        
        
    }
    


}

