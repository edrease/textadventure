//
//  ViewController.swift
//  TEXTADV
//
//  Created by Edrease Peshtaz on 8/6/16.
//  Copyright © 2016 mysterio group. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//MARK: Outlets
    @IBOutlet weak var infoTextView: UIView!
    @IBOutlet weak var actionListView: UIView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var infoTextLabel: UILabel!
    @IBOutlet weak var blinkingIndicatorLabel: UILabel!
    @IBOutlet weak var actionsRemainingView: UIView!
    @IBOutlet weak var actionsRemainingLabel: UILabel!
    
    var tableView: UITableView = UITableView()
    
//MARK: Variables
    var currentArray: [String] = ["You walk into Boss office.",
                                  "You see boss playing solitare.",
                                  "He looks up, 'What can I do for you?'"]
    
    var currentMission: Mission!
    var currentRoom: Room!
    var currentActionCategory: String!
    
    var infoTextCounter = 1
    var actionService: ActionService = MissionOneActionService()
    let actionServiceDictionaries = ActionServiceDictionaries()
    
    var actionSheetCounter = 0
    var actions: [[String]] = []
    
    var didReturnFromPrevButton: Bool = false
    
    let appleIIcolor = UIColor(red: 84/255, green: 194/255, blue: 113/255, alpha: 1)
    
    var timer: Timer!
    
    var isBlinking: Bool = false
    
    var actionViewMask: UIView!
    
    var missionLog: [String] = []
    
    var player: Player!
    var items: [String] = []
    
    var actionsRemaining: Int = 40
    var missionAccomplished: Bool = false
    
    //Placeholders for puzzles - can be used in a number of ways depending on the mission
    var numberOne: Int = 0
    var numberTwo: Int = 0
    var numberThree: Int = 0
    var numberFour: Int = 0
    
    var switchOne: Bool = false
    var switchTwo: Bool = false
    var switchThree: Bool = false
    var switchFour: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
