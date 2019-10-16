//
//  StateMachine.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
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
            return .idle
        case .attacking:
            return .attacking
        case .searching:
            return .searching
        case .dead:
            return .dead
        }
    }
}
