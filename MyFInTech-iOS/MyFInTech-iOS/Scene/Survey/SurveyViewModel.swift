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
    var type = ""
    
    let aggressive: Set<String> = ["개별 주식", "배당주", "공모주", "주식형 ETF", "테마 ETF", "파생형 ETF(인버스,레버리지 등)", "ELW","ETN", "주식형 펀드", "섹터/테마형 펀드", "ELS", "DLS", "암호화폐", "ELW", "국내/해외 선물/옵션", "장외파생상품", "장내파생상품", "회사채(BB+이하)", "채권", "신탁"]
    let active: Set<String> = ["혼합형 펀드", "부동산 펀드", "ELS", "DLS", "REITs", "P2P 대출", "금(파생)", "외환", "회사채(BBB- ~ BBB+)", "신탁", "ISA"]
    let riskNeutral: Set<String> = ["혼합형 펀드", "ELS", "DLS" ,"회사채(A-~ A+)", "CP(A2- ~ A2+)", "채권", "신탁", "ISA", "변액보험", "혼합형 펀드", "ELB", "DLB"]
    let stability: Set<String> = ["국내 은행(AA+이하)예금", "저축은행 예금", "지역농협 예금", "외화 발행어음", "원화 발행어음", "발행어음형 CMA", "외화RP", "ELB", "DLB", "CP(A1)", "회사채(AA- ~ AAA)", "채권", "신탁", "랩 어카운트", "혼합형 펀드"]
    let stable: Set<String> = ["정기예금", "MMDA", "원화 RP", "RP형 CMA", "정기적금", "자유적금", "청년적금", "청년도약계좌", "군인적금", "장병내일적금","MMF", "MMW", "MMW형 CMA", "국고채", "통안채", "지방채", "특수채"]
    
    let small: Set<String> = ["정기예금", "파킹 통장", "정기적금", "자유적금", "청년적금", "군인적금", "장병내일적금", "주택청약통장", "채권", "배당주", "공모주", "보험 상품", "외화 발행어음", "원화 발행어음", "MMW형 CMA", "RP형 CMA", "원화 RP", "외화RP"]
    let short: Set<String> = ["정기예금", "파킹 통장", "MMDA", "정기적금", "자유적금", "MMF", "국내 은행(AA+이하)예금", "저축은행 예금", "지역농협 예금", "외화 발행어음", "원화 발행어음", "발행어음형 CMA", "MMW형 CMA", "RP형 CMA", "MMW", "ISA", "채권", "주식형 ETF", "테마 ETF", "파생형 ETF(인버스,레버리지 등)", "회사채(BB+이하)", "회사채(BBB- ~ BBB+)", "회사채(A-~ A+)", "회사채(AA- ~ AAA)", "CP(A1)", "CP(A2- ~ A2+)"]
    let expert: Set<String> = ["MMDA", "MMF", "주식형 펀드", "섹터/테마형 펀드", "부동산 펀드", "혼합형 펀드", "채권 펀드", "랩 어카운트", "채권", "변액보험" ,"MMW", "REITs"]
    
    
    struct Input {
        
    }
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    func investType(answers: [Bool]) -> String {
        var products: Set<String> = []
        
        switch self.type {
        case "공격투자형":
            products = self.aggressive
        case "적극투자형":
            products = self.active
        case "위험중립형":
            products = self.riskNeutral
        case "안정지향형":
            products = self.stability
        case "안정형":
            products = self.stable
        default:
            products = self.aggressive
        }
        
        switch answers {
        case [false, false, false, false]:
            self.type = "장기 " + self.type
            var temp = products.subtracting(small)
            temp = temp.subtracting(short)
            temp = temp.subtracting(expert)
            return temp.joined(separator: ", ")
        case [false, false, false, true]:
            self.type = "장기 " + self.type
            var temp = products.intersection(expert)
            temp = temp.subtracting(small)
            temp = temp.subtracting(short)
            return temp.joined(separator: ", ")
        case [false, false, true, false]:
            self.type = "단기 " + self.type
            var temp = products.intersection(short)
            temp = temp.subtracting(expert)
            temp = temp.subtracting(small)
            return temp.joined(separator: ", ")
        case [false, false, true, true]:
            self.type = "단기 " + self.type
            var temp = products.intersection(short)
            temp = temp.intersection(expert)
            temp = temp.subtracting(small)
            return temp.joined(separator: ", ")
        case [false, true, false, false]:
            self.type = "장기 " + self.type
            var temp = products/*.intersection(small)*/
            temp = temp.subtracting(short)
            temp = temp.subtracting(expert)
            return temp.joined(separator: ", ")
        case [false, true, false, true]:
            self.type = "장기 " + self.type
            var temp = products/*.intersection(small)*/
            temp = temp.intersection(expert)
            temp = temp.subtracting(short)
            return temp.joined(separator: ", ")
        case [false, true, true, false]:
            self.type = "단기 " + self.type
            var temp = products/*.intersection(small)*/
            temp = temp.intersection(short)
            temp = temp.subtracting(expert)
            return temp.joined(separator: ", ")
        case [false, true, true, true]:
            self.type = "단기 " + self.type
            var temp = products/*.intersection(small)*/
            temp = temp.intersection(short)
            temp = temp.intersection(expert)
            return temp.joined(separator: ", ")
        default:
            return "유형 도출에 실패했어요."
        }
    }
}
