//
//  TypeDescriptionView.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/24/24.
//

import UIKit
import RxCocoa
import FlexLayout
import PinLayout

class TypeDescriptionView: UIView {
    let name = PublishRelay<String>()
    let detail = PublishRelay<String>()
    let target = PublishRelay<String>()
    
    private let flexContainer = UIView()
    private let typeLabel: UILabel = {
        return $0
    }(UILabel())
    private let typeImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    private let recommendTagLabel: UILabel = {
        $0.text = "이런 분에게 추천해요!"
        $0.font = .pretendard(.SemiBold, 14)
        return $0
    }(UILabel())
    private let targetTextView: UITextView = {
        return $0
    }(UITextView())
    
    init(name: String, detail: String, target: String) {
        super.init(frame: .zero)
        addSubview(flexContainer)
        
        self.name.accept(name)
        self.detail.accept(detail)
        self.target.accept(target)
        
        flexContainer.flex.define {
            $0.backgroundColor(.white)
            $0.addItem(typeLabel)
            $0.addItem().alignItems(.center).define { (sub) in
                sub.addItem(typeImageView)
                sub.addItem(recommendTagLabel)
                sub.addItem(targetTextView)
            }
        }
        
        flexContainer.pin.all()
        flexContainer.flex.layout()
        typeImageView.pin.top(to: typeLabel.edge.bottom).marginTop(16)
        typeImageView.pin.width(250).height(250)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
