//
//  HomeViewController.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/19/24.
//

import UIKit
import FlexLayout
import PinLayout
import RxCocoa

class HomeViewController: UIViewController {
    private let flexContainer = UIView()
    private let headerView: UIView = {
        $0.backgroundColor = .clear
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
        let layout = UICollectionViewFlowLayout()
        $0.collectionViewLayout = layout
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(flexContainer)
        headerView.flex
            .alignItems(.start)
            .define {
                $0.addItem(titleLabel)
                $0.addItem(subTitleLabel)
            }
        flexContainer.flex.define {
            $0.addItem(productsCollectionView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flexContainer.pin.all(view.pin.safeArea)
        flexContainer.flex.layout()
        productsCollectionView.pin.all()
    }
}
