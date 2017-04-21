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
    let happyBackground  = [UIColor(rgb: 0xe53935), UIColor(rgb: 0xe35d5b)]
    let sadBackground    = [UIColor(rgb: 0xDAE2F8), UIColor(rgb: 0xD6A4A4)]
    let angryBackground  = [UIColor(rgb: 0xEB5757), UIColor(rgb: 0x000000)]
    
    let boredBackground  = [UIColor(rgb: 0x304352), UIColor(rgb: 0xd7d2cc)]
    let tiredBackground  = [UIColor(rgb: 0xe9d362), UIColor(rgb: 0x333333)]
    
    let normalBGColor = UIColor(red: 231.0/255.0, green: 231.0/255.0, blue: 231.0/255.0, alpha: 0.2)
    let highlightBGColor = UIColor(rgb: 0x50C9C3)
    
    let detailedLowMood  = ["Boredom", "Tiredness", "Sadness", "Anxiety"]
    let detailedHighMood = ["Stress", "Happiness", "Sadness", "Anger"]

    @IBOutlet weak var moodButton1: UIButton!
    @IBOutlet weak var moodButton2: UIButton!
    @IBOutlet weak var moodButton3: UIButton!
    @IBOutlet weak var moodButton4: UIButton!
    
    @IBOutlet weak var rawMoodStatus: UILabel!
    
    var moodProgress: KDCircularProgress!
    var moodPoint: Double = 65
    var predictedMood = "Happiness"
    var highlighedButton = 2
    
    let locationManager = CLLocationManager()
    
    var moodCircle: KDCircularProgress!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the styling for the mood progress
        moodProgress = KDCircularProgress(frame: CGRect(x: 20, y: 80, width: 300, height: 300))
        moodProgress.startAngle = -90
        moodProgress.progressThickness = 0.6
        moodProgress.trackThickness = 0.6
        moodProgress.clockwise = true
        moodProgress.glowAmount = 0
        moodProgress.gradientRotateSpeed = 2
        
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
        
//        sendNotification()
        
        // Location request to send to server
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        moodProgress.animate(toAngle: moodPoint/100*360, duration: 2, relativeDuration: true, completion: nil)
    }
    
    func setHighMood() {
        // TODO: set High mood
        moodProgress.set(colors: UIColor(rgb: 0x16BFFD), UIColor(rgb: 0xCB3066))
        
        moodButton1.setTitle(detailedHighMood[0], for: UIControlState.normal)
        moodButton2.setTitle(detailedHighMood[1], for: UIControlState.normal)
        moodButton3.setTitle(detailedHighMood[2], for: UIControlState.normal)
        moodButton4.setTitle(detailedHighMood[3], for: UIControlState.normal)
        
        if (predictedMood == "Stress") {
            moodButton1.backgroundColor = highlightBGColor
            self.view.applyGradient(colours: stressBackground)
        } else if (predictedMood == "Happiness") {
            moodButton2.backgroundColor = highlightBGColor
            self.view.applyGradient(colours: happyBackground)
        } else if (predictedMood == "Sadness") {
            moodButton3.backgroundColor = highlightBGColor
            self.view.applyGradient(colours: sadBackground)
        } else {
            moodButton4.backgroundColor = highlightBGColor
            self.view.applyGradient(colours: angryBackground)
        }
    }
    
    func setLowMood() {
        // TODO: set Low mood
        moodProgress.set(colors: UIColor(rgb: 0x16BFFD), UIColor(rgb: 0xCB3066))
        moodButton1.setTitle(detailedLowMood[0], for: UIControlState.normal)
        moodButton2.setTitle(detailedLowMood[1], for: UIControlState.normal)
        moodButton3.setTitle(detailedLowMood[2], for: UIControlState.normal)
        moodButton4.setTitle(detailedLowMood[3], for: UIControlState.normal)
        
        if (predictedMood == "Boredom") {
            moodButton1.backgroundColor = highlightBGColor
            self.view.applyGradient(colours: boredBackground)
        } else if (predictedMood == "Tiredness"){
            moodButton2.backgroundColor = highlightBGColor
            self.view.applyGradient(colours: tiredBackground)
        } else if (predictedMood == "Sadness") {
            moodButton3.backgroundColor = highlightBGColor
            self.view.applyGradient(colours: tiredBackground)
        } else {
            moodButton4.backgroundColor = highlightBGColor
            self.view.applyGradient(colours: tiredBackground)
        }
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "You are feeling " + "sad"
//        content.subtitle = "Sample sumtitle"
        content.body = "Do you want to play some music?"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Sample notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func isSpotifyInstalled() -> Bool {
        return UIApplication.shared.canOpenURL(NSURL(string:"spotify:")! as URL)
    }
    
    // Boiler plate for the Delegate of CLLocationManager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Do something
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Do something
    }

    @IBAction func buttonPressed(_ sender: Any) {
        switch highlighedButton {
        case 1:
            moodButton1.backgroundColor = normalBGColor
        case 2:
            moodButton2.backgroundColor = normalBGColor
        case 3:
            moodButton3.backgroundColor = normalBGColor
        default:
            moodButton4.backgroundColor = normalBGColor
            print("tf")
        }
        
        let clickingButton = sender as! UIButton
        clickingButton.backgroundColor = highlightBGColor
        
        if clickingButton == moodButton1 {
            highlighedButton = 1
        } else if clickingButton == moodButton2 {
            highlighedButton = 2
        } else if clickingButton == moodButton3 {
            highlighedButton = 3
        } else {
            highlighedButton = 4
        }
        
        if (moodPoint < 50) {
            self.view.applyGradient(colours: tiredBackground)
        } else {
            self.view.applyGradient(colours: angryBackground)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // your code here
            if self.isSpotifyInstalled() {
                UIApplication.shared.open(NSURL(string: "spotify:track:06TY7FCbeT7Lu39oZ0IEsN")! as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(NSURL(string: "https://open.spotify.com/track/06TY7FCbeT7Lu39oZ0IEsN")! as URL, options: [:], completionHandler: nil)
            }
        }
    }
}
