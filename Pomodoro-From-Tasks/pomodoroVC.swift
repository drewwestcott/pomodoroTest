//
//  pomodoroVC.swift
//  Pomodoro-From-Tasks
//
//  Created by Drew Westcott on 07/07/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import UIKit

class pomodoroVC: UIViewController {
    
    @IBOutlet weak var pomodoroLabel: UILabel!
    
    var timerMinutes = 25
    var timerSeconds = 00
    
    var pomodoro = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        updateTimer()
        let theSelector : Selector = "updateTimer"
        pomodoro = Timer.scheduledTimer(timeInterval: 1, target: self, selector: theSelector, userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func updateTimer() {
        timerSeconds = timerSeconds - 1
        if timerSeconds < 0 {
            timerSeconds = 59
            timerMinutes -= 1
        }
        pomodoroLabel.text = "\(timerMinutes) : \(timerSeconds)"
        if timerMinutes < 0 {
            print("DW:reached zero")
            self.pomodoro.invalidate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
