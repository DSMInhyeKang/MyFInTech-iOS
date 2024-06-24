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
        case isOver
    }
    
    enum Mutation {
        case setAnswer(Bool)
        case showResult
    }
    
    struct State {
        var answers: [Bool] = []
        var cnt = 0
        var type = ""
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .isAnswerYes:
            return Observable.just(.setAnswer(true))
        case .isAnswerNo:
            return Observable.just(.setAnswer(false))
        case .isOver:
            return Observable.just(.showResult)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setAnswer(let answer):
            newState.cnt += 1
            newState.answers.append(answer)
        case .showResult:
            newState.type = ""
        }
        
        return newState
    }
}
extension SurveyReactor {
}
