//
//  DepositViewController.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/19/24.
//

import UIKit
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa

class DepositViewController: UIViewController {
    private let viewModel = ProductViewModel()
    private let disposeBag = DisposeBag()
    
    private let flexContainer = UIView()
    private let scrollView: UIScrollView = {
        return $0
    }(UIScrollView())
    private let descriptionView = TypeDescriptionView()
    private let selectionView = TypeSelectionView()
    private lazy var collectionView: UICollectionView = {
        $0.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: createLayout()))
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        scrollView.flex.define {
            $0.addItem(flexContainer).define { (sub) in
                sub.addItem(descriptionView)
                sub.addItem(selectionView)
                sub.addItem(collectionView)
            }
        }
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
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.pin.all(view.pin.safeArea)
        scrollView.flex.layout()
        
        flexContainer.pin.all()
        flexContainer.pin.width(100%)
        
        descriptionView.pin
            .top(to: flexContainer.edge.top)
            .horizontally()
        selectionView.pin
            .top(to: descriptionView.edge.bottom)
            .horizontally()
        collectionView.pin
            .top(to: selectionView.edge.bottom)
            .horizontally()
            .bottom()
    }
    
    func bind() {
//        viewModel.
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct DepositViewController_Preview: PreviewProvider {
    static var previews: some View {
        DepositViewController().toPreview()
    }
}
#endif
