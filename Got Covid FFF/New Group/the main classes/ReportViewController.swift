//
//  ReportViewController.swift
//  Got Covid FFF
//
//  Created by Tina Chi on 10/25/21.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseAnalytics
import FirebaseFirestore
import AVFoundation

class ReportViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var questionContent: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    var db = Firestore.firestore()

    
    
    var questionNum = 1
    var points = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        questions()
        reportButton.isHidden = true
        super.viewDidLoad()
    }
    
    
    
    @IBAction func reportButtonPressed(_ sender: Any) {
        
        //Get the array of phone numbers from firestore
        Firestore.firestore().collection("phoneNums").document("phoneNumss").getDocument {
            (document, error) in
            if let document = document {
                let group_array = document["numbers"] as? Array ?? [""]
                print(group_array)
          
                for i in 0...group_array.count-1{
            print("Starting...")
            let twilioSID = "AC3848b02bf953a72175a1999d134dfd3f"
            let twilioSecret = "2cf2cf1d9f47675ff5d9c014346daeb4"
            //Note replace + = %2B , for To and From phone number
            let fromNumber = "15012546162"
                    print("PRINTTINGGG THEEE INDIVIDUALLL PHONEEE NUMBERRRSS")
                print(group_array[i])
                
            let toNumber = group_array[i]
            let message = "You've been in contact with someone who's likely to have Covid-19. Get tested and stay quarantined. -Got Covid app "

            // Build the request
            let request = NSMutableURLRequest(url: URL(string:"https://\(twilioSID):\(twilioSecret)@api.twilio.com/2010-04-01/Accounts/\(twilioSID)/SMS/Messages")!)
            request.httpMethod = "POST"
            request.httpBody = "From=\(fromNumber)&To=\(toNumber)&Body=\(message)".data(using: .utf8)

            // Build the completion block and send the request
            URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                print("Finished")
                if let data = data, let responseDetails = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    // Success
                    print("Response: \(responseDetails)")
                } else {
                    // Failure
                    print("Error: \(error)")
                }
            }).resume()
                
            }
            }
        }
    }
    
    
    
    
    func questions(){
        switch questionNum{
        case 1:
            questionContent.text = "Have you been experiencing unusual headaches?"

            questionNumber.text = "Question 1"
        case 2:
            questionContent.text = "Do you have a fever?"
            questionNumber.text = "Question 2"
        case 3:
            questionContent.text = "Are you experiencing a lack of taste/smell"
            questionNumber.text = "Question 3"
        case 4:
            questionContent.text = "Have you been in close contact with someone who tested positive?"
            questionNumber.text = "Question 4"
        case 5:
            questionContent.text = "Have you been experiencing unusual vomiting?"
            questionNumber.text = "Question 5"
        case 6:
            questionContent.text = "Does your throat hurt at all when you swallow something"
            questionNumber.text = "Question 6"
        case 7:
            questionContent.text = "Are you experiencing unusual tiredness?"
            questionNumber.text = "Question 7"
        case 8:
            questionContent.text = "Have you been running out of breath easily?"
            questionNumber.text = "Question 8"
        case 9:
            yesButton.isHidden = true
            noButton.isHidden = true
            questionNumber.isHidden = true
            headerLabel.isHidden = true
            if (points > 99){
            questionContent.text = "The quiz have shown that you are likely to have contracted Covid-19. This is not an official test and there is no certainty that you have Covid-19.\nWhen you click report, everyone that you have been in close contact with with be anonymously notified that they have been close contact with someone that is possibly Covid-19 positive. Are you sure you want to report? "
                reportButton.isHidden = false
            }else{
            questionContent.text = "The quiz have shown that you are NOT likely to have contracted Covid-19. This is not an official test and there is no certainty that you DO NOT have Covid-19.\nYou cannot make false reports. Do you still want to report?"
                yesButton.isHidden = false
                noButton.isHidden = false
                reportButton.isHidden = true
            }
        default:
            print ("default case pppppppp")
        }
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        switch questionNum{
        case 1: points = points + 50
        case 2: points = points + 100
        case 3: points = points + 100
        case 4: points = points + 100
        case 5: points = points + 50 
        case 6: points = points + 100
        case 7: points = points + 50
        case 8: points = points + 50
        case 10: questionContent.text = "When you click report, everyone that you have been in close contact with with be anonymously notified that they have been close contact with someone that is possibly Covid-19 positive. Are you sure you want to report?"
            yesButton.isHidden = true
            noButton.isHidden = true
            reportButton.isHidden = false
        default: print ("case is default right now. this is the console.")
        }
        questionNum = questionNum + 1
        questions()
        
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        questionNum = questionNum + 1
        questions()
        if ( questionNum == 10 ){
            //go back to the main screen
            let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
            
            self.view.window?.rootViewController = homeViewController
            self.view.window?.makeKeyAndVisible()
        }
        }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.makeKeyAndVisible()
    }
    
}

