//
//  TypeDescriptionView.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/24/24.
//

import UIKit
import RxCocoa
import SnapKit

class TypeDescriptionView: UIView {
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
    
    private let typeLabel: UILabel = {
        $0.font = .pretendard(.Bold, 32)
        $0.textColor = .black
        return $0
    }(UILabel())
    private let typeImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "적금")
        return $0
    }(UIImageView())
    private let detailTextView: UITextView = {
        $0.font = .pretendard(.Regular, 16)
        $0.textColor = .black
        $0.isEditable = false
        $0.isSelectable = false
        $0.isScrollEnabled = false
        return $0
    }(UITextView())
    private let recommendTagLabel: UILabel = {
        $0.text = "이런 분에게 추천해요!"
        $0.font = .pretendard(.SemiBold, 14)
        $0.textAlignment = .center
        $0.textColor = .tag
        $0.backgroundColor = .blur
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    private let targetTextView: UITextView = {
        $0.font = .pretendard(.Regular, 14)
        $0.textColor = .black
        $0.isEditable = false
        $0.isSelectable = false
        $0.isScrollEnabled = false
        return $0
    }(UITextView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [
            typeLabel,
            typeImageView,
            detailTextView,
            recommendTagLabel,
            targetTextView
        ].forEach { self.addSubview($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        typeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(24)
        }
        typeImageView.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(250)
            $0.centerX.equalToSuperview()
        }
        detailTextView.snp.makeConstraints {
            $0.top.equalTo(typeImageView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        recommendTagLabel.snp.makeConstraints {
            $0.top.equalTo(detailTextView.snp.bottom).offset(40)
            $0.width.equalTo(136)
            $0.height.equalTo(25)
            $0.centerX.equalToSuperview()
        }
        targetTextView.snp.makeConstraints {
            $0.top.equalTo(recommendTagLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
}
