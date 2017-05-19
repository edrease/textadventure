 //
//  MissionStartViewController.swift
//  TEXTADV
//
//  Created by Edrease Peshtaz on 9/30/16.
//  Copyright © 2016 mysterio group. All rights reserved.
//

import UIKit

class MissionStartViewController: UIViewController {
    
    let appleIIFontColor = UIColor(red: 84/255, green: 194/255, blue: 113/255, alpha: 1)
    var missionSplashScreen: UIView!
    var missionBriefingScreen: UIView!
    var missionIntelView: UIView!
    var chooseGadgetView: UIView!
    var chooseWeaponView: UIView!
    var chooseMedicineView: UIView!
    var chooseDisguiseView: UIView!
    var confirmAndStartView: UIView!
    
    var equipmentDescriptionLabel: UILabel!
    var gadgetDescriptionLabel: UILabel?
    var weaponDescriptionLabel: UILabel?
    var medicineDescriptionLabel: UILabel?
    var disguiseDescriptionLabel: UILabel?
    
    // Gadget buttons
    var gadgetButtonOne = UIButton()
    var gadgetButtonTwo = UIButton()
    var gadgetButtonThree = UIButton()
    
    // Weapon buttons
    var weaponButtonOne = UIButton()
    var weaponButtonTwo = UIButton()
    var weaponButtonThree = UIButton()
    
    // Medicine buttons
    var medicineButtonOne = UIButton()
    var medicineButtonTwo = UIButton()
    var medicineButtonThree = UIButton()
    
    // Disguise buttons 
    var disguiseButtonOne = UIButton()
    var disguiseButtonTwo = UIButton()
    var disguiseButtonThree = UIButton()
    
    // Button groups
    var gadgetButtons: [UIButton] = []
    var weaponButtons: [UIButton] = []
    var medicineButtons: [UIButton] = []
    var disguiseButtons: [UIButton] = []
    
    var views: [UIView] = []
    var viewCounter = 1
    
    var mission: Mission!
    var player = Player(items: [], weapon: "", gadget: "", statusEffectItem: "", disguise: "", status: "Good")
    
    //var nextButtonBeenPlaced: Bool = false
    
    //Switches for next button placement on equipment selection
    var gadgetViewNextButtonPlaced: Bool = false
    var weaponViewNextButtonPlaced: Bool = false
    var medicineViewNextButtonPlaced: Bool = false
    var disguiseViewNextButtonPlaced: Bool = false
    
    // Confirm view labels
    var confirmViewGadgetLabel = UILabel()
    var confirmViewWeaponLabel = UILabel()
    var confirmViewMedicineLabel = UILabel()
    var confirmViewDisguiseLabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.mission = MissionCreator.createDemoMission()
        
        // Add gadget buttons to array
        self.gadgetButtons.append(self.gadgetButtonOne)
        self.gadgetButtons.append(self.gadgetButtonTwo)
        self.gadgetButtons.append(self.gadgetButtonThree)
        
        // Add weapon buttons to array
        self.weaponButtons.append(self.weaponButtonOne)
        self.weaponButtons.append(self.weaponButtonTwo)
        self.weaponButtons.append(self.weaponButtonThree)
        
        // Add medicine buttons to array
        self.medicineButtons.append(self.medicineButtonOne)
        self.medicineButtons.append(self.medicineButtonTwo)
        self.medicineButtons.append(self.medicineButtonThree)
        
        // Add disguise buttons to array 
        self.disguiseButtons.append(self.disguiseButtonOne)
        self.disguiseButtons.append(self.disguiseButtonTwo)
        self.disguiseButtons.append(self.disguiseButtonThree)
        
        //Initiate views
        self.missionSplashScreen = self.createMissionSplashScreen()
        self.missionBriefingScreen = self.createMissionBriefView()
        self.missionIntelView = self.createMissionIntelView()
        self.chooseGadgetView = self.createEquipmentSelectionView(selectionType: "GADGET")
        self.chooseWeaponView = self.createEquipmentSelectionView(selectionType: "WEAPON")
        self.chooseMedicineView = self.createEquipmentSelectionView(selectionType: "MEDICINE")
        self.chooseDisguiseView = self.createEquipmentSelectionView(selectionType: "DISGUISE")
        self.confirmAndStartView = self.createConfirmView()
        
        //Add views to array
        self.views.append(self.missionSplashScreen)
        self.views.append(self.missionBriefingScreen)
        self.views.append(self.missionIntelView)
        self.views.append(self.chooseGadgetView)
        self.views.append(self.chooseWeaponView)
        self.views.append(self.chooseMedicineView)
        self.views.append(self.chooseDisguiseView)
        self.views.append(self.confirmAndStartView)
        
