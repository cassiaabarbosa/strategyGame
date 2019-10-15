//
//  StateMachine.swift
//  strategyGame
//
//  Created by Edgar Sgroi on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
enum State {
    case idle
    case attacking
    case searching
    case dead
}

class StateMachine {
    
    func changeState(state: State) -> State {
        switch state {
        case .idle:
            print("idle")
            return .idle
        case .attacking:
            print("attacking")
            return . attacking
        case .searching:
            print("searching")
            return .searching
        case .dead:
            print("dead")
            return .dead
        }
    }
}
