//
//  PlayerMoveInvoker.swift
//  XO-game
//
//  Created by Дима Давыдов on 05.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class PlayerMoveInvoker {
    private var commands: [PlayerMoveCommand] = []
    
    func add(_ command: PlayerMoveCommand) {
        commands.append(command)
    }
    
    func execute() {
        commands.map { (command) in
            command.execute()
        }
    }
    
    func executeFiveMoves() {
        for i in 0..<5 {
            self.commands[i].execute()
            self.commands[i+5].execute()
        }
        
        commands = []
    }
}
