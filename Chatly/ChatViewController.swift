//
//  ChatViewController.swift
//  Chatly
//
//  Created by Harshit Mapara on 10/26/16.
//  Copyright © 2016 codepath.com. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    var messages:[PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
//        updateMessages()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer: Timer) in
            self.updateMessages()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSend(_ sender: AnyObject) {
        let chatMessage = PFObject(className:"Message")
        chatMessage["text"] = chatTextField.text
        chatMessage["user"] = PFUser.current()
        
        chatMessage.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                NSLog("Message sent")
                self.chatTextField.text = ""
            } else {
                NSLog("Error: " + (error?.localizedDescription)!)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message") as! ChatMessageTableViewCell
        
        cell.message = messages[indexPath.row]["text"] as? String ?? "EMPTY"
        cell.username = (messages[indexPath.row]["user"] as? PFObject)?["username"] as? String ?? "EMPTY"
        
        return cell
    }

    private func updateMessages() {
        var query = PFQuery(className:"Message")
//        query.whereKey("playerName", equalTo:"Sean Plott")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        if nil != object {
                            print(object["text"] ?? "")
                            print(object["user"] ?? "")
                        }
                    }
                }
                
                self.messages = objects!
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.localizedDescription)")
            }
        }
    }
}
