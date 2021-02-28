//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var playingWithHuman: Bool = true
    
    private let gameBoard = Gameboard()
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    private lazy var referee = Referee(gameboard: gameBoard)
    
    private var counter = 0
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
            self.currentState.addMark(at: position)
            if self.currentState.isMoveCompleted {
                
                self.counter += 1
                self.setNextState()
            }
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        
        Log(action: .restartGame)
        
        gameboardView.clear()
        gameBoard.clear()
        setFirstState()
    }
    
    private func setFirstState() {
        counter = 0
        
        currentState = buildPlayerState(player: Player.first)
    }
    
    private func setNextState() {
        
        if let winner = referee.determineWinner() {
            currentState = GameOverState(winner: winner, gameViewController: self)
            return
        }
        
        if counter >= 9 {
            currentState = GameOverState(winner: nil, gameViewController: self)
            return
        }
        
        if playingWithHuman, let playerInputState = currentState as? PlayerState {
            currentState = buildPlayerState(player: playerInputState.player.next)
            return
        }
        
        if let playerInputState = currentState as? ComputerState {
            currentState = buildPlayerState(player: playerInputState.player.next)
            return
        }
        
        
        if let playerInputState = currentState as? PlayerState {
            
            let player = playerInputState.player.next
            
            let state = ComputerState(player: player,
                                      gameViewController: self,
                                      gameBoard: gameBoard,
                                      gameBoardView: gameboardView,
                                      markViewPrototype: player.markViewPrototype
            )
            
            guard let nextMove = state.makeMove() else { return }
            
            currentState = state
            
            gameboardView.onSelectPosition!(nextMove)
        }
    }
    
    private func buildPlayerState(player: Player) -> PlayerState {
        return  PlayerState(player: player,
                            gameViewController: self,
                            gameBoard: gameBoard,
                            gameBoardView: gameboardView,
                            markViewPrototype: player.markViewPrototype
         )
    }
}
