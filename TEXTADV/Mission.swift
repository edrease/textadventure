//
//  Mission.swift
//  TEXTADV
//
//  Created by Edrease Peshtaz on 8/19/16.
//  Copyright © 2016 mysterio group. All rights reserved.
//

import Foundation

class Mission {
    
    var missionName: String
    var briefing: [String : String]
    var initialRoom: Room
    var rooms: [String : Room]
    var disguiseOptions: [String]
    var weaponOptions: [String]
    var gadgetOptions: [String]
    var statusItemOptions: [String]
    
    init(missionName: String, briefing: [String : String], initialRoom: Room, rooms: [String : Room], disguiseOptions: [String], weaponOptions: [String], gadgetOptions: [String], statusItemOptions: [String]) {
        
        self.missionName = missionName
        self.briefing = briefing
        self.initialRoom = initialRoom
        self.rooms = rooms
        self.disguiseOptions = disguiseOptions
        self.weaponOptions = weaponOptions
        self.gadgetOptions = gadgetOptions
        self.statusItemOptions = statusItemOptions
    }
    
}
//instantiate mission
