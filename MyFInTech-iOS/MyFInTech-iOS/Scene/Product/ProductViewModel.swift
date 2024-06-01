//
//  ProductViewModel.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/31/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

class ProductViewModel {
    let products = BehaviorRelay<ProductSection>(value: ProductSection(
        headers: HeaderItem(
            name: "적금",
            detail: "적금은 일정 금액을 여러 번에 걸쳐 납입한 뒤, 만기 후 금액+이자를 받는 예금 형식 상품이에요. 목돈 마련에 적합해요.",
            target: """
                [정기적금] - 당장 여유 자금이 필요하지 않고, 매월 꾸준히 납입할 수 있는 사람
                [부금] - 목돈을 마련하고 싶지만, 당장 여유 자금이 충분하지 않아 대출을 원하는 사람
                [자유적금] - 수입이 일정하지 않고, 소액 저축이나 유동적인 자산 관리를 원하는 사람
            """,
            types: ["정기적금", "자유적금", "청년적금", "청년도약계좌", "주택청약", "군인적금"]
        ),
        items: [
//            SectionItem(id: 0, type: "정기적금", name: <#T##String#>, company: <#T##String#>, maxRate: <#T##String#>, defaultRate: <#T##String#>, target: <#T##String#>, isProtected: <#T##Bool#>, detail: <#T##String#>, URL: <#T##String#>, isBankingSector: <#T##Bool#>)
        ]
    ))
    init() {
        
    }

    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<ProductSection>(
        configureCell: { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ProductCell",
                for: indexPath
            ) as? ProductCell
            
            return cell ?? .init()
        }, configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            if indexPath.section ==  0 {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "DescriptionHeader",
                    for: indexPath
                ) as? TypeDescriptionView
                
                header?.name = dataSource[indexPath.section].headers.name
                header?.detail = dataSource[indexPath.section].headers.detail
                header?.target = dataSource[indexPath.section].headers.target
                
                return header ?? .init()
            } else if indexPath.section == 1 {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "SelectionHeader",
                    for: indexPath
                ) as? TypeSelectionView
                
                header?.types = dataSource[indexPath.section].headers.types
                
                return header ?? .init()
            } else { return UICollectionReusableView() }
        }
    )
}