        //Test view
        self.view.addSubview(self.views[1])
    }
    
//MARK: View Creation Functions
    
    //Create and return mission splash screen
    func createMissionSplashScreen() -> UIView {
        let missionSplashScreen = UIView(frame: self.view.frame)
        missionSplashScreen.backgroundColor = UIColor.black
        
        let missionLabel = UILabel()
        missionLabel.text = "Mission 0"
        missionLabel.textColor = self.appleIIFontColor
        missionLabel.sizeToFit()
        GlowEffect.addToLabel(label: missionLabel)
        let center = self.view.center
        missionLabel.center = center
        missionSplashScreen.addSubview(missionLabel)
        
        return missionSplashScreen
    }
    
    //Create and return mission objective screen
    func createMissionBriefView() -> UIView {
        
        //Create main view
        let missionBriefView = UIView(frame: self.view.frame)
        missionBriefView.backgroundColor = UIColor.black
        
        //Create and add headline label
        let mainHeadlineLabel = UILabel()
        self.setupLabel(label: mainHeadlineLabel, labelText: "Mission 0 Briefing", superview: missionBriefView, yMultiplier: 0.2, xMultiplier: 1)
        
        //Create and add subtitle
        let subtitleLabel = UILabel()
        self.setupLabel(label: subtitleLabel, labelText: "Objective: ", superview: missionBriefView, yMultiplier: 0.4, xMultiplier: 1)
        
        //Create and add detailed objective label
        let missionObjectiveLabel = UILabel()
        missionObjectiveLabel.text = self.mission.briefing["objective"]
        missionObjectiveLabel.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        missionObjectiveLabel.textColor = self.appleIIFontColor
        missionObjectiveLabel.sizeToFit()
        missionObjectiveLabel.numberOfLines = 0
        missionObjectiveLabel.translatesAutoresizingMaskIntoConstraints = false
        GlowEffect.addToLabel(label: missionObjectiveLabel)
        
        missionBriefView.addSubview(missionObjectiveLabel)
        
        let missionObjectiveVerticalConstraint = NSLayoutConstraint(item: missionObjectiveLabel, attribute: .centerY, relatedBy: .equal, toItem: missionBriefView, attribute: .centerY, multiplier: 0.8, constant: 0)
        let missionObjectiveLeftConstraint = NSLayoutConstraint(item: missionObjectiveLabel, attribute: .left, relatedBy: .equal, toItem: missionBriefView, attribute: .left, multiplier: 1, constant: 8.0)
        let missionObjectiveRightConstraint = NSLayoutConstraint(item: missionObjectiveLabel, attribute: .right, relatedBy: .equal, toItem: missionBriefView, attribute: .right, multiplier: 1, constant: -8.0)
        
        missionBriefView.addConstraint(missionObjectiveVerticalConstraint)
        missionBriefView.addConstraint(missionObjectiveLeftConstraint)
        missionBriefView.addConstraint(missionObjectiveRightConstraint)
        
        //Create and add NEXT button
        let nextButton = UIButton(type: .custom)
        self.setupButton(button: nextButton, superview: missionBriefView, buttonText: "NEXT", yMultiplier: 1.8, xMultiplier: 1.8)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        
        return missionBriefView
    }
    
    //Create and return mission INTEL screen
    func createMissionIntelView() -> UIView {
        
        //Create main view
        let missionIntelView = UIView(frame: self.view.frame)
        missionIntelView.backgroundColor = UIColor.black
        
        //Create and add headline label
        let mainHeadlineLabel = UILabel()
        self.setupLabel(label: mainHeadlineLabel, labelText: "Mission 0 Briefing", superview: missionIntelView, yMultiplier: 0.2, xMultiplier: 1)
        
        //Create and add subtitle
        let subtitleLabel = UILabel()
        self.setupLabel(label: subtitleLabel, labelText: "Intel: ", superview: missionIntelView, yMultiplier: 0.4, xMultiplier: 1)
        
        //Create and add detailed objective label
        let missionIntelLabel = UILabel()
        self.setupLongLabel(label: missionIntelLabel, labelText: self.mission.briefing["intel"]!, superview: missionIntelView, yMultiplier: 0.8)
        
        //Create and add NEXT button
        let nextButton = UIButton(type: .custom)
        self.setupButton(button: nextButton, superview: missionIntelView, buttonText: "NEXT", yMultiplier: 1.8, xMultiplier: 1.8)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        
        let prevButton = UIButton(type: .custom)
        self.setupButton(button: prevButton, superview: missionIntelView, buttonText: "PREV", yMultiplier: 1.8, xMultiplier: 0.2)
        prevButton.addTarget(self, action: #selector(prevButtonPressed), for: .touchUpInside)
        
        return missionIntelView
    }
    
    //Create equipment selection view
    func createEquipmentSelectionView(selectionType: String) -> UIView {
        
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = UIColor.black
        //var equipmentDescriptionLabel = UILabel()
        
        let topLabel = UILabel()
        self.setupLabel(label: topLabel, labelText: "Equipment Select", superview: view, yMultiplier: 0.2, xMultiplier: 1)
        
        let chooseGadgetLabel = UILabel()
        setupLongLabel(label: chooseGadgetLabel, labelText: "There is very limited space on your person to carry equipment. Select one \(selectionType) to take with you.", superview: view, yMultiplier: 0.4)
        
        //Setup equipment selection buttons
        var buttons: [UIButton]?
        switch selectionType {
        case "GADGET":
            buttons = self.gadgetButtons
            self.gadgetDescriptionLabel = UILabel()
            self.setupLongLabel(label: self.gadgetDescriptionLabel!, labelText: "", superview: view, yMultiplier: 1.3)
        case "WEAPON":
            buttons = self.weaponButtons
            self.weaponDescriptionLabel = UILabel()
            self.setupLongLabel(label: self.weaponDescriptionLabel!, labelText: "", superview: view, yMultiplier: 1.3)
        case "MEDICINE":
            buttons = self.medicineButtons
            self.medicineDescriptionLabel = UILabel()
            self.setupLongLabel(label: self.medicineDescriptionLabel!, labelText: "", superview: view, yMultiplier: 1.3)
        case "DISGUISE":
            buttons = self.disguiseButtons
            self.disguiseDescriptionLabel = UILabel()
            self.setupLongLabel(label: self.disguiseDescriptionLabel!, labelText: "", superview: view, yMultiplier: 1.3)
        default:
            let button = UIButton()
            buttons = [button]
        }
        
        self.setupEquipmentSelectButtons(superview: view, topLabel: chooseGadgetLabel, buttons: buttons!, equipmentType: selectionType)
        
        let prevButton = UIButton(type: .custom)
        self.setupButton(button: prevButton, superview: view, buttonText: "PREV", yMultiplier: 1.8, xMultiplier: 0.2)
        prevButton.addTarget(self, action: #selector(prevButtonPressed), for: .touchUpInside)
        
        //Add equipment description
        //self.equipmentDescriptionLabel = UILabel()
        //self.setupLongLabel(label: equipmentDescriptionLabel, labelText: "", superview: view, yMultiplier: 1.3)
        
        return view
    }
    
    // Create confirm and start mission screen
    func createConfirmView() -> UIView {
        let view = UIView(frame: self.view.frame)
        let topLabel = UILabel()
        let topLabelText = "Confirm equipment and begin mission."
        self.setupLongLabel(label: topLabel, labelText: topLabelText, superview: view, yMultiplier: 0.2)
        
        self.setupLongLabel(label: self.confirmViewGadgetLabel, labelText: "", superview: view, yMultiplier: 0.4)
        self.setupLongLabel(label: self.confirmViewWeaponLabel, labelText: "", superview: view, yMultiplier: 0.5)
        self.setupLongLabel(label: self.confirmViewMedicineLabel, labelText: "", superview: view, yMultiplier: 0.6)
        self.setupLongLabel(label: self.confirmViewDisguiseLabel, labelText: "", superview: view, yMultiplier: 0.7)
        
        let prevButton = UIButton(type: .custom)
        self.setupButton(button: prevButton, superview: view, buttonText: "PREV", yMultiplier: 1.8, xMultiplier: 0.2)
        prevButton.addTarget(self, action: #selector(prevButtonPressed), for: .touchUpInside)
        
        let deployButton = UIButton(type: .custom)
        self.setupButton(button: deployButton, superview: view, buttonText: "BEGIN", yMultiplier: 1.8, xMultiplier: 1.8)
        deployButton.addTarget(self, action: #selector(deployButtonPressed), for: .touchUpInside)
        
        return view
    }
    
//MARK: Helper functions
    
    //Configures label
    func setupLabel(label: UILabel, labelText: String, superview: UIView, yMultiplier: CGFloat, xMultiplier: CGFloat) {
        
        label.text = labelText
        label.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        label.textColor = self.appleIIFontColor
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        GlowEffect.addToLabel(label: label)
        
        superview.addSubview(label)
        
        let labelVerticalConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: yMultiplier, constant: 0)
        let labelHorizontalConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: xMultiplier, constant: 0)
        
        superview.addConstraint(labelVerticalConstraint)
        superview.addConstraint(labelHorizontalConstraint)
    }
    
    //Configures label that has more than one line of text
    func setupLongLabel(label: UILabel, labelText: String, superview: UIView, yMultiplier: CGFloat) {
        
        label.text = labelText
        label.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        label.textColor = self.appleIIFontColor
        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        GlowEffect.addToLabel(label: label)
        
        superview.addSubview(label)
        
        let labelVerticalConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: yMultiplier, constant: 0)
        let labelLeftConstraint = NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .left, multiplier: 1, constant: 8.0)
        let labelRightConstraint = NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .right, multiplier: 1, constant: -8.0)
        
        superview.addConstraint(labelVerticalConstraint)
        superview.addConstraint(labelLeftConstraint)
        superview.addConstraint(labelRightConstraint)
    }
    
    //Create and place PREV button
    func setupButton(button: UIButton, superview: UIView, buttonText: String, yMultiplier: CGFloat, xMultiplier: CGFloat) {
        
        button.setTitle(buttonText, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        button.setTitleColor(self.appleIIFontColor, for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        GlowEffect.addToButton(button: button)
        
        superview.addSubview(button)
        
        let buttonVerticalConstraint = NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: yMultiplier, constant: 0)
        let buttonHorizontalConstraint = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: xMultiplier, constant: 0)
        
        superview.addConstraint(buttonVerticalConstraint)
        superview.addConstraint(buttonHorizontalConstraint)
    }
    
    func deployButtonPressed() {
        
        performSegue(withIdentifier: "ToActionViewController", sender: self)
    }
    
    //Setup for equipment option button
    func setupEquipmentOptionButton(button: UIButton, superview: UIView, buttonText: String, topView: UIView, topConstraint: CGFloat, xMultiplier: CGFloat) {
        
        button.setTitle(buttonText, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.regularAppleFont, size: 12.0)
        button.setTitleColor(self.appleIIFontColor, for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        GlowEffect.addToButton(button: button)
        
        superview.addSubview(button)
        
        let topConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1, constant: topConstraint)
        let buttonHorizontalConstraint = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: xMultiplier, constant: 0)
        
        superview.addConstraint(topConstraint)
        superview.addConstraint(buttonHorizontalConstraint)
    }
    
    //Places an array of buttons beneath the label
    func setupEquipmentSelectButtons(superview: UIView, topLabel: UILabel, buttons: [UIButton], equipmentType: String) {
        
        var anchorView: UIView!
        var buttonTag = 101
        var equipmentTextOptions: [String] = []
        
        switch equipmentType {
        case "GADGET":
            //buttonTag = 101
            equipmentTextOptions = self.mission.gadgetOptions
        case "WEAPON":
            //buttonTag = 201
            equipmentTextOptions = self.mission.weaponOptions
        case "MEDICINE":
            //buttonTag = 301
            equipmentTextOptions = self.mission.statusItemOptions
        case "DISGUISE":
            //buttonTag = 401
            equipmentTextOptions = self.mission.disguiseOptions
        default:
            //buttonTag = 501
            equipmentTextOptions = ["", "", ""]
        }
        
        for (index, button) in buttons.enumerated() {
            if index == 0 {
                self.setupEquipmentOptionButton(button: button, superview: superview, buttonText: equipmentTextOptions[0], topView: topLabel, topConstraint: 72, xMultiplier: 1)
                button.tag = buttonTag
                buttonTag += 1
                button.addTarget(self, action: #selector(equipmentButtonPressed(sender:)), for: .touchUpInside)
                anchorView = button
            } else {
                self.setupEquipmentOptionButton(button: button, superview: superview, buttonText: equipmentTextOptions[index], topView: anchorView, topConstraint: 8, xMultiplier: 1)
                button.tag = buttonTag
                buttonTag += 1
                button.addTarget(self, action: #selector(equipmentButtonPressed(sender:)), for: .touchUpInside)
                anchorView = button
            }
        }
    }
    
    //Executes actions when NEXT button is pressed
    func nextButtonPressed() {
        //Increase counter
        //Add the next view to stack
        self.viewCounter += 1
        self.view = (self.views[self.viewCounter])
        print(self.viewCounter)
    }
    
    //Executes actions when PREV button is pressed
    func prevButtonPressed() {
        self.viewCounter -= 1
        self.view = views[self.viewCounter]
        print(self.viewCounter)
    }
    
    func equipmentButtonPressed(sender: UIButton) {
        
        if let firstViewWithTag: UIButton = self.view.viewWithTag(101) as! UIButton? {
            firstViewWithTag.setTitleColor(self.appleIIFontColor, for: .normal)
            GlowEffect.addToButton(button: firstViewWithTag)
            firstViewWithTag.backgroundColor = UIColor.black
            GlowEffect.addToView(view: firstViewWithTag)
        }
        
        if let secondViewWithTag: UIButton = self.view.viewWithTag(102) as! UIButton? {
            secondViewWithTag.setTitleColor(self.appleIIFontColor, for: .normal)
            GlowEffect.addToButton(button: secondViewWithTag)
            secondViewWithTag.backgroundColor = UIColor.black
            GlowEffect.addToView(view: secondViewWithTag)
        }
        
        if let thirdViewWithTag: UIButton = self.view.viewWithTag(103) as! UIButton? {
            thirdViewWithTag.setTitleColor(self.appleIIFontColor, for: .normal)
            GlowEffect.addToButton(button: thirdViewWithTag)
            thirdViewWithTag.backgroundColor = UIColor.black
            GlowEffect.addToView(view: thirdViewWithTag)
        }
        
        sender.backgroundColor = self.appleIIFontColor
        sender.setTitleColor(UIColor.black, for: .normal)
        GlowEffect.addToView(view: sender)
        self.changeLabelDescription(buttonPressed: sender)
        
        var currentViewNextButtonPlaced: Bool = false
        
        switch self.viewCounter {
        case 3:
            currentViewNextButtonPlaced = self.gadgetViewNextButtonPlaced
            self.player.gadget = sender.titleLabel!.text!
        case 4:
            currentViewNextButtonPlaced = self.weaponViewNextButtonPlaced
            self.player.weapon = sender.titleLabel!.text!
        case 5:
            currentViewNextButtonPlaced = self.medicineViewNextButtonPlaced
            self.player.statusEffectItem = sender.titleLabel!.text!
        case 6:
            currentViewNextButtonPlaced = self.disguiseViewNextButtonPlaced
            self.player.disguise = sender.titleLabel!.text!
            
            self.confirmViewGadgetLabel.text = "GADGET: \(self.player.gadget)"
            self.confirmViewWeaponLabel.text = "WEAPON: \(self.player.weapon)"
            self.confirmViewMedicineLabel.text = "MEDICINE: \(self.player.statusEffectItem)"
            self.confirmViewDisguiseLabel.text = "DISGUISE: \(self.player.disguise)"
            
        default:
            currentViewNextButtonPlaced = false
        }
        
        if currentViewNextButtonPlaced == false {
            let nextButton = UIButton()
            nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
            self.setupButton(button: nextButton, superview: self.view, buttonText: "NEXT", yMultiplier: 1.8, xMultiplier: 1.8)
            
            switch self.viewCounter {
            case 3:
                self.gadgetViewNextButtonPlaced = true
            case 4:
                self.weaponViewNextButtonPlaced = true
            case 5:
                self.medicineViewNextButtonPlaced = true
            case 6:
                self.disguiseViewNextButtonPlaced = true
            default:
                currentViewNextButtonPlaced = false
            }
        }
    }
    
    func changeLabelDescription(buttonPressed: UIButton) {
        //self.equipmentDescriptionLabel.text = buttonPressed.titleLabel?.text
        
        let equipmentDictionary = EquipmentDictionary()
        var label: UILabel?
        
        switch self.viewCounter {
        case 3:
            // Set label to gadget selection screen
            label = self.gadgetDescriptionLabel
            
        case 4:
            // Set label to weapon selection screen
            label = self.weaponDescriptionLabel
            
        case 5:
            // Set label to medicine selection screen
            label = self.medicineDescriptionLabel
            
        case 6:
            // Set label to disguise selection screen
            label = self.disguiseDescriptionLabel
            
        case 7:
            print("SCEEN SEVEN")
        default:
            let defaultLabel = UILabel()
            label = defaultLabel
        }
        
        
        for key in equipmentDictionary.equipment.keys {
            if key == buttonPressed.titleLabel?.text {
                label!.text = equipmentDictionary.equipment[key]
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToActionViewController" {
            if let vc = segue.destination as? ViewController {
                vc.currentMission = self.mission
                vc.player = self.player
            }
        }
    }
    
}