//MARK: Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set INFO VIEW and ACTION VIEW border color and border width
        //let greenBorderColor = UIColor(red: 0.0, green: 80.0, blue: 0.0, alpha: 1)
        self.infoTextView.layer.borderWidth = 0.5
        self.actionListView.layer.borderWidth = 0.5
        self.infoTextView.layer.borderColor = self.appleIIcolor.cgColor
        self.actionListView.layer.borderColor = self.appleIIcolor.cgColor
        
        //Add glow effect to INFO TEXT VIEW border
        //GlowEffect.addToViewBorder(view: self.infoTextView, color: self.appleIIcolor.cgColor)
        
        //Add glow effect to ACTION LIST VIEW border
        //GlowEffect.addToViewBorder(view: self.actionListView, color: self.appleIIcolor.cgColor)
        
        //Set INFO VIEW LABEL text color and set glow effect
        GlowEffect.addToLabel(label: self.infoTextLabel)
        
        //Add glow effect to ROOM Name Label
        GlowEffect.addToLabel(label: self.roomNameLabel)
        
        //Add glow effect to Blinking Indicator
        GlowEffect.addToLabel(label: self.blinkingIndicatorLabel)
        
        //Add glow effect to room underline label
        //GlowEffect.addToLabel(label: self.roomUnderlineLabel)
        
        //Assign current mission and current array
        self.currentRoom = self.currentMission.initialRoom
        self.roomNameLabel.text = self.currentRoom.name
        self.currentArray = self.currentMission.initialRoom.description
        self.infoTextLabel.text = self.currentArray[0]
        self.missionLog.append(self.currentArray[0])
        
        //Set up and add tap gesture to INFO TEXT VIEW to see next label
        let infoViewTap = UITapGestureRecognizer(target: self, action: #selector(handleInfoTextTap))
        self.infoTextView.addGestureRecognizer(infoViewTap)
        
        //Setup timer for blinking indicator
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(toggleBlinkingIndicator), userInfo: nil, repeats: true)
        
        loadActionButtons()
        
        let actionViewMaskFrame = CGRect(x: 0, y: 0, width: self.actionListView.bounds.width, height: self.actionListView.bounds.height)
        self.actionViewMask = UIView(frame: actionViewMaskFrame)
        //self.actionViewMask.bounds = self.actionListView.bounds
        self.actionViewMask.backgroundColor = UIColor.black
        self.actionViewMask.alpha = 0.8
        
        self.actionListView.addSubview(self.actionViewMask)
        self.placeLogButton(self.infoTextView)
        
        self.player.items.append(player.gadget)
        self.player.items.append(player.statusEffectItem)
        self.player.items.append(player.disguise)
        
        self.actionsRemainingLabel.text = "Actions Remaining: \(self.actionsRemaining)"
        GlowEffect.addToLabel(label: self.actionsRemainingLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
//MARK: Gesture recognizer functions
    
    //Info text gesture
    func handleInfoTextTap() {
        
        updateCurrentString()
        
    }
    
    //Observe gesture recognizer
    func actionSelected(_ sender: UIButton) {
        
        guard let actionText = sender.currentTitle else {
            print("There is no action button text")
            return
        }
        
        let actionToLog = self.currentActionCategory + actionText
        self.missionLog.append(actionToLog)
        
        var functionToCall: (ViewController) -> [String]!
        
        for key in self.actionService.functions.keys {
            if key == actionText {
                functionToCall = self.actionService.functions[key]!
                let newArray = functionToCall(self)
                self.currentArray = newArray!
                self.infoTextLabel.text = self.currentArray[0]
                FontColorService.determineFontColor(inputString: self.infoTextLabel)
                self.missionLog.append(self.infoTextLabel.text!)
            }
        }
        
        if let viewWithTag = self.view.viewWithTag(99) {
            viewWithTag.removeFromSuperview()
            self.actionSheetCounter = 0
            self.infoTextCounter = 1
            self.actionsRemaining -= 1
            
            if self.actionsRemaining == 0 && self.missionAccomplished == false {
                self.displayEndGameView()
                return
            }
            
            self.actions = []
            self.updateActionsRemainingLabel()
            self.toggleActionViewMask()
            
        }
        print(self.actionsRemaining)
    }

//MARK: Helper functions
    
    //Updates info text view with next statement
    func updateCurrentString() {
        self.isBlinking = false
        
        if self.infoTextCounter == self.currentArray.count {
            print("Do Nothing")
        } else {
            self.infoTextLabel.text = self.currentArray[self.infoTextCounter]
            FontColorService.determineFontColor(inputString: self.infoTextLabel)
            self.missionLog.append(self.infoTextLabel.text!)
            self.infoTextCounter += 1
            self.toggleActionViewMask()
        }
        
    }
    
    func toggleBlinkingIndicator() {
        if self.infoTextCounter == self.currentArray.count {
            self.blinkingIndicatorLabel.alpha = 0
        } else {
            if self.isBlinking == false {
                self.blinkingIndicatorLabel.alpha = 1
                self.isBlinking = true
            } else {
                self.blinkingIndicatorLabel.alpha = 0
                self.isBlinking = false
            }
        }
    }
    
    func toggleActionViewMask() {
        if self.currentArray.count == self.infoTextCounter {
            self.actionViewMask.removeFromSuperview()
            //GlowEffect.addToViewBorder(view: self.actionListView, color: self.appleIIcolor.cgColor)
        } else {
            self.actionListView.addSubview(self.actionViewMask)
            self.actionListView.layer.shadowOpacity = 0.0
        }
    }
    
    func logButtonPressed() {
        
        self.actionsRemaining -= 1
        
        if actionsRemaining == 0 && self.missionAccomplished == false {
            self.displayEndGameView()
            return
        }
        
        self.updateActionsRemainingLabel()
        print(self.actionsRemaining)
        
        let backgroundView = UIView(frame: view.frame)
        backgroundView.tag = 100
        backgroundView.backgroundColor = UIColor.black
        let tableviewWidth = backgroundView.frame.width
        let tableviewHeight = self.view.frame.height * 0.9
        let tableViewFrame = CGRect(x: 0, y: 8, width: tableviewWidth, height: tableviewHeight)
        self.tableView = UITableView(frame: tableViewFrame)
        self.tableView.backgroundColor = UIColor.black
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(self.tableView)
        
        //Add CLOSE buttong
        let closeButton = UIButton(type: .custom)
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        closeButton.setTitle("CLOSE", for: .normal)
        closeButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        closeButton.setTitleColor(self.appleIIcolor, for: .normal)
        closeButton.sizeToFit()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(closeButton)
        
        GlowEffect.addToButton(button: closeButton)
        
        let closeButtonVerticalConstraint = NSLayoutConstraint(item: closeButton, attribute: .centerY, relatedBy: .equal, toItem: backgroundView, attribute: .centerY, multiplier: 1.9, constant: 0)
        let closeButtonHorizontalConstraint = NSLayoutConstraint(item: closeButton, attribute: .centerX, relatedBy: .equal, toItem: backgroundView, attribute: .centerX, multiplier: 1, constant: 0)
        
        backgroundView.addConstraint(closeButtonVerticalConstraint)
        backgroundView.addConstraint(closeButtonHorizontalConstraint)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.reloadData()
        
    }
    
//MARK: View setup functions
    func loadActionButtons() {
        
        //CREATE AND PLACE OBSERVE BUTTON IN SUPER VIEW
        let observeButton: UIButton = UIButton(type: .custom)
        observeButton.addTarget(self, action: #selector(observeButtonPressed), for: .touchUpInside)
        observeButton.setTitle("OBSERVE", for: UIControlState())
        observeButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        observeButton.setTitleColor(self.appleIIcolor, for: UIControlState())
        observeButton.sizeToFit()
        observeButton.translatesAutoresizingMaskIntoConstraints = false
        self.actionListView.addSubview(observeButton)
        
        //Add glow effect to button text
        GlowEffect.addToButton(button: observeButton)
        
        let observeButtonVerticalConstraint = NSLayoutConstraint(item: observeButton, attribute: .centerY, relatedBy: .equal, toItem: self.actionListView, attribute: .centerY, multiplier: 0.5, constant: 0)
        let observeButtonHorizontalConstraint = NSLayoutConstraint(item: observeButton, attribute: .centerX, relatedBy: .equal, toItem: self.actionListView, attribute: .centerX, multiplier: 0.5, constant: 0)
       
        self.actionListView.addConstraint(observeButtonVerticalConstraint)
        self.actionListView.addConstraint(observeButtonHorizontalConstraint)
        
        //CREATE AND PLACE TALK BUTTON IN SUPER VIEW
        let talkButton: UIButton = UIButton(type: .custom)
        talkButton.addTarget(self, action: #selector(talkButtonPressed), for: .touchUpInside)
        talkButton.setTitle("TALK", for: UIControlState())
        talkButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        talkButton.setTitleColor(self.appleIIcolor, for: UIControlState())
        talkButton.sizeToFit()
        talkButton.translatesAutoresizingMaskIntoConstraints = false
        self.actionListView.addSubview(talkButton)
        
        //Add glow effect to button text
        GlowEffect.addToButton(button: talkButton)
        
        let talkButtonVerticalConstraint = NSLayoutConstraint(item: talkButton, attribute: .centerY, relatedBy: .equal, toItem: self.actionListView, attribute: .centerY, multiplier: 1.0, constant: 0)
        let talkButtonHorizontalConstraint = NSLayoutConstraint(item: talkButton, attribute: .centerX, relatedBy: .equal, toItem: self.actionListView, attribute: .centerX, multiplier: 0.5, constant: 0)
        
        self.actionListView.addConstraint(talkButtonVerticalConstraint)
        self.actionListView.addConstraint(talkButtonHorizontalConstraint)
        
        //CREATE AND PLACE MOVE BUTTON IN SUPER VIEW
        let moveButton: UIButton = UIButton(type: .custom)
        moveButton.addTarget(self, action: #selector(moveButtonPressed), for: .touchUpInside)
        moveButton.setTitle("MOVE", for: UIControlState())
        moveButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        moveButton.setTitleColor(self.appleIIcolor, for: UIControlState())
        moveButton.sizeToFit()
        moveButton.translatesAutoresizingMaskIntoConstraints = false
        self.actionListView.addSubview(moveButton)
        
        //Add glow effect to button text
        GlowEffect.addToButton(button: moveButton)
        
        let moveButtonVerticalConstraint = NSLayoutConstraint(item: moveButton, attribute: .centerY, relatedBy: .equal, toItem: self.actionListView, attribute: .centerY, multiplier: 1.5, constant: 0)
        let moveButtonHorizontalConstraint = NSLayoutConstraint(item: moveButton, attribute: .centerX, relatedBy: .equal, toItem: self.actionListView, attribute: .centerX, multiplier: 0.5, constant: 0)
        
        self.actionListView.addConstraint(moveButtonVerticalConstraint)
        self.actionListView.addConstraint(moveButtonHorizontalConstraint)
        
        //CREATE AND PLACE INTERACT BUTTON IN SUPER VIEW
        let interactButton: UIButton = UIButton(type: .custom)
        interactButton.addTarget(self, action: #selector(interactButtonPressed), for: .touchUpInside)
        interactButton.setTitle("INTERACT", for: UIControlState())
        interactButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        interactButton.setTitleColor(self.appleIIcolor, for: UIControlState())
        interactButton.sizeToFit()
        interactButton.translatesAutoresizingMaskIntoConstraints = false
        self.actionListView.addSubview(interactButton)
        
        //Add glow effect to button text
        GlowEffect.addToButton(button: interactButton)
        
        let interactButtonVerticalConstraint = NSLayoutConstraint(item: interactButton, attribute: .centerY, relatedBy: .equal, toItem: self.actionListView, attribute: .centerY, multiplier: 0.5, constant: 0)
        let interactButtonHorizontalConstraint = NSLayoutConstraint(item: interactButton, attribute: .centerX, relatedBy: .equal, toItem: self.actionListView, attribute: .centerX, multiplier: 1.5, constant: 0)
        
        self.actionListView.addConstraint(interactButtonVerticalConstraint)
        self.actionListView.addConstraint(interactButtonHorizontalConstraint)
        
        //CREATE AND PLACE ATTACK BUTTON IN SUPER VIEW
        let attackButton: UIButton = UIButton(type: .custom)
        attackButton.addTarget(self, action: #selector(attackButtonPressed), for: .touchUpInside)
        attackButton.setTitle("ATTACK", for: UIControlState())
        attackButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        attackButton.setTitleColor(self.appleIIcolor, for: UIControlState())
        attackButton.sizeToFit()
        attackButton.translatesAutoresizingMaskIntoConstraints = false
        self.actionListView.addSubview(attackButton)
        
        //Add glow effect to button text
        GlowEffect.addToButton(button: attackButton)
        
        let attackButtonVerticalConstraint = NSLayoutConstraint(item: attackButton, attribute: .centerY, relatedBy: .equal, toItem: self.actionListView, attribute: .centerY, multiplier: 1.0, constant: 0)
        let attackButtonHorizontalConstraint = NSLayoutConstraint(item: attackButton, attribute: .centerX, relatedBy: .equal, toItem: self.actionListView, attribute: .centerX, multiplier: 1.5, constant: 0)
        
        self.actionListView.addConstraint(attackButtonVerticalConstraint)
        self.actionListView.addConstraint(attackButtonHorizontalConstraint)
        
        //CREATE AND PLACE ITEM BUTTON IN SUPER VIEW
        let itemButton: UIButton = UIButton(type: .custom)
        itemButton.addTarget(self, action: #selector(itemButtonPressed), for: .touchUpInside)
        itemButton.setTitle("ITEM", for: UIControlState())
        itemButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        itemButton.setTitleColor(self.appleIIcolor, for: UIControlState())
        itemButton.sizeToFit()
        itemButton.translatesAutoresizingMaskIntoConstraints = false
        self.actionListView.addSubview(itemButton)
        
        //Add glow effect to button text
        GlowEffect.addToButton(button: itemButton)
        
        let itemButtonVerticalConstraint = NSLayoutConstraint(item: itemButton, attribute: .centerY, relatedBy: .equal, toItem: self.actionListView, attribute: .centerY, multiplier: 1.5, constant: 0)
        let itemButtonHorizontalConstraint = NSLayoutConstraint(item: itemButton, attribute: .centerX, relatedBy: .equal, toItem: self.actionListView, attribute: .centerX, multiplier: 1.5, constant: 0)
        
        self.actionListView.addConstraint(itemButtonVerticalConstraint)
        self.actionListView.addConstraint(itemButtonHorizontalConstraint)
        
    }
    
//MARK: ACTION functions
    
    func observeButtonPressed() {
        self.currentActionCategory = "OBSERVED: "
        
        let subview = setupActionView(self.actionListView)
        subview.tag = 99
        
        let items = self.currentRoom.observeItems
        self.placeActionButtons(items, actionView: subview)
        
    }
    
    func talkButtonPressed() {
        self.currentActionCategory = "TALKED: "
        
        let subview = setupActionView(self.actionListView)
        subview.tag = 99
        
        let talkOptions = self.currentRoom.talkOptions
        self.placeActionButtons(talkOptions, actionView: subview)
    }
    
    func moveButtonPressed() {
        self.currentActionCategory = "MOVED: "
        
        let subview = setupActionView(self.actionListView)
        subview.tag = 99
        
        let moveOptions = self.currentRoom.roomExits
        self.placeActionButtons(moveOptions, actionView: subview)
    }
    
    func interactButtonPressed() {
        self.currentActionCategory = "INTERACTED: "
        
        let subview = setupActionView(self.actionListView)
        subview.tag = 99
        
        let interactOptions = self.currentRoom.interactItems
        self.placeActionButtons(interactOptions, actionView: subview)
    }
    
    func attackButtonPressed() {
        self.currentActionCategory = "ATTACKED: "
        
        let subview = setupActionView(self.actionListView)
        subview.tag = 99

        let attackOptions = self.currentRoom.attackOptions
        self.placeActionButtons(attackOptions, actionView: subview)
    }
    
    func itemButtonPressed() {
        self.currentActionCategory = "USED ITEM: "
        
        let subview = setupActionView(self.actionListView)
        subview.tag = 99
        
        self.placeActionButtons(self.player.items, actionView: subview)
    }
    
    //Set up subview for when action button is pressed
    func setupActionView(_ superView: UIView) -> UIView {
        
        let rectWidth = superView.frame.width * 0.9
        let rectHeight = superView.frame.height * 0.9
        let actionViewRect = CGRect(x: 0, y: 0, width: rectWidth, height: rectHeight)
        let center = CGPoint(x: superView.bounds.midX, y: superView.bounds.midY)
        let actionSubview = UIView(frame: actionViewRect)
        //let darkGreenBackgroundColor = UIColor(red: 1.0/255.0, green: 15.0/255.0, blue: 15.0/255.0, alpha: 1)
        //let greenBorderColor = UIColor(red: 0.0, green: 80.0, blue: 0.0, alpha: 1)
        actionSubview.layer.borderWidth = 0.5
        actionSubview.layer.borderColor = self.appleIIcolor.cgColor
        superView.addSubview(actionSubview)
        actionSubview.backgroundColor = UIColor.black
        actionSubview.center = center
        
        //GlowEffect.addToViewBorder(view: actionSubview, color: self.appleIIcolor.cgColor)
        
        //Create and place CANCEL button
        let cancelButton = UIButton(type: .custom)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.setTitle("CANCEL", for: UIControlState())
        cancelButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        cancelButton.setTitleColor(self.appleIIcolor, for: UIControlState())
        cancelButton.setTitleColor(UIColor.gray, for: .highlighted)
        cancelButton.sizeToFit()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        actionSubview.addSubview(cancelButton)
        
        GlowEffect.addToButton(button: cancelButton)
        
        let cancelButtonVerticalConstraint = NSLayoutConstraint(item: cancelButton, attribute: .centerY, relatedBy: .equal, toItem: actionSubview, attribute: .centerY, multiplier: 1.8, constant: 0)
        let cancelButtonHorizontalConstraint = NSLayoutConstraint(item: cancelButton, attribute: .centerX, relatedBy: .equal, toItem: actionSubview, attribute: .centerX, multiplier: 1, constant: 0)
        
        actionSubview.addConstraint(cancelButtonVerticalConstraint)
        actionSubview.addConstraint(cancelButtonHorizontalConstraint)
        
        return actionSubview
    }
    
    //Dismiss ACTION view when CANCEL button is pressed
    func cancelButtonPressed() {
        
        if let viewWithTag = self.view.viewWithTag(99) {
            viewWithTag.removeFromSuperview()
            self.actionSheetCounter = 0
            self.actions = []
            self.didReturnFromPrevButton = false
        }
    }
    
    func nextButtonPressed() {
        //Show the next view in the array
        
        self.actionSheetCounter += 1
        
        if let viewWithTag = self.view.viewWithTag(99) {
            viewWithTag.removeFromSuperview()
        }
        
        let subview = self.setupActionView(self.actionListView)
        subview.tag = 99
        
        self.placeActionButtons(self.actions[self.actionSheetCounter], actionView: subview)
        self.placeNextButton(subview, actions: self.actions)
        
    }
    
    func prevButtonPressed() {
        
        self.actionSheetCounter -= 1
        
        if self.actionSheetCounter == 0 {
            self.didReturnFromPrevButton = true
        } else {
            self.didReturnFromPrevButton = false
        }
        
        if let viewWithTag = self.view.viewWithTag(99) {
            viewWithTag.removeFromSuperview()
        }
        
        let subview = self.setupActionView(self.actionListView)
        subview.tag = 99
        
        self.placeActionButtons(self.actions[self.actionSheetCounter], actionView: subview)
        self.placeNextButton(subview, actions: self.actions)
    }
    
    func closeButtonPressed() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    //Place action buttons
    func placeActionButtons(_ options: [String], actionView: UIView) {
        
        var anchorButton: UIButton!
        var optionArrays = self.setupActionOptions(options)
        
        if self.actionSheetCounter == 0 && self.didReturnFromPrevButton == false {
            self.actions = optionArrays
        }
        
        for (index, option) in optionArrays[0].enumerated() {
            
            if index == 0 {
                
                let firstOptionButton = UIButton(type: .custom)
                firstOptionButton.addTarget(self, action: #selector(self.actionSelected), for: .touchUpInside)
                firstOptionButton.setTitle(option, for: UIControlState())
                firstOptionButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
                firstOptionButton.setTitleColor(self.appleIIcolor, for: UIControlState())
                firstOptionButton.setTitleColor(UIColor.gray, for: .highlighted)
                firstOptionButton.titleLabel?.textAlignment = .center
                firstOptionButton.sizeToFit()
                firstOptionButton.titleLabel?.numberOfLines = 0
                firstOptionButton.translatesAutoresizingMaskIntoConstraints = false
                
                actionView.addSubview(firstOptionButton)
                
                GlowEffect.addToButton(button: firstOptionButton)
                
                let firstOptionButtonVerticalConstraint = NSLayoutConstraint(item: firstOptionButton, attribute: .centerY, relatedBy: .equal, toItem: actionView, attribute: .centerY, multiplier: 0.3, constant: 0)
                let firstOptionButtonLeftConstraint = NSLayoutConstraint(item: firstOptionButton, attribute: .left, relatedBy: .equal, toItem: actionView, attribute: .left, multiplier: 1, constant: -8)
                let firstOptionButtonRightConstraint = NSLayoutConstraint(item: firstOptionButton, attribute: .right, relatedBy: .equal, toItem: actionView, attribute: .right, multiplier: 1, constant: 8)
                
                actionView.addConstraint(firstOptionButtonVerticalConstraint)
                actionView.addConstraint(firstOptionButtonLeftConstraint)
                actionView.addConstraint(firstOptionButtonRightConstraint)
                
                anchorButton = firstOptionButton
                
            } else {
                
                let optionButton = UIButton(type: .custom)
                optionButton.addTarget(self, action: #selector(self.actionSelected), for: .touchUpInside)
                optionButton.setTitle(options[index], for: UIControlState())
                optionButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
                optionButton.setTitleColor(self.appleIIcolor, for: UIControlState())
                optionButton.setTitleColor(UIColor.gray, for: .highlighted)
                optionButton.titleLabel?.textAlignment = .center
                optionButton.sizeToFit()
                optionButton.titleLabel?.numberOfLines = 0
                optionButton.translatesAutoresizingMaskIntoConstraints = false
                
                actionView.addSubview(optionButton)
                
                GlowEffect.addToButton(button: optionButton)
                
                let optionButtonVerticalConstraint = NSLayoutConstraint(item: optionButton, attribute: .top, relatedBy: .equal, toItem: anchorButton, attribute: .bottom, multiplier: 1, constant: 24)
                let optionButtonLeftConstraint = NSLayoutConstraint(item: optionButton, attribute: .left, relatedBy: .equal, toItem: actionView, attribute: .left, multiplier: 1, constant: -8)
                let optionButtonRightConstraint = NSLayoutConstraint(item: optionButton, attribute: .right, relatedBy: .equal, toItem: actionView, attribute: .right, multiplier: 1, constant: 8)
                
                actionView.addConstraint(optionButtonVerticalConstraint)
                actionView.addConstraint(optionButtonLeftConstraint)
                actionView.addConstraint(optionButtonRightConstraint)
                
                anchorButton = optionButton
            }
        }
        
        if optionArrays.count > 1 {
            
            let nextButton = UIButton(type: .custom)
            nextButton.addTarget(self, action: #selector(self.nextButtonPressed), for: .touchUpInside)
            nextButton.setTitle("NEXT", for: UIControlState())
            nextButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
            nextButton.setTitleColor(self.appleIIcolor, for: UIControlState())
            nextButton.setTitleColor(UIColor.gray, for: .highlighted)
            nextButton.sizeToFit()
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            
            actionView.addSubview(nextButton)
            
            GlowEffect.addToButton(button: nextButton)
            
            let nextButtonVerticalConstraint = NSLayoutConstraint(item: nextButton, attribute: .centerY, relatedBy: .equal, toItem: actionView, attribute: .centerY, multiplier: 1.8, constant: 0)
            let nextButtonHorizontalConstraint = NSLayoutConstraint(item: nextButton, attribute: .centerX, relatedBy: .equal, toItem: actionView, attribute: .centerX, multiplier: 1.75, constant: 0)
            
            actionView.addConstraint(nextButtonVerticalConstraint)
            actionView.addConstraint(nextButtonHorizontalConstraint)

        }
        
        if self.actionSheetCounter > 0 {
            
            let prevButton = UIButton(type: .custom)
            prevButton.addTarget(self, action: #selector(self.prevButtonPressed), for: .touchUpInside)
            prevButton.setTitle("PREV", for: UIControlState())
            prevButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
            prevButton.setTitleColor(self.appleIIcolor, for: UIControlState())
            prevButton.setTitleColor(UIColor.gray, for: .highlighted)
            prevButton.sizeToFit()
            prevButton.translatesAutoresizingMaskIntoConstraints = false
            
            actionView.addSubview(prevButton)
            
            GlowEffect.addToButton(button: prevButton)
            
            let prevButtonVerticalConstraint = NSLayoutConstraint(item: prevButton, attribute: .centerY, relatedBy: .equal, toItem: actionView, attribute: .centerY, multiplier: 1.8, constant: 0)
            let prevButtonHorizontalConstraint = NSLayoutConstraint(item: prevButton, attribute: .centerX, relatedBy: .equal, toItem: actionView, attribute: .centerX, multiplier: 0.25, constant: 0)
            
            actionView.addConstraint(prevButtonVerticalConstraint)
            actionView.addConstraint(prevButtonHorizontalConstraint)
        }
    }
    
    //Returns an array of 3 string arrays to be us
    func setupActionOptions(_ options: [String]) -> [[String]] {
        
        var array: [[String]] = []
        var actionOptions = options
        
        while actionOptions.count > 3 {
            
            let firstThreeElements: [String] = Array(actionOptions[0...2])
            array.append(firstThreeElements)
            actionOptions.removeSubrange(0...2)
            
        }
        
        let finalArray = actionOptions
        array.append(finalArray)
        
        return array
    }
    
    //Place "NEXT" button in action option view
    func placeNextButton(_ superview: UIView, actions: [[String]]) {
        
        
        if (actions.count - self.actionSheetCounter) > 1 {
        
            let nextButton = UIButton(type: .custom)
            nextButton.addTarget(self, action: #selector(self.nextButtonPressed), for: .touchUpInside)
            nextButton.setTitle("NEXT", for: .normal)
            nextButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
            nextButton.setTitleColor(self.appleIIcolor, for: UIControlState())
            nextButton.setTitleColor(UIColor.gray, for: .highlighted)
            nextButton.sizeToFit()
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            
            superview.addSubview(nextButton)
            
            GlowEffect.addToButton(button: nextButton)
            
            let nextButtonVerticalConstraint = NSLayoutConstraint(item: nextButton, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1.8, constant: 0)
            let nextButtonHorizontalConstraint = NSLayoutConstraint(item: nextButton, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1.75, constant: 0)
            
            superview.addConstraint(nextButtonVerticalConstraint)
            superview.addConstraint(nextButtonHorizontalConstraint)
        }
        
    }
    
    //Place "LOG" button in info text view
    
    func placeLogButton(_ superview: UIView) {
        let logButton = UIButton(type: .custom)
        logButton.addTarget(self, action: #selector(logButtonPressed), for: .touchUpInside)
        logButton.setTitle("LOG", for: .normal)
        logButton.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        logButton.setTitleColor(self.appleIIcolor, for: .normal)
        logButton.setTitleColor(UIColor.gray, for: .highlighted)
        logButton.sizeToFit()
        logButton.translatesAutoresizingMaskIntoConstraints = false
        
        superview.addSubview(logButton)
        
        GlowEffect.addToButton(button: logButton)
        
        let logButtonVerticalConstraint = NSLayoutConstraint(item: logButton, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1.8, constant: 0)
        let logButtonHorizontalConstraint = NSLayoutConstraint(item: logButton, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1.75, constant: 0)
        
        superview.addConstraint(logButtonVerticalConstraint)
        superview.addConstraint(logButtonHorizontalConstraint)
    }
    
    //Update the ACTIONS REMAINING label
    func updateActionsRemainingLabel() {
        self.actionsRemainingLabel.text = "Actions Remaining: \(self.actionsRemaining)"
    }
    
    func displayEndGameView() {
        
        let backgroundView = UIView(frame: view.frame)
        backgroundView.backgroundColor = UIColor.black
        
        let gameOverLabel = UILabel()
        gameOverLabel.text = "Game Over"
        gameOverLabel.font = UIFont(name: Constants.regularAppleFont, size: 15.0)
        gameOverLabel.sizeToFit()
        gameOverLabel.textColor = UIColor.red
        gameOverLabel.translatesAutoresizingMaskIntoConstraints = false
        
        GlowEffect.addToLabel(label: gameOverLabel)
        
        backgroundView.addSubview(gameOverLabel)
        
        let labelXConstraint = NSLayoutConstraint(item: gameOverLabel, attribute: .centerX, relatedBy: .equal, toItem: backgroundView, attribute: .centerX, multiplier: 1, constant: 0)
        let labelYConstraint = NSLayoutConstraint(item: gameOverLabel, attribute: .centerY, relatedBy: .equal, toItem: backgroundView, attribute: .centerY, multiplier: 1, constant: 0)
        
        backgroundView.addConstraint(labelXConstraint)
        backgroundView.addConstraint(labelYConstraint)
        
        self.view.addSubview(backgroundView)
    
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.missionLog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        cell.textLabel?.text = self.missionLog[indexPath.row]
        cell.backgroundColor = UIColor.black
        //cell.textLabel?.textColor = self.appleIIcolor
        FontColorService.determineFontColor(inputString: cell.textLabel!)
        
        return cell
    }
    
}

