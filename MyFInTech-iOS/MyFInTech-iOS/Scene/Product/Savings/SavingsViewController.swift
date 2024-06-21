//
//  SavingsViewController.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/19/24.
//

import UIKit
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa

class SavingsViewController: UIViewController {
    private let viewModel = SavingsViewModel()
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
        
        selectionView.types = ["정기적금", "자유적금", "청년적금", "군인적금"]
        
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
            .below(of: descriptionView)
            .horizontally()
        collectionView.pin
            .below(of: selectionView)
            .horizontally()
            .bottom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectionView.selected.subscribe(onNext: { index in
            print(index)
        }).disposed(by: disposeBag)
        descriptionView.name = viewModel.descriptions.value[selectionView.selected.value].name
        descriptionView.detail = viewModel.descriptions.value[selectionView.selected.value].detail
        descriptionView.target = viewModel.descriptions.value[selectionView.selected.value].target

        let input = SavingsViewModel.Input(viewDidLoad: Observable.just(()))
        let output = viewModel.transform(input: input)
//        let current = BehaviorRelay<[SavingsEntity]>(value: [])
//        current.accept(output.products.value[selectionView.selected.value])
//        
//        current.bind(to: collectionView.rx.items(
//            cellIdentifier: "ProductCell",
//            cellType: ProductCell.self
//        )) { _, products, cell in
//            cell.ranking = current.value.indices.filter(
//                { current.value[$0].name == products.name }
//            ).first!
//            cell.company = products.company
//            cell.name = products.name
//        }.disposed(by: disposeBag)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SavingsViewController_Preview: PreviewProvider {
    static var previews: some View {
        SavingsViewController().toPreview()
    }
}
#endif
