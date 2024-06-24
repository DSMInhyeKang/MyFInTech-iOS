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
    let types = BehaviorRelay<[[String]]>(value: [
        ["예금", "목돈 굴리기 상품"], ["적금", "목돈 만들기 상품"], ["CMA", "은행/증권사 CMA"],
        ["ISA", "ISA Top 20"], ["금", "금 통장/ETF/펀드"], ["외환", "외환 투자"],
        ["주식/ETF", "주식/ETF 서비스"], ["암호화폐", "암호화폐"], ["MMF", "MMF Top 20"],
        ["랩(Wrap)", "시중은행 랩 어카운트"], ["배당주/공모주", "배당주/공모주"], ["연금/보험", "연금/보험"]
    ])
    
    struct Input {
    }
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
