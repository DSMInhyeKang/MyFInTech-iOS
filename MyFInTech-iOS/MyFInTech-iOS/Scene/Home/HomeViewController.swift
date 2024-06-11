//
//  HomeViewController.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/19/24.
//

import UIKit
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    private let scrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        return $0
    }(UIScrollView())
    private let contentBackView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    private let titleLabel: UILabel = {
        $0.text = "🏆 상품별 추천 순위"
        $0.font = .pretendard(.Bold, 30)
        $0.textColor = .gray8
        return $0
    }(UILabel())
    private let subTitleLabel: UILabel = {
        $0.text = "주인장 선정 내가 가입하고 싶은 금융 상품 모음집"
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .gray6
        return $0
    }(UILabel())
    private lazy var productsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        flowLayout.itemSize = CGSize(width: 168, height: 145)
        $0.register(ProductTypeCell.self, forCellWithReuseIdentifier: "ProductTypeCell")
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.collectionViewLayout = flowLayout
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.flex.define {
            $0.addItem(contentBackView).define { (back) in
                back.addItem(titleLabel)
                back.addItem(subTitleLabel)
                back.addItem(productsCollectionView)
            }
        }
        
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.pin.all()
        view.flex.layout()
        
        scrollView.pin.all(view.pin.safeArea)
        contentBackView.pin
            .all()
            .width(100%)
            .height(1200)
        titleLabel.pin
            .top(30)
            .horizontally(24)
        subTitleLabel.pin
            .below(of: titleLabel)
            .marginTop(14)
            .horizontally(24)
        productsCollectionView.pin
            .below(of: subTitleLabel)
            .marginTop(32)
            .bottom(30)
        
        scrollView.contentSize = contentBackView.frame.size
    }
    
    func bind() {
        viewModel.types
            .bind(to: productsCollectionView.rx.items(
                cellIdentifier: "ProductTypeCell",
                cellType: ProductTypeCell.self
            )) { _, type, cell in
                cell.type = type[0]
                cell.detail = type[1]
            }.disposed(by: disposeBag)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct HomeViewController_Preview: PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
#endif
