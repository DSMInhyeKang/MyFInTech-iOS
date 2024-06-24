//
//  SavingsViewController.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/19/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SavingsViewController: UIViewController {
    private let viewModel = SavingsViewModel()
    private let disposeBag = DisposeBag()
    
    private let scrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.contentInsetAdjustmentBehavior = .never
        return $0
    }(UIScrollView())
    private let flexContainer = UIView()
    private let descriptionView = TypeDescriptionView()
    private let selectionView = TypeSelectionView()
    private lazy var collectionView: UICollectionView = {
        $0.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.backgroundColor = UIColor.gray1
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: flowLayout()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(flexContainer)
        [
            descriptionView,
            selectionView,
            collectionView
        ].forEach { flexContainer.addSubview($0) }
        
        selectionView.types = ["정기적금", "자유적금", "청년적금", "군인적금"]
        
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        flexContainer.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        descriptionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        selectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.bottom)
            $0.height.equalTo(46)
            $0.horizontalEdges.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(selectionView.snp.bottom).offset(1.5)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(500).priority(.low)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    func bind() {
        let input = SavingsViewModel.Input(viewDidLoad: Observable.just(()))
        let output = viewModel.transform(input: input)
        
        selectionView.selected
            .subscribe(onNext: { [unowned self] idx in
                descriptionView.name = viewModel.descriptions.value[idx].name
                descriptionView.detail = viewModel.descriptions.value[idx].detail
                descriptionView.target = viewModel.descriptions.value[idx].target
                descriptionView.url = viewModel.attachedURL
                
                collectionView.dataSource = nil
                collectionView.delegate = nil
                
                output.products
                    .filter({ $0.count > 0 })
                    .flatMap { Observable.just($0[idx]) }
                    .bind(to: collectionView.rx.items(
                        cellIdentifier: "ProductCell",
                        cellType: ProductCell.self
                    )) { row, products, cell in
                        cell.ranking = row + 1
                        cell.company = products.company
                        cell.name = products.name
                    }.disposed(by: disposeBag)
            }).disposed(by: disposeBag)
        
        collectionView.rx.observe(CGSize.self, "contentSize")
            .compactMap { $0?.height }
            .subscribe(onNext: { [weak self] height in
                self?.collectionView.snp.updateConstraints { $0.height.equalTo(height) }
            })
            .disposed(by: disposeBag)
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
