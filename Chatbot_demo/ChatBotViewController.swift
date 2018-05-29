//
//  ChatBotViewController.swift
//  Chatbot_demo
//
//  Created by NETBIZ on 16/05/18.
//  Copyright © 2018 Netbiz.in. All rights reserved.
//

import UIKit
import AVFoundation
import ApiAI
import SwiftMessages

class ChatBotViewController: UIViewController {
    
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var chatWindowTextView: UITextView!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    var chatConversation: String = ""
    
    @IBAction func sendMessage(_ sender:Any){
        let request = ApiAI.shared().textRequest()
        
        if let text = messageTextView.text, text != "" {
            chatConversation.append("Me: \(text)\n")
            chatWindowTextView.text = chatConversation
            chatWindowTextView .scrollRangeToVisible(NSRange.init(location: 0, length: chatConversation.count+10))
            chatWindowTextView.scrollsToTop = false
            
            
            request?.query = text
        }else {
            return
        }
        
        request?.setMappedCompletionBlockSuccess({(request, response) in
            let response = response as! AIResponse
            if let textResponse = response.result.fulfillment.speech{
                self.chatConversation.append("Chip: \(textResponse)\n")
                self.chatWindowTextView .scrollRangeToVisible(NSRange.init(location: 0, length: self.chatConversation.count+10))
                self.chatWindowTextView.scrollsToTop = false
                
                self.speechAndText(textToSpeak: textResponse)
            }
        }, failure:{(request, error) in
            print(error!)
        })
        
        ApiAI.shared().enqueue(request)
        messageTextView.text = ""
        
    }
    
    func speechAndText(textToSpeak: String){
        let speechUtterance = AVSpeechUtterance(string: textToSpeak)
        speechSynthesizer.speak(speechUtterance)
        
        //self.chatWindowTextView.text = textToSpeak
        self.chatWindowTextView.text = self.chatConversation
        self.chatWindowTextView .scrollRangeToVisible(NSRange.init(location: 0, length: self.chatConversation.count+10))
        self.chatWindowTextView.scrollsToTop = false
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
        self.messageTextView.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func closeChat(_ sender: Any) {
        
        let alertController = UIAlertController.init(title: "Exit chat?", message: "Are you sure you wish to exit the chat?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { yesAction in
            
            let status = MessageView.viewFromNib(layout: .statusLine)
            status.backgroundView.backgroundColor = #colorLiteral(red: 1, green: 0.3430328965, blue: 0.3745915294, alpha: 1)
            status.bodyLabel?.textColor = UIColor.white
            status.configureContent(body: "Chat window closed. Glad we could help")
            var statusConfig = SwiftMessages.defaultConfig
            statusConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
            
            SwiftMessages.show(config: statusConfig, view: status)
            
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func styleUI() {
        messageTextView.layer.borderWidth = 1.0
        messageTextView.layer.borderColor = #colorLiteral(red: 0.9240000248, green: 0.6230000257, blue: 0.01799999923, alpha: 1)
        messageTextView.layer.cornerRadius = 5.0
        
        chatWindowTextView.layer.borderWidth = 1.0
        chatWindowTextView.layer.borderColor = #colorLiteral(red: 0.9240000248, green: 0.6230000257, blue: 0.01799999923, alpha: 1)
        chatWindowTextView.layer.cornerRadius = 5.0
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


