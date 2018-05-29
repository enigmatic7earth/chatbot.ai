//
//  ViewController.swift
//  Chatbot_demo
//
//  Created by NETBIZ on 16/05/18.
//  Copyright © 2018 Netbiz.in. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var chatButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        pulsateAnimation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chatClicked(_ sender: Any) {
//        performSegue(withIdentifier: "showChatViewController", sender: sender)
    }
    
    func pulsateAnimation(){
        let pulsateAnimation = CASpringAnimation(keyPath: "transform.scale")
        pulsateAnimation.autoreverses = true
        pulsateAnimation.damping = 0.8
        pulsateAnimation.duration = 0.7
        pulsateAnimation.initialVelocity = 0.5
        pulsateAnimation.repeatCount = 1
        pulsateAnimation.fromValue = 1.0
        pulsateAnimation.toValue = 1.12
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = 1000
        animationGroup.animations = [pulsateAnimation]
        chatButton.layer.add(animationGroup, forKey: "pulse")
    }
    
}


