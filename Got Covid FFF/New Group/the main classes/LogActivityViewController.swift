//
//  LogActivityViewController.swift
//  Got Covid FFF
//
//  Created by Tina Chi on 10/25/21.
//
import Foundation


import UIKit
import Firebase
//import FirebaseCore
import FirebaseAuth
import FirebaseAnalytics
import FirebaseFirestore
import AVFoundation


class LogActivityViewController: UIViewController {
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addPersonButton: UIButton!
    @IBOutlet weak var removePersonButton: UIButton!
    @IBOutlet weak var listOfNames: UILabel!
    var db = Firestore.firestore()

    override func viewDidLoad() {
getNames()
getDataOfNames()

 
    }
    
    
    
    
    
    @IBAction func addPersonTapped(_ sender: Any) {
        phoneNumberTextField.resignFirstResponder()
        addToLog()
        getDataOfNames()
        getNames()
    }
    
    @IBAction func removePersonTapped(_ sender: Any) {
        phoneNumberTextField.resignFirstResponder()
        fullNameTextField.resignFirstResponder()
        removeFromLog()
        getDataOfNames()
        getNames()
    }
    
    func addToLog(){
        let fullName = fullNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let fullNames = db.collection("users").document("userLogData")
           fullNames.updateData([
            "fullName": FieldValue.arrayUnion([fullName])
           ])

        let phoneNumber = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let allNums = db.collection("phoneNums").document("phoneNumss")
           allNums.updateData([
               "numbers": FieldValue.arrayUnion([phoneNumber])
           ])
    }
    
    

    
    func removeFromLog(){
        let fullName = fullNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let fullNames = db.collection("users").document("userLogData")
           fullNames.updateData([
            "fullName": FieldValue.arrayRemove([fullName])
           ])

        let phoneNumber = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let allNums = db.collection("phoneNums").document("phoneNumss")
           allNums.updateData([
               "numbers": FieldValue.arrayRemove([phoneNumber])
           ])
    }
  
  
    func getDataOfNames(){
        db.collection("users").document("userLogData")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }
              print("Current data: \(data)")
            }
            }
    
    
    
    func getDataOfNumbers(){
        Firestore.firestore().collection("phoneNums").document("phoneNumss").getDocument {
            (document, error) in
            if let document = document {
                let group_array = document["numbers"] as? Array ?? [""]
                print("________________AHHHHHHHHH________________")
                print(group_array)
            }
        }
    }
        
        func getNames(){
            var listNames = ""
            Firestore.firestore().collection("users").document("userLogData").getDocument {
                (document, error) in
                if let document = document {
                    let group_array = document["fullName"] as? Array ?? [""]
                    print("________________AHHHHHHHHH________________")
                    print(group_array)
                    
                    if group_array.count > 0{
                    for i in 0...group_array.count-1{
                   listNames = listNames + group_array[i] + "\n"
                    }
                    self.listOfNames.text = listNames
                }
                }
        }
        
    }
    
    
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.makeKeyAndVisible()
    }
    
    
    
    
}


