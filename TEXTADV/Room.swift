//
//  Room.swift
//  TEXTADV
//
//  Created by Edrease Peshtaz on 8/15/16.
//  Copyright © 2016 mysterio group. All rights reserved.
//

import Foundation

struct Room {
    
    var name: String
    var description: [String]
    var roomExits: [String]
    var observeItems: [String]
    var interactItems: [String]
    var talkOptions: [String]
    var attackOptions: [String]
    var isLocked: Bool = false
    
    init(name: String, description: [String], roomExits: [String], observeItems: [String], interactItems: [String], talkOptions: [String], attackOptions: [String]) {
        
        self.name = name
        self.description = description
        self.roomExits = roomExits
        self.observeItems = observeItems
        self.interactItems = interactItems
        self.talkOptions = talkOptions
        self.attackOptions = attackOptions
        
    }
    
}

//    func moveToRoom(room: Room) {
//
//    }

//    var moveCount: Int = 0
//    var moveCountMax: Int = 5
