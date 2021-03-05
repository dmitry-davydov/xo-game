//
//  PlayOutState.swift
//  XO-game
//
//  Created by Дима Давыдов on 05.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class PlayoutState: GameState {
    var isMoveCompleted: Bool = false
    
    private weak var invoker: PlayerMoveInvoker?
    
    init(invoker: PlayerMoveInvoker) {
        self.invoker = invoker
    }
    
    func begin() {
//        switch player {
//        case .first:
//            gameViewController?.firstPlayerTurnLabel.isHidden = false
//            gameViewController?.secondPlayerTurnLabel.isHidden = true
//        case .second:
//            gameViewController?.firstPlayerTurnLabel.isHidden = true
//            gameViewController?.secondPlayerTurnLabel.isHidden = false
//        }
//
//        gameViewController?.winnerLabel.isHidden = true
//
        invoker?.executeFiveMoves()
        
    }
    
    func addMark(at position: GameboardPosition) {
        
    }
}
