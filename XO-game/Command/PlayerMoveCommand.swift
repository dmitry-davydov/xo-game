//
//  PlayerMoveInvoker.swift
//  XO-game
//
//  Created by Дима Давыдов on 03.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class PlayerMoveCommand {
    private var player: Player
    private weak var gameboardView: GameboardView?
    private weak var gameboard: Gameboard?
    private var position: GameboardPosition
    
    init(_ player: Player, view: GameboardView, gameboard: Gameboard, position: GameboardPosition) {
        self.player = player
        gameboardView = view
        self.gameboard = gameboard
        self.position = position
    }
    
    func execute() {
        gameboard?.setPlayer(player, at: position)
        gameboardView?.placeMarkView(player.markViewPrototype.copy(), at: position)
    }
}
