//
//  AboutAboutViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController, AboutViewInput {

    var output: AboutViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AboutModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        setupInitialState()
    }


    // MARK: AboutViewInput
    func setupInitialState() {
    }
}

extension AboutViewController {
    // MARK: actions
    
    @IBAction func actionDismiss(sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSendEmail(sender: AnyObject) {
        sendEmail()
    }
}

extension AboutViewController: MFMailComposeViewControllerDelegate {
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let emailTitle = "WalkStreets Feedback"
            let messageBody = "Feature request or bug report?"
            let toRecipents = ["hello@walkstreets.org"]
            let mailController: MFMailComposeViewController = MFMailComposeViewController()
            mailController.mailComposeDelegate = self
            mailController.setSubject(emailTitle)
            mailController.setMessageBody(messageBody, isHTML: false)
            mailController.setToRecipients(toRecipents)
            
            present(mailController, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
        case MFMailComposeResult.saved:
            print("Mail saved")
        case MFMailComposeResult.sent:
            print("Mail sent")
        case MFMailComposeResult.failed:
            print("Mail sent failure: \(String(describing: error?.localizedDescription))")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
