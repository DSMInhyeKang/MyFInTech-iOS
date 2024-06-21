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
    private let viewModel = DepositViewModel()
    private let disposeBag = DisposeBag()
    
    private let scrollView: UIScrollView = {
        return $0
    }(UIScrollView())
    private let flexContainer = UIView()
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
        
        selectionView.types = ["정기예금", "파킹통장", "MMDA"]
        
        scrollView.flex.define {
            $0.addItem(flexContainer).define { (sub) in
                sub.addItem(descriptionView)
                sub.addItem(selectionView)
                sub.addItem(collectionView)
            }
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.descriptions.subscribe(onNext: { [unowned self] data in
            descriptionView.name = data[selectionView.selected.value].name
            descriptionView.detail = data[selectionView.selected.value].detail
            descriptionView.target = data[selectionView.selected.value].target
        })
        descriptionView.name = viewModel.descriptions.value[selectionView.selected.value].name
        descriptionView.detail = viewModel.descriptions.value[selectionView.selected.value].detail
        descriptionView.target = viewModel.descriptions.value[selectionView.selected.value].target

        let input = DepositViewModel.Input(viewDidLoad: Observable.just(()))
        let output = viewModel.transform(input: input)
        
//        let current = BehaviorRelay<[DepositEntity]>(value: [])
//        current.accept(output.products.value[selectionView.selected.value])
        
        output.products
            .flatMap { Observable.just($0[self.selectionView.selected.value]) }
            .bind(to: collectionView.rx.items(
                cellIdentifier: "ProductCell",
                cellType: ProductCell.self
            )) { _, products, cell in
//                cell.ranking = current.value.indices.filter(
//                    { current.value[$0].name == products.name }
//                ).first!
                cell.ranking = 0
                cell.company = products.company
                cell.name = products.name
            }.disposed(by: disposeBag)
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
