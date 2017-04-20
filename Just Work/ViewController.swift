//
//  ViewController.swift
//  Just Work
//
//  Created by Jarvis Luong on 20/04/2017.
//  Copyright © 2017 Hai Dang Luong. All rights reserved.
//

import UIKit
import CoreLocation
import KDCircularProgress
import UserNotifications


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let stressBackground = [UIColor(rgb: 0x757F9A), UIColor(rgb: 0xd7dde8)]
    let happyBackground = [UIColor(rgb: 0xe53935), UIColor(rgb: 0xe35d5b)]
    let sadBackground = [UIColor(rgb: 0xDAE2F8), UIColor(rgb: 0xD6A4A4)]
    let angryBackground = [UIColor(rgb: 0xEB5757), UIColor(rgb: 0x000000)]
    
    let boredBackground = [UIColor(rgb: 0x304352), UIColor(rgb: 0xd7d2cc)]
    let tiredBackground = [UIColor(rgb: 0xe9d362), UIColor(rgb: 0x333333)]
    
    static let calmMood = [UIColor(rgb: 0x007991), UIColor(rgb: 0x78FFD6)]
    static let highMood = [UIColor(rgb: 0xF09819), UIColor(rgb: 0xFF512F)]
    
    let detailedLowMood = ["Boredom", "Tiredness"]
    let detailedHighMood = ["Stress", "Happiness", "Sadness", "Anger"]

    @IBOutlet weak var moodButton1: UIButton!
    @IBOutlet weak var moodButton2: UIButton!
    @IBOutlet weak var moodButton3: UIButton!
    @IBOutlet weak var moodButton4: UIButton!
    
    @IBOutlet weak var groupBtn34: UIStackView!
    
    @IBOutlet weak var rawMoodStatus: UILabel!
    
    var moodProgress: KDCircularProgress!
    var moodPoint: Double = 70.0
    var predictedMood = "Stress"
    
    var locationManager = CLLocationManager()
    
    var moodCircle: KDCircularProgress!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the styling for the mood progress
        moodProgress = KDCircularProgress(frame: CGRect(x: 20, y: 80, width: 300, height: 300))
        moodProgress.angle = moodPoint/100*360
        moodProgress.startAngle = -90
        moodProgress.progressThickness = 0.6
        moodProgress.trackThickness = 0.6
        moodProgress.clockwise = true
        moodProgress.glowAmount = 0
        
        if (moodPoint < 50) {
            setLowMood()
            rawMoodStatus.text = "Down"
        } else {
            setHighMood()
            rawMoodStatus.text = "Aroused"
        }
        
        moodProgress.center = CGPoint(x: view.center.x,y: 230)
        moodProgress.trackColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        self.view.addSubview(moodProgress)
        
        // Register for local notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound,.badge], completionHandler: {didAllow, error in})
        
        sendNotification()
        
        // Location request to send to server
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    func setHighMood() {
        // TODO: set High mood
        moodProgress.set(colors: UIColor(rgb: 0x16BFFD), UIColor(rgb: 0xCB3066))
        
        moodButton1.setTitle(detailedHighMood[0], for: UIControlState.normal)
        moodButton2.setTitle(detailedHighMood[1], for: UIControlState.normal)
        moodButton3.setTitle(detailedHighMood[2], for: UIControlState.normal)
        moodButton4.setTitle(detailedHighMood[3], for: UIControlState.normal)
        
        if (predictedMood == "Stress") {
            moodButton1.backgroundColor = UIColor.blue
            self.view.applyGradient(colours: stressBackground)
        } else if (predictedMood == "Happiness") {
            moodButton2.backgroundColor = UIColor.blue
            self.view.applyGradient(colours: happyBackground)
        } else if (predictedMood == "Sadness") {
            moodButton3.backgroundColor = UIColor.blue
            self.view.applyGradient(colours: sadBackground)
        } else {
            moodButton4.backgroundColor = UIColor.blue
            self.view.applyGradient(colours: angryBackground)
        }
    }
    
    func setLowMood() {
        // TODO: set Low mood
        moodProgress.set(colors: UIColor(rgb: 0x16BFFD), UIColor(rgb: 0xCB3066))
        moodButton1.setTitle(detailedLowMood[0], for: UIControlState.normal)
        moodButton2.setTitle(detailedLowMood[1], for: UIControlState.normal)
        groupBtn34.isHidden = true
        
        if (predictedMood == "Boredom") {
            moodButton1.backgroundColor = UIColor.blue
            self.view.applyGradient(colours: boredBackground)
        } else {
            moodButton2.backgroundColor = UIColor.blue
            self.view.applyGradient(colours: tiredBackground)
        }
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Sample title"
        content.subtitle = "Sample sumtitle"
        content.body = "Sample body"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Sample notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    // Boiler plate for the Delegate of CLLocationManager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Do something
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Do something
    }
    
    @IBAction func button1Pressed(_ sender: Any) {
        if (moodPoint < 50) {
            
        }
    }

    @IBAction func button2Pressed(_ sender: Any) {
        
    }
    
    @IBAction func button3Pressed(_ sender: Any) {
        
    }

    @IBAction func button4Pressed(_ sender: Any) {
        
    }
}
