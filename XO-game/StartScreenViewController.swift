//
//  StartScreenViewController.swift
//  XO-game
//
//  Created by Дима Давыдов on 28.02.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation
import UIKit

class StartScreenViewController: UIViewController {
    //MARK: - IBActions
    
    @IBAction func startGameWithHuman(_ sender: UIButton) {
        startGame(withHuman: true)
    }
    @IBAction func startGameWithComputer(_ sender: UIButton) {
        startGame(withHuman: false)
    }
    
    private func startGame(withHuman: Bool) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(identifier: "GameViewController") as? GameViewController else { return }
        
        vc.playingWithHuman = withHuman
        
        show(vc, sender: self)
    }
}
