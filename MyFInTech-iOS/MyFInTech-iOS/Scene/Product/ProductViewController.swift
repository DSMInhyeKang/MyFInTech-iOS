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
import RxCocoa

class ProductViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let flexContainer = UIView()
    
    private let typeDescriptionView = UIView()
    private let productTypeLabel: UILabel = {
        $0.text = "적금"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 32, weight: .semibold)
        return $0
    }(UILabel())
    private let collectionView: UICollectionView = {
        return $0
    }(UICollectionView())
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        view.addSubview(flexContainer)
        
        flexContainer.flex
            .direction(.column)
            .alignItems(.start)
            .define {
                $0.addItem(collectionView)
            }
        
        typeDescriptionView.flex.define {
            $0.addItem(productTypeLabel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(flexContainer)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        flexContainer.pin.all(view.pin.safeArea)
        flexContainer.flex.layout()
        
        
    }
}
