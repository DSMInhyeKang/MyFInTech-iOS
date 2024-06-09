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
        return $0
    }(UIScrollView())
    private let contentBackView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    private let titleLabel: UILabel = {
        $0.text = "금융 상품별 추천 순위"
        $0.font = .pretendard(.Bold, 36)
        $0.textColor = .black
        return $0
    }(UILabel())
    private let subTitleLabel: UILabel = {
        $0.text = "주인장 선정 내가 가입하고 싶은 Best 20 금융 상품 모음"
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        return $0
    }(UILabel())
    private lazy var productsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
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
    }(UICollectionView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentBackView)
        contentBackView.flex.define {
            $0.addItem(titleLabel)
            $0.addItem(subTitleLabel)
            $0.addItem(productsCollectionView)
        }
        
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.pin.all(view.pin.safeArea)
        view.flex.layout()
        
        scrollView.pin.all()
        contentBackView.pin
            .all()
            .width(100%)
            .height(1000)
        titleLabel.pin
            .top(38)
            .left(24)
        subTitleLabel.pin
            .below(of: titleLabel)
            .marginTop(12)
            .left(24)
        productsCollectionView.pin
            .below(of: subTitleLabel)
            .marginTop(60)
            .bottom(30)
    }
    
    func bind() {
        viewModel.types
            .bind(to: productsCollectionView.rx.items(
                cellIdentifier: "ProductTypeCell",
                cellType: ProductTypeCell.self
            )) { _, type, cell in
            }.disposed(by: disposeBag)
    }
}
