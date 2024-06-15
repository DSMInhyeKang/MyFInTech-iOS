//
//  ProductViewController.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/23/24.
//

import UIKit
import FlexLayout
import PinLayout
import ReactorKit
import RxDataSources
import RxCocoa

class ProductViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: createLayout()))
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
//        view.addSubview(flexContainer)
//        
//        typeDescriptionView.name = "적금"
//        typeDescriptionView.detail = "적금은 일정 금액을 여러 번에 걸쳐 납입한 뒤, 만기 후 금액+이자를 받는 예금 형식 상품이에요. 목돈 마련에 적합해요."
//        typeDescriptionView.target = """
//        [정기적금] - 당장 여유 자금이 필요하지 않고, 매월 꾸준히 납입할 수 있는 사람
//        [부금] - 목돈을 마련하고 싶지만, 당장 여유 자금이 충분하지 않아 대출을 원하는 사람
//        [자유적금] - 수입이 일정하지 않고, 소액 저축이나 유동적인 자산 관리를 원하는 사람
//        """
//        
//        flexContainer.flex
//            .direction(.column)
//            .alignItems(.start)
//            .define {
//                $0.addItem(typeDescriptionView)
//            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
//        flexContainer.pin.all(view.pin.safeArea)
//        flexContainer.flex.layout()
//        
//        typeDescriptionView.pin.all()
        
        collectionView.pin.all()
    }
}

extension ProductViewController {
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(2000))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
