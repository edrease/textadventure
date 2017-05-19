//
//  MissionCreator.swift
//  TEXTADV
//
//  Created by Edrease Peshtaz on 8/19/16.
//  Copyright © 2016 mysterio group. All rights reserved.
//

import Foundation

class MissionCreator {
    
    class func createMissionOne() -> Mission {
        
        let platform: Room = Room(name: "Platform", description: ["On the boarding platform now.", "No sign of the mark yet."],
                                  roomExits: [MissionOneConstants.kMoveBoardTrain],
                                  observeItems: [MissionOneConstants.kObserveTrainCars, MissionOneConstants.kObserveOldLadyLuggage, MissionOneConstants.kObserveBeautifulWoman],
                                  interactItems: [MissionOneConstants.kInteractTrashCan],
                                  talkOptions: [MissionOneConstants.kTalkDog, MissionOneConstants.kTalkPorter, MissionOneConstants.kTalkYoungMan, MissionOneConstants.kTalkTicketSeller],
                                  attackOptions: [MissionOneConstants.kAttackPoliceMan])
        
        let controlCabin: Room = Room(name: "Control Cabin",
                                      description: ["The conducter is standing in front of his equipment panel, looking stoically forward."],
                                      roomExits: [MissionOneConstants.kMoveEngineCar],
                                      observeItems: [""],
                                      interactItems: [""],
                                      talkOptions: [""],
                                      attackOptions: [""])
        
        
        let engineCar: Room = Room(name: "Engine Car",
                                   description: ["There is a large, loud engine that takes up nearly the whole car."],
                                   roomExits: [MissionOneConstants.kMoveControlCabin, MissionOneConstants.kMoveBaggageCar],
                                   observeItems: [""],
                                   interactItems: [""],
                                   talkOptions: [""],
                                   attackOptions: [""])
        
        let baggageCar: Room = Room(name: "Baggage Car",
                                    description: ["All of the passangers luggages have been stored in this car."],
                                    roomExits: [MissionOneConstants.kMoveEngineCar, MissionOneConstants.kMoveCoachCar1],
                                    observeItems: [""],
                                    interactItems: [""],
                                    talkOptions: [""],
                                    attackOptions: [""])
        
        let coachCar1: Room = Room(name: "Coach Car 1",
                                   description: ["There are two sets of rows with chairs facing out."],
                                   roomExits: [MissionOneConstants.kMoveBaggageCar, MissionOneConstants.kMoveCoachCar2],
                                   observeItems: [""],
                                   interactItems: [""],
                                   talkOptions: [""],
                                   attackOptions: [""])
        
        let coachCar2: Room = Room(name: "Coach Car 2",
                                   description: ["There is an aisle separating two rows of booth style seating."],
                                   roomExits: [MissionOneConstants.kMoveCoachCar1, MissionOneConstants.kCoachCarBathroom, MissionOneConstants.kMoveCoachCar3],
                                   observeItems: [""],
                                   interactItems: [""],
                                   talkOptions: [""],
                                   attackOptions: [""])
        
        let coachCar3: Room = Room(name: "Coach Car 3",
                                   description: ["There are two rows of seats, all facing forward."],
                                   roomExits: [MissionOneConstants.kMoveCoachCar2, MissionOneConstants.kMoveDiningCar],
                                   observeItems: [""],
                                   interactItems: [""],
                                   talkOptions: [""],
                                   attackOptions: [""])
        
        let diningCar: Room = Room(name: "Dining Car",
                                   description: ["There are booths to eat on one side with food service on the other side of the car."],
                                   roomExits: [MissionOneConstants.kMoveCoachCar3, MissionOneConstants.kDiningCarBathroom, MissionOneConstants.kMoveBarCar],
                                   observeItems: [""],
                                   interactItems: [""],
                                   talkOptions: [""],
                                   attackOptions: [""])
        
        let barCar: Room = Room(name: "Bar Car",
                                description: ["There are people getting drunk."],
                                roomExits: [MissionOneConstants.kMoveDiningCar, MissionOneConstants.kMoveSleepingCar1],
                                observeItems: [""],
                                interactItems: [""],
                                talkOptions: [""],
                                attackOptions: [""])
        
