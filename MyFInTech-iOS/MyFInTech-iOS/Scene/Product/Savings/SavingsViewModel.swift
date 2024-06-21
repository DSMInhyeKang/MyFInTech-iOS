//
//  SavingsViewModel.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/19/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

class SavingsViewModel: BaseViewModel {
    var disposeBag = DisposeBag()
    let productService = ProductService()
    
    let descriptions = BehaviorRelay<[Descriptions]>(value: [
        Descriptions(
            name: "정기적금",
            detail: """
                일정 금액을 약정 기간 동안 매달 납입한 뒤, 만기 후 금액+이자를 받는 상품이에요.
                만기 전 출금이 불가능해요. (중도해지, 긴급출금 가능 상품 제외)
                목돈 마련에 적합해요.
            """,
            target: "당장 여유 자금이 필요하지 않고, 매월 꾸준히 납입할 수 있는 사람"
        ),
        Descriptions(
            name: "자유적금",
            detail: """
                약정 기간 동안 금액을 자유롭게 납입한 뒤, 만기 후 금액+이자를 받는 상품이에요.
                정기적금 상품보다 금리가 낮아요.
            """,
            target: "프리랜서(수입이 일정하지 않은 사람), 소액 저축을 원하는 사람"
        ),
        Descriptions(
            name: "청년적금/청년도약계좌",
            detail: """
            - 청년 적금
              : 청년을 대상으로 제공하는 적금 상품이에요.
            - 청년도약계좌
              : 서민금융진흥원에서 발표한 만 19세 ~ 34세 이하의 청년 전용 적금 상품이에요.
                개인소득요건, 가구소득요건을 모두 충족해야 가입이 가능해요.
                가입일 직전 3개년도 중 1회 이상 금융소득종합과세 대상에 해당하지 않아야 해요.
            """,
            target: "상품별 가입 조건 정보 참고"
        ),
        Descriptions(
            name: "군인적금/장병내일준비적금",
            detail: """
            - 군인적금
              : 군복무 중인 군인을 대상으로하는 적금 상품이에요
            - 장병 내일준비적금
              : 현역병, 상근예비역, 의무경찰, 해양의무경찰, 의무소방원, 사회복무요원, 대체복무요원 전용 상품이에요.
                남은 복무 기간이 6개월 1일 이상이어야 해요.
            """,
            target: "상품별 가입 조건 정보 참고"
        )
    ])
//    let allProducts = BehaviorRelay<[[SavingsEntity]]>(value: [])
    
    struct Input {
        let viewDidLoad: Observable<Void>
        
    }
    struct Output {
        let products: BehaviorRelay<[[SavingsEntity]]>
    }
    
    func transform(input: Input) -> Output {
        let products = BehaviorRelay<[[SavingsEntity]]>(value: [])
        
        input.viewDidLoad
            .flatMap { self.productService.fetchAllSavings() }
            .subscribe(
                with: self,
                onNext: { _, data in
                    products.accept(data)
                }
            ).disposed(by: disposeBag)
        
        return Output(products: products)
    }
}
