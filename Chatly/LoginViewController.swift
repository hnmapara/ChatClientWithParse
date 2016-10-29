//
//  ViewController.swift
//  Chatly
//
//  Created by Matthew Carroll on 10/26/16.
//  Copyright © 2016 codepath.com. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onLoginTap(_ sender: AnyObject) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if user != nil {
                // TODO: go to home screen
                NSLog("Successfully logged in.")
                self.segueToChatView()
            } else {
                self.showErrorAlert(title: "Login Failed", message: "Login failed. Please try again.")
            }
        }
    }
    
    
    @IBAction func onSignUpTap(_ sender: AnyObject) {
        var user = PFUser()
        user.username = usernameTextField.text ?? ""
        user.password = passwordTextField.text ?? ""
        user.email = emailTextField.text ?? ""
        // other fields can be set just like with PFObject
//        user["phone"] = "415-392-0202"
        
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                self.showErrorAlert(title: "Sign Up Failed", message: error.localizedDescription)
            } else {
                // Hooray! Let them use the app now.
                NSLog("Successfully signed up!")
                self.segueToChatView()
            }
        }
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func segueToChatView() {
        performSegue(withIdentifier: "SegueToChat", sender: nil)
    }
}