        let sleepingCar1: Room = Room(name: "Sleeping Car 1",
                                      description: ["There are four sleeping compartments."],
                                      roomExits: [MissionOneConstants.kMoveBarCar, MissionOneConstants.kSleepingCarBathroom, MissionOneConstants.kMoveSleepingCar2],
                                      observeItems: [""],
                                      interactItems: [""],
                                      talkOptions: [""],
                                      attackOptions: [""])
        
        let sleepingCar2: Room = Room(name: "Sleeping Car 2",
                                      description: ["There are four sleeping cars.", "One seems to be slightly ajar..."],
                                      roomExits: [MissionOneConstants.kMoveSleepingCar1, MissionOneConstants.kMoveObservationCar],
                                      observeItems: [""],
                                      interactItems: [""],
                                      talkOptions: [""],
                                      attackOptions: [""])
        
        let observationCar: Room = Room(name: "Observation Car",
                                        description: ["The last car.", "You can sit here and watch the scenery go by."],
                                        roomExits: [MissionOneConstants.kMoveSleepingCar2],
                                        observeItems: [""],
                                        interactItems: [""],
                                        talkOptions: [""],
                                        attackOptions: [""])
        
        let coachCarBathroom: Room = Room(name: "Coach Car 2 Bathroom",
                                             description: ["This bathroom is very small.", "There is just a mirror, small sink, and toilet.", "Just enough room to change my disguise if I need to, though."],
                                             roomExits: [MissionOneConstants.kCoachCar2],
                                             observeItems: [""],
                                             interactItems: [""],
                                             talkOptions: [""],
                                             attackOptions: [""])
        
        let diningCarBathroom: Room = Room(name: "Dining Car Bathroom",
                                           description: ["This bathroom is very small.", "There is just a mirror, small sink, and toilet.", "Just enough room to change my disguise if I need to, though."],
                                           roomExits: [MissionOneConstants.kDiningCar],
                                           observeItems: [""],
                                           interactItems: [""],
                                           talkOptions: [""],
                                           attackOptions: [""])
        
        let sleepingCarBathroom: Room = Room(name: "Sleeping Car 1 Bathroom",
                                             description: ["This bathroom is very small.", "There is just a mirror, small sink, and toilet.", "Just enough room to change my disguise if I need to, though."],
                                             roomExits: [MissionOneConstants.kSleepingCar1],
                                             observeItems: [""],
                                             interactItems: [""],
                                             talkOptions: [""],
                                             attackOptions: [""])
        
        let missionRooms: [String : Room] = [MissionOneConstants.kPlatform : platform,
                                             MissionOneConstants.kControlCabin : controlCabin,
                                             MissionOneConstants.kEngineCar : engineCar,
                                             MissionOneConstants.kBaggageCar : baggageCar,
                                             MissionOneConstants.kCoachCar1 : coachCar1,
                                             MissionOneConstants.kCoachCar2 : coachCar2,
                                             MissionOneConstants.kCoachCar3 : coachCar3,
                                             MissionOneConstants.kDiningCar : diningCar,
                                             MissionOneConstants.kBarCar : barCar,
                                             MissionOneConstants.kSleepingCar1 : sleepingCar1,
                                             MissionOneConstants.kSleepingCar2 : sleepingCar2,
                                             MissionOneConstants.kObservationCar : observationCar,
                                             MissionOneConstants.kCoachCarBathroom : coachCarBathroom,
                                             MissionOneConstants.kDiningCarBathroom : diningCarBathroom,
                                             MissionOneConstants.kSleepingCarBathroom : sleepingCarBathroom]
        
       
        let missionOne: Mission = Mission(missionName: "Train Mission",
                                          briefing: ["objective" : MissionOneConstants.objective,
                                                     "intel" : MissionOneConstants.intel],
                                          initialRoom: platform,
                                          rooms: missionRooms,
                                          disguiseOptions: ["old man makeup", "blonde bombshell", "porter uniform"],
                                          weaponOptions: ["dagger", "pen w/ sleep dart", "heavy glove"],
                                          gadgetOptions: ["thermal sunglass", "wristwatch lockpick", "magnet boot"],
                                          statusItemOptions: ["sedative", "amphetamine", "psychedelic pill"])
        
        //LOCK DOORS
        missionOne.rooms[MissionOneConstants.kBaggageCar]?.isLocked = true
        
        return missionOne
    }

    
}
