//
//  HomeViewController.swift
//  Got Covid FFF
//
//  Created by Tina Chi on 10/24/21.


import UIKit
import SafariServices

class HomeViewController: UIViewController {
    @IBOutlet weak var logActivity: UIButton!
    @IBOutlet weak var report: UIButton!
    @IBOutlet weak var covid19Data: UIButton!
    
    @IBOutlet weak var vaccineNearMe: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    setUpElements()
    }
    
    func setUpElements(){
        Utilities.styleFilledButton(logActivity)
        Utilities.styleFilledButton(report)
        Utilities.styleFilledButton(covid19Data)
        Utilities.styleFilledButton(vaccineNearMe)
        self.view.backgroundColor = .gray
    }
    
    //bad name sorry future tina; this launches CDC web page
    @IBAction func buttonTapped(){
          let vc = SFSafariViewController(url: URL(string: "https://www.cdc.gov/coronavirus/2019-ncov/index.html")!)
          present(vc, animated: true)
      }
    
    @IBAction func locatorTapped(){
          let vc = SFSafariViewController(url: URL(string: "https://www.google.com/search?tbs=lf:1&tbm=lcl&sxsrf=AOaemvKQGyLgXfSeF8VFqfyrBUVhzWuU3Q:1635728813389&q=vaccines+near+me&rflfq=1&num=10&sa=X&ved=2ahUKEwj1lfvW_PXzAhVcQzABHcl2DtcQjGp6BAgWEC8&biw=1440&bih=673&dpr=2#rlfi=hd:;si:;mv:[[26.277106887006067,-80.0141755532738],[26.09903631118347,-80.36436476225818],null,[26.18810562133277,-80.18927015776598],12]")!)
          present(vc, animated: true)
      }
    
    
    
    //below is the navigation throughout each different pages
  
    @IBAction func logActivityTapped(_ sender: Any) {
        let logActivityViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.logActivityViewController) as? LogActivityViewController
        self.view.window?.rootViewController = logActivityViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func reportTapped(_ sender: Any) {
        let reportViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.reportViewController) as? ReportViewController
        self.view.window?.rootViewController = reportViewController
        self.view.window?.makeKeyAndVisible()
    }

    
}
