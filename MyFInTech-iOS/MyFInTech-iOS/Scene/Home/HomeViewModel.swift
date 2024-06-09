//
//  HomeViewModel.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/9/24.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class HomeViewModel: BaseViewModel {
    var disposeBag = DisposeBag()
    let types = BehaviorRelay<[String]>(value: ["예금", "적금", "랩(WRAP)"])
    let details = BehaviorRelay<[String]>(value: ["예금 랭킹 Top 20", "적금 랭킹 Top 20", "시중은행 랩 Top 20"])
    
    struct Input {
        
    }
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
