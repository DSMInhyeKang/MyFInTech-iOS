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
        ["예금", "예금 랭킹 Top 20"], ["적금", "적금 랭킹 Top 20"], ["랩(WRAP)", "시중은행 랩 Top 20"],
        ["금", "금 통장/ETF/펀드"], ["외환", "외환 상품 Top 20"], ["ISA", "시중은행 ISA Top 20"],
        ["MMDA", "시중은행 MMDA Top 20"], ["보험", "종신 보험 Top 20"], ["연금", "연금 Top 20"],
        ["ELS/DLS", "시중은행 ELS/DLS Top 20"], ["배당주", "배당주 추천 Top 20"], ["공모주 청약", "공모주 청약 Top 20"]
    ])
    
    struct Input {
        
    }
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
