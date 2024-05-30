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
//    let name = PublishRelay<String>()
//    let detail = PublishRelay<String>()
//    let target = PublishRelay<String>()
    var name: String {
        get { typeLabel.text ?? "" }
        set { typeLabel.text = newValue }
    }
    var detail: String {
        get { detailTextView.text ?? "" }
        set { detailTextView.text = newValue }
    }
    var target: String {
        get { targetTextView.text ?? "" }
        set { targetTextView.text = newValue }
    }
    
    private let flexContainer = UIView()
    private let typeLabel: UILabel = {
        $0.font = .pretendard(.Bold, 32)
        $0.textColor = .black
        $0.layer.borderColor = UIColor.yellow.cgColor
        $0.layer.borderWidth = 1
        return $0
    }(UILabel())
    private let typeImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "적금")
        $0.layer.borderColor = UIColor.brown.cgColor
        $0.layer.borderWidth = 1
        return $0
    }(UIImageView())
    private let detailTextView: UITextView = {
        $0.font = .pretendard(.Regular, 16)
        $0.textColor = .black
        $0.isEditable = false
        $0.isSelectable = false
        $0.isScrollEnabled = false
        $0.layer.borderColor = UIColor.systemTeal.cgColor
        $0.layer.borderWidth = 1
        return $0
    }(UITextView())
    private let recommendTagLabel: UILabel = {
        $0.text = "이런 분에게 추천해요!"
        $0.font = .pretendard(.SemiBold, 14)
        $0.textAlignment = .center
        $0.textColor = .tag
        $0.backgroundColor = .blur
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.green.cgColor
        $0.layer.borderWidth = 1
        return $0
    }(UILabel())
    private let targetTextView: UITextView = {
        $0.font = .pretendard(.Regular, 14)
        $0.textColor = .black
        $0.isEditable = false
        $0.isSelectable = false
        $0.isScrollEnabled = false
        $0.layer.borderColor = UIColor.orange.cgColor
        $0.layer.borderWidth = 1
        return $0
    }(UITextView())
    
    init(/*name: String, detail: String, target: String*/) {
        super.init(frame: .zero)
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1

        self.flex
            .justifyContent(.center)
            .define {
                $0.addItem(typeLabel)
                $0.addItem(typeImageView)
                $0.addItem(detailTextView)
                    .paddingHorizontal(40)
                $0.addItem(recommendTagLabel)
                    .padding(4, 8)
                    .cornerRadius(8)
                $0.addItem(targetTextView)
                    .paddingHorizontal(50)
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flex.layout()
        
        typeLabel.pin
            .top(40)
            .left(24)
        typeImageView.pin
            .below(of: typeLabel)
            .marginTop(16)
            .width(250)
            .height(250)
            .hCenter()
        detailTextView.pin
            .below(of: typeImageView)
            .marginTop(40)            
            .horizontally(44)
        recommendTagLabel.pin
            .below(of: detailTextView)
            .marginTop(40)
            .width(136)
            .height(25)
            .hCenter()
        targetTextView.pin
            .below(of: recommendTagLabel)
            .marginTop(30)
            .horizontally(50)
    }
}
