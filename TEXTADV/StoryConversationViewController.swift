//
//  StoryConversationViewController.swift
//  TEXTADV
//
//  Created by Edrease Peshtaz on 11/8/16.
//  Copyright © 2016 mysterio group. All rights reserved.
//

import UIKit

class StoryConversationViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var storyTextView: UIView!
    @IBOutlet weak var storyTextLabel: UILabel!
    @IBOutlet weak var blinkingLabel: UILabel!
    
    var conversationTextView: UIView!
    var conversationTextLabel: UILabel!
    let storyScripts = StoryScripts()
    var conversationTextStrings: [String] = []
    
    var infoTextCounter = 1
    var timer: Timer!
    var isBlinking: Bool = false
    var segueButtonPressed: Bool = false
    var mission: Mission!
    
    
    let appleIIcolor = UIColor(red: 84/255, green: 194/255, blue: 113/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mission = MissionCreator.createMissionOne()
        
        self.backgroundView.backgroundColor = UIColor.black
        self.storyTextView.backgroundColor = UIColor.black
        self.storyTextLabel.numberOfLines = 0
        self.storyTextLabel.textColor = appleIIcolor
        self.blinkingLabel.textColor = appleIIcolor
        
        self.storyTextLabel.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        GlowEffect.addToLabel(label: self.storyTextLabel)
        GlowEffect.addToLabel(label: self.blinkingLabel)
        
        self.conversationTextStrings = self.storyScripts.introduction
        self.storyTextLabel.text = conversationTextStrings[0]
        
        
        let storyViewTap = UITapGestureRecognizer(target: self, action: #selector(updateCurrentString))
        self.storyTextView.addGestureRecognizer(storyViewTap)
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(toggleBlinkingIndicator), userInfo: nil, repeats: true)
    }

    func updateCurrentString() {
        self.isBlinking = false
        
        if self.infoTextCounter == self.conversationTextStrings.count {
            print("Do Nothing")
//            if self.segueButtonPressed == false {
//                self.placeConfirmButton(self.storyTextView)
//            }
        } else {
            self.storyTextLabel.text = self.conversationTextStrings[self.infoTextCounter]
            FontColorService.determineFontColor(inputString: self.storyTextLabel)
            
            self.infoTextCounter += 1
            print(self.infoTextCounter)
            
            if self.infoTextCounter == self.conversationTextStrings.count && self.segueButtonPressed == false {
                self.placeConfirmButton(self.storyTextView)
            }
        }
    }
    
    func toggleBlinkingIndicator() {
        if self.infoTextCounter == self.conversationTextStrings.count {
            self.blinkingLabel.alpha = 0
        } else {
            if self.isBlinking == false {
                self.blinkingLabel.alpha = 1
                self.isBlinking = true
            } else {
                self.blinkingLabel.alpha = 0
                self.isBlinking = false
            }
        }
    }
    
    func placeConfirmButton(_ superview: UIView) {

        let nextButton = UIButton(type: .custom)
        nextButton.addTarget(self, action: #selector(self.goToPreMission), for: .touchUpInside)
        nextButton.setTitle("GO TO PRE-MISSION", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        nextButton.setTitleColor(self.appleIIcolor, for: UIControlState())
        nextButton.setTitleColor(UIColor.gray, for: .highlighted)
        nextButton.sizeToFit()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        superview.addSubview(nextButton)
        
        GlowEffect.addToButton(button: nextButton)
        
        let nextButtonVerticalConstraint = NSLayoutConstraint(item: nextButton, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1.8, constant: 0)
        let nextButtonHorizontalConstraint = NSLayoutConstraint(item: nextButton, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: 0)
        
        superview.addConstraint(nextButtonVerticalConstraint)
        superview.addConstraint(nextButtonHorizontalConstraint)
        
        self.segueButtonPressed = true
        
    }
    
    func goToPreMission() {
        performSegue(withIdentifier: "ToPreMissionViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToPreMissionViewController" {
            if let vc = segue.destination as? MissionStartViewController {
                vc.mission = self.mission
            }
        }
    }

}
