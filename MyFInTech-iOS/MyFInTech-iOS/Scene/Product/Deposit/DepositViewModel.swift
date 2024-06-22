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
            일정 금액을 한 번 납입 후 약정 기간 동안 예치해두었다가, 만기 시 원금을 찾는 상품이에요.
            만기 전 출금이 불가능해요. (중도해지, 긴급출금 가능 상품 제외)
            단리식(매월 이자 지급)/복리식(만기 시 이자 지급) 상품이 있어요.
            목돈 불리기에 적합해요.
            """,
            target: "당장 여유 자금이 필요하지 않고, 목돈을 불리고 싶은 사람"
        ),
        Descriptions(
            name: "파킹통장",
            detail: """
            파킹 통장 설명
            """,
            target: "파킹통장 추천 대상"
        ),
        Descriptions(
            name: "MMDA",
            detail: """
            MMDA 설명
            """,
            target: "MMDA 추천 대상"
        )
    ])
    
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
