//
//  DepositViewModel.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/19/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

class DepositViewModel: BaseViewModel {
    var disposeBag = DisposeBag()
    let productService = ProductService()
    
    let descriptions = BehaviorRelay<[Descriptions]>(value: [
        Descriptions(
            name: "정기예금",
            detail: """
            🧑‍🏫   일정 금액을 약정기간 동안 예치해두었다가,
            \t  만기 시 원금을 찾는 상품이에요.
            🚨   만기 전 출금이 불가능해요. (중도해지, 긴급
            \t  출금 가능 상품 제외)
            ✅   단리식(매월 이자 지급)/복리식(만기 시
            \t  이자 지급) 상품이 있어요.
            💁   목돈 불리기에 적합해요.
            """,
            target: "당장 여윳돈이 필요하지 않고, 목돈을 불리고 싶은 사람"
        ),
        Descriptions(
            name: "파킹통장",
            detail: """
            🧑‍🏫   차를 잠시 주차하듯, 언제든지 자유롭게
            \t  입출금이 가능한 보통예금 상품이에요.
            🚨   단기 운용 상품이에요.
            ✅   하루만 넣어도 이자가 쌓여요.
            💁   비상금/목돈 단기 보관에 적합해요.
            """,
            target: "안전자산을 잠시 맡기고 싶은 사람"
        ),
        Descriptions(
            name: "MMDA",
            detail: """
            🧑‍🏫   시장금리부 수시입출금식 예금으로, 금액에
            \t  제한이 없고 자유롭게 입출금할 수 있어요.
            🚨   예치 기간이 7일 미만인 경우 이자율이
            \t  낮거나 없을 수도 있어요.
            ✅   금액 규모에 따라 차등 금리를 적용해요.
            💁   목돈 단기 보관에 적합해요.
            """,
            target: "갑자기 목돈이 생겼을 때 잠시 보관하고 싶은 사람"
        )
    ])
    let attachedURL = "https://benevolent-grace.notion.site/22f5b3964e1a44de8bee3d809dabfc0a?pvs=4"
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    struct Output {
        let products: BehaviorRelay<[[DepositEntity]]>
    }
    
    func transform(input: Input) -> Output {
        let products = BehaviorRelay<[[DepositEntity]]>(value: [])
        
        input.viewDidLoad
            .flatMap { self.productService.fetchAllDeposits() }
            .subscribe(
                with: self,
                onNext: { _, data in
                    products.accept(data)
                }
            ).disposed(by: disposeBag)
        
        return Output(products: products)
    }
}
