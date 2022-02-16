//
//  AppDelegate.swift
//  Got Covid FFF
//
//  Created by Tina Chi on 10/24/21.
//

//NOTES NOTES NOTES NOTES NOTES_____________________________!
//left off at setting up the firebase data store. now you can update names into the list in fire store: (collection:"users", document ID: "userLogData", fields: "fullName" and "phoneNumbers". data has been adding correctly.

//need to complete: make the remove previous person function work so user can take out people. Then you need to somehow get each number in the array as a form of a string

// fire base tends to get the whole array, so you can make a function that reads the phone number between the "" or whatever it is
// "phoneNumbers": <__NSArrayM 0x6000039d32a0>(
//9545312263
//)
//]
// and then you need to set up twilio, but once you get the indiviual string for the phone number, the twilio part is easy.





import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseAnalytics

import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


   


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.

    
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

