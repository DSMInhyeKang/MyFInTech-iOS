//
//  SurveyViewmodel.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/24/24.
//

import Foundation
import RxSwift
import RxCocoa

class SurveyViewModel: BaseViewModel {
    var disposeBag = DisposeBag()
    let surveyQuestions = [
        "어떤 투자 방식을 원하시나요?",
        "투자에 사용할 금액은 어느 정도인가요?",
        "투자에 소요할 기간은 어느 정도인가요?",
        "다음 중 원하는 자산 운용 방식을 선택해주세요."
    ]
    let surveyOptions = [
        ["수익률과 원금 손실 위험성이 낮은 재테크", "수익률과 원금 손실 위험성이 높은 재테크"],
        ["1천만원 미만", "1천만원 이상"],
        ["2년 이하", "3년 이상"],
        ["전문가가 대신 자산 운용", "직접 자산 운용"]
    ]
    
    struct Input {
        
    }
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    func investType(answers: [Bool]) -> String {
        switch answers {
        case [false, false, false, false]:
            return ""
        case [false, false, false, true]:
            return ""
        case [false, false, true, false]:
            return ""
        case [false, false, true, true]:
            return ""
        case [false, true, false, false]:
            return ""
        case [false, true, false, true]:
            return ""
        case [false, true, true, false]:
            return ""
        case [false, true, true, true]:
            return ""
        case [true, false, false, false]:
            return ""
        case [true, false, false, true]:
            return ""
        case [true, false, true, false]:
            return ""
        case [true, false, true, true]:
            return ""
        case [true, true, false, false]:
            return ""
        case [true, true, false, true]:
            return ""
        case [true, true, true, false]:
            return ""
        case [true, true, true, true]:
            return ""
        default:
            return "유형 도출에 실패했어요."
        }
    }
}
