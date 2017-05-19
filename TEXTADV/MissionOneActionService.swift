//
//  ActionService.swift
//  TEXTADV
//
//  Created by Edrease Peshtaz on 8/28/16.
//  Copyright © 2016 mysterio group. All rights reserved.
//

import Foundation

class MissionOneActionService: ActionService {
    
//MARK: Mission One - A Train Car Named Live-Wire
    
    //MOVE
    static func moveCabinCar(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kControlCabin]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    static func moveEngineCar(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kEngineCar]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    static func moveBaggageCar(_ vc: ViewController) -> [String] {
        
        if vc.currentMission.rooms[MissionOneConstants.kBaggageCar]?.isLocked == true {
            return ["The door to the baggage car is locked, I need to find a way in."]
        } else {
            vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kBaggageCar]
            vc.roomNameLabel.text = vc.currentRoom.name
            return vc.currentRoom.description
        }
    }
    
    static func moveCoachCar1(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kCoachCar1]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    static func moveCoachCar2(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kCoachCar2]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    static func moveFromPlatformCoachCar2(_ vc: ViewController) -> [String] {
        let player = vc.player
        if player?.checkForItem(item: "boarding pass") == true {
            vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kCoachCar2]
            vc.roomNameLabel.text = vc.currentRoom.name
            return vc.currentRoom.description
        } else {
            return ["Sir, you cannot board without a boarding pass.", "Please buy a ticket with the ticket seller."]
        }
    }
    
    static func moveCoachCar3(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kCoachCar3]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    static func moveDiningCar(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kDiningCar]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    static func moveBarCar(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kBarCar]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    static func moveSleepingCar1(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kSleepingCar1]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    static func moveSleepingCar2(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kSleepingCar2]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    static func moveObservationCar(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kObservationCar]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    static func moveCoachCarBathroom(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kCoachCarBathroom]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    static func moveDiningCarBathroom(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kDiningCarBathroom]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    static func moveSleepingCarBathroom(_ vc: ViewController) -> [String] {
        vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kSleepingCarBathroom]
        vc.roomNameLabel.text = vc.currentRoom.name
        return vc.currentRoom.description
    }
    
    //OBSERVE
    
    static func observeTrainCars(_ vc: ViewController) -> [String] {
        return ["The number of cars is very small, this shouldn't take me long.", "HQ: Don't get complacent, we don't know what we're dealing with", "True.", "The train cars themselves are closely connected with flat metal roofs.", "It would be suicide to try and walk on the roof like in the movies while it was moving.", "HQ: But if you had the right tools..."]
    }
    
    static func observeOldLadyLuggage(_ vc: ViewController) -> [String] {
        return ["The old woman has a bag that is zipped all the way open.", "Is it impolite to look in?", "What threat is she?", "But I'm so curious!", "It's right there for me to look at!"]
        //Add option to interact with bag
    }
    
    static func observeBeautifulWoman(_ vc: ViewController) -> [String] {
        return ["This woman waiting for the train is stunning...", "HQ: You are not there to ogle women! Focus on the mission!", "I'm trying!"]
    }
    
    //TALK 
    
    static func talkTicketSeller(_ vc: ViewController) -> [String] {
        let player = vc.player
        if player?.checkForItem(item: "boarding pass") == false {
            vc.player.items.append("boarding pass")
            return ["Buying a ticket now.", "The ticket seller looks half asleep.", "I've received my boarding pass."]
        } else {
            return ["I was unenthusiastically reminded that I already bought a boarding pass."]
        }
    }
    
    static func talkDog(_ vc: ViewController) -> [String] {
        return ["The dog barked at me.", "It seemed like a friendly bark, but there is no way to tell.", "If I had some food maybe we could be friends."]
    }
    
    static func talkYoungMan(_ vc: ViewController) -> [String] {
        return ["The man warned me not to try talking to that attractive woman.", "Apparently she's colder than winter in Edinburgh."]
    }
    
    static func talkPorter(_ vc: ViewController) -> [String] {
        
        let player = vc.player
        if player?.checkForItem(item: "boarding pass") == false {
            return ["Sir, please purchase a boarding pass from the ticket seller.", "Yes, just right over there, behind you.", "He's available in the TALK menu like me."]
        } else {
            return ["Ah, I see you have your boarding pass, sir!", "Use the MOVE command to board whenever you are ready."]
        }
    }
    
    //ATTACK
    
    static func attackPoliceMan(_ vc: ViewController) -> [String] {
        vc.displayEndGameView()
        return ["You shouldn't have done that..."]
    }
    
    //ITEMS
    
    static func useThermalGoggles(_ vc: ViewController) -> [String] {
        
        switch vc.currentRoom.name {
        case "Platform":
            return ["Thermal glasses are discretely on.", "Nothing out of the usual, the engine car seems to be the second car from the front, given the heat signature.", "And of course this gorgeous woman is burning brightly, heh."]
        case "Control Cabin":
            return ["I've raised my thermal sunglasses to my eyes, but see no heat signatures."]
        case "Engine Car":
            return ["The engine is obviously very hot."]
        case "Baggage Car":
            return ["There is not really anything in this room giving off heat."]
        case "Coach Car 1":
            return ["Everyone seems to be in the normal temperature range.", "There is a small child, however, that seems to have a slightly high temperature."]
        case "Coach Car 2":
            return ["Everyone and everything seems like they are at a normal temperature."]
        case "Coach Car 3":
            return ["Everyone seems to be at normal temperature.", "They don't seem to be running a fever or have anything to hide.", "HQ: Just because someone is not giving off a high heat signature doesn't mean they don't have something to hide.", "HQ: Stay vigilant."]
        case "Dining Car":
            return ["There seem to be nothing at of the usual besides a small amount of heat coming from the food burners and kitchen appliances."]
        case "Bar Car":
            return ["The beautiful woman is sitting in this car! And of course her heat signature is still high.", "HQ: I'm starting to think that her temperature is a little suspicious.", "HQ: Try and OBSERVE her and your surroundings more closely."]
        case "Sleeping Car 1":
            return ["Judging by the heat temperatures, I can see that people are sleeping or relaxing in these sleeping cars.", "HQ: It still might be worth it to investigate who is in those compartments!"]
        case "Sleeping Car 2":
            return ["There is a very high heat signature coming from behind door number two.", "It looks much higher than usual."]
        case "Observation Car":
            return ["There is too much moving by too fast.", "Nothing useful to see here."]

        default:
            return ["There's been a mistake using thermal glasses."]
        }
    }
    
    static func useWristWatch(_ vc: ViewController) -> [String] {
        
        switch vc.currentRoom.name {
        case "Platform":
            return ["HQ: Why are you using that there? There's no doors to unlock."]
        case "Control Cabin":
            return [""]
        case "Engine Car":
            return [""]
        case "Baggage Car":
            return [""]
        case "Coach Car 1":
            if vc.currentMission.rooms[MissionOneConstants.kBaggageCar]?.isLocked == true {
                vc.currentMission.rooms[MissionOneConstants.kBaggageCar]?.isLocked = false
                return ["The door was locked, but I've unlocked it using my wrist watch lock pick gadget."]
            } else {
                return ["I've already gained access to the baggage car, no need to use this gadget."]
            }
        case "Coach Car 2":
            return [""]
        case "Coach Car 3":
            return [""]
        case "Dining Car":
            return [""]
        case "Bar Car":
            return [""]
        case "Sleeping Car 1":
            return [""]
        case "Sleeping Car 2":
            return [""]
        case "Observation Car":
            return [""]
        default:
            return ["There was a mistake using wrist watch lock pick."]
        }
    }
    
    static func useMagnetBoot(_ vc: ViewController) -> [String] {
        
        switch vc.currentRoom.name {
        case "Platform":
            return ["I've turned on my magnet boots.", "There's nowhere useful to use them on the train platform, so I have turned them back off."]
        case "Control Cabin":
            return ["HQ: What are you trying to do, walk on the ceiling?", "HQ: Turn those off!"]
        case "Engine Car":
            return ["There's nothing to walk on in here.", "HQ: You're wasting your ACTIONS! Think before you act!"]
        case "Baggage Car":
            return ["I've turned my boots on by the baggage and managed to attract some bags near me.", "It wasn't very useful."]
        case "Coach Car 1":
            return ["My magnet boots are on now, but there's nothing useful to cling to here.", "I've turned them back off."]
        case "Coach Car 2":
            return ["Flipped on the magnet boots." , "There's nothing here to use them on.", "HQ: Quit wasting precious time, every action counts!"]
        case "Coach Car 3":
            return ["There's nothing in here to use my magnet boots on.", "I've turned them on for nothing!", "HQ: Please... turn them off."]
        case "Dining Car":
            return ["I turned on my magnet boots in the dining car.", "There's nothing metal to attract besides spoons and forks.", "I want people to eat in peace, so I turned them back off."]
        case "Bar Car":
            return ["I turned on my boots in the bar car.", "Nothing useful happened."]
        case "Sleeping Car 1":
            return ["I don't want the hum of my boots to wake people up, so I turned them back off."]
        case "Sleeping Car 2":
            return ["I don't want the hum of my boots to wake people up, so I turned them back off."]
        case "Observation Car":
            vc.currentRoom = vc.currentMission.rooms[MissionOneConstants.kEngineCar]
            vc.roomNameLabel.text = vc.currentRoom.name
            return ["I've turned the magnet boots on, clibmed the roof, and dropped down into the engine room."]
        default:
            return ["There was a mistake using magnet boots."]
        }
    }
    
    
    var missionFunctions: [String : (ViewController) -> [String]] = [
        
                                    //MOVE
                                                              MissionOneConstants.kMoveBoardTrain : MissionOneActionService.moveFromPlatformCoachCar2,
                                                              MissionOneConstants.kMoveControlCabin : MissionOneActionService.moveCabinCar,
                                                              MissionOneConstants.kMoveEngineCar : MissionOneActionService.moveEngineCar,
                                                              MissionOneConstants.kMoveBaggageCar : MissionOneActionService.moveBaggageCar,
                                                              MissionOneConstants.kMoveCoachCar1 : MissionOneActionService.moveCoachCar1,
                                                              MissionOneConstants.kMoveCoachCar2 : MissionOneActionService.moveCoachCar2,
                                                              MissionOneConstants.kMoveCoachCar3 : MissionOneActionService.moveCoachCar3,
                                                              MissionOneConstants.kMoveDiningCar : MissionOneActionService.moveDiningCar,
                                                              MissionOneConstants.kMoveBarCar : MissionOneActionService.moveBarCar,
                                                              MissionOneConstants.kMoveSleepingCar1 : MissionOneActionService.moveSleepingCar1,
                                                              MissionOneConstants.kMoveSleepingCar2 : MissionOneActionService.moveSleepingCar2,
                                                              MissionOneConstants.kMoveObservationCar : MissionOneActionService.moveObservationCar,
                                                              MissionOneConstants.kMoveCoachCarBathroom : MissionOneActionService.moveCoachCarBathroom,
                                                              MissionOneConstants.kMoveDiningCarBathroom : MissionOneActionService.moveDiningCarBathroom,
                                                              MissionOneConstants.kMoveSleepingCarBathroom : MissionOneActionService.moveSleepingCarBathroom,
                                                              
                                    //OBSERVE 
                                                              MissionOneConstants.kObserveTrainCars : MissionOneActionService.observeTrainCars,
                                                              MissionOneConstants.kObserveOldLadyLuggage : MissionOneActionService.observeOldLadyLuggage,
                                                              MissionOneConstants.kObserveBeautifulWoman : MissionOneActionService.observeBeautifulWoman,
                                    //TALK
                                                              MissionOneConstants.kTalkTicketSeller : MissionOneActionService.talkTicketSeller,
                                                              MissionOneConstants.kTalkDog : MissionOneActionService.talkDog,
                                                              MissionOneConstants.kTalkYoungMan : MissionOneActionService.talkYoungMan,
                                                              MissionOneConstants.kTalkPorter : MissionOneActionService.talkPorter,
                                    //ATTACK
                                                              MissionOneConstants.kAttackPoliceMan : MissionOneActionService.attackPoliceMan,
                                    //ITEMS
                                                              "thermal sunglass" : MissionOneActionService.useThermalGoggles,
                                                              "magnet boot" : MissionOneActionService.useMagnetBoot,
                                                              "wristwatch lockpick" : MissionOneActionService.useWristWatch]
    
    override init() {
        super.init()
        self.functions = missionFunctions
    }
}
