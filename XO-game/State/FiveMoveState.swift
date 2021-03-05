//
//  FiveMoveState.swift
//  XO-game
//
//  Created by Дима Давыдов on 05.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class FiveMoveState: GameState {
    var isMoveCompleted: Bool = false
    
    public let player: Player
    private weak var gameViewController: GameViewController?
    private weak var gameBoard: Gameboard?
    private weak var gameBoardView: GameboardView?
    private weak var invoker: PlayerMoveInvoker?
    
    public let markViewPrototype: MarkView
    
    let totalMoveCount = 5
    var movesDone = 0
    
    init(player: Player, gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView, invoker: PlayerMoveInvoker) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.markViewPrototype = markViewPrototype
        self.invoker = invoker
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        
        gameViewController?.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {
        
        guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position) else {
            return
        }
        
        guard let gameBoard = gameBoard else { return }
        
        Log(action: .playerSetMark(player: player, position: position))
        
        let command = PlayerMoveCommand(player, view: gameBoardView, gameboard: gameBoard, position: position)
        invoker?.add(command)
        
        gameBoard.setPlayer(player, at: position)
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)

        movesDone += 1
        
        if movesDone < totalMoveCount { return }
        
        isMoveCompleted = true
        
    }
}
