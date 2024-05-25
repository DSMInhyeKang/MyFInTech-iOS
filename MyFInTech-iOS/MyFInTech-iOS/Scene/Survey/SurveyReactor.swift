//
//  SurveyReactor.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/19/24.
//

import ReactorKit
import RxSwift

final class SurveyReactor: Reactor {
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    enum Action {
        case isAnswerYes
        case isAnswerNo
    }
    
    enum Mutation {
        case setAnswer(Bool)
    }
    
    struct State {
        var answer = false
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .isAnswerYes:
            return Observable.just(.setAnswer(true))
        case .isAnswerNo:
            return Observable.just(.setAnswer(false))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setAnswer(let answer):
            newState.answer = answer
        }
        
        return newState
    }
}
