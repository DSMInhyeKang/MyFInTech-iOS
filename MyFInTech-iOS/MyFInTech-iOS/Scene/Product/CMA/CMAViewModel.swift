//
//  CMAViewModel.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/21/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

class CMAViewModel: BaseViewModel {
    var disposeBag = DisposeBag()
    let productService = ProductService()
    
    let descriptions = BehaviorRelay<[Descriptions]>(value: [
        Descriptions(
            name: "발행어음",
            detail: """
            CMA는 (통장에) 맡긴 돈을 어음/채권 등에 투자하여 그 수익의 일부를 되돌려주는 금융 상품이에요.
            발행어음형 CMA는 증권사가 발행한 어음을 사고파는 상품이에요.
            금리가 정해져 있어요.
            """,
            target: ""
        ),
        Descriptions(
            name: "RP형",
            detail: """
            CMA는 (통장에) 맡긴 돈을 어음/채권 등에 투자하여 그 수익의 일부를 되돌려주는 금융 상품이에요.
            RP형 CMA는 환매형 채권(지방채, 국공채, AAA등급 회사채 등)에 투자하는 상품이에요.
            금리가 정해져 있어요.
            """,
            target: ""
        ),
        Descriptions(
            name: "MMF형",
            detail: """
            CMA는 (통장에) 맡긴 돈을 어음/채권 등에 투자하여 그 수익의 일부를 되돌려주는 금융 상품이에요.
            MMF형 CMA는 국공채, CP, CD, 콜론 등 수익률이 높은 단기 금융 상품에 투자하는 펀드 상품이에요.
            금리가 정해져 있지 않아요.
            """,
            target: ""
        ),
        Descriptions(
            name: "MMW형",
            detail: """
            CMA는 (통장에) 맡긴 돈을 어음/채권 등에 투자하여 그 수익의 일부를 되돌려주는 금융 상품이에요.
            MMW형 CMA는 자금을 한국증권금융에 위탁하여 운용하는 상품이에요.
            비대면 개설이 불가능해요.
            금리가 정해져 있지 않아요.
            """,
            target: ""
        )
    ])
    let attachedURL = "https://benevolent-grace.notion.site/CMA-7ee7ed1166fc4b04a7e1cfa86d5e7e1c?pvs=4"
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    struct Output {
        let products: BehaviorRelay<[[CMAEntity]]>
    }
    
    func transform(input: Input) -> Output {
        let products = BehaviorRelay<[[CMAEntity]]>(value: [])
        
        input.viewDidLoad
            .flatMap { self.productService.fetchAllCMAs() }
            .subscribe(
                with: self,
                onNext: { _, data in
                    products.accept(data)
                }
            ).disposed(by: disposeBag)
        
        return Output(products: products)
    }
}
