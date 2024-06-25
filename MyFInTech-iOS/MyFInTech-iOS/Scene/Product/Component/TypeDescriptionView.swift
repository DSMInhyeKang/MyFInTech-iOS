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
        set {
            typeLabel.text = newValue
            typeImageView.image = newValue.convertProduct()
        }
    }
    var detail: String {
        get { detailTextView.text ?? "" }
        set { 
            detailTextView.text = newValue
            detailTextView.setLineAndLetterSpacing(4, 0.85, .gray7, .pretendard(.Regular, 16), .justified)
        }
    }
    var target: String {
        get { targetTextView.text ?? "" }
        set { 
            targetTextView.text = newValue
            targetTextView.setLineAndLetterSpacing(4, 0.3, .gray7, .pretendard(.Regular, 14), .center)
        }
    }
    var url: String = ""
    
    private let typeLabel: UILabel = {
        $0.font = .pretendard(.Bold, 32)
        $0.numberOfLines = 0
        $0.textColor = .black
        return $0
    }(UILabel())
    private let linkButton: UIButton = {
        $0.setImage(UIImage(systemName: "questionmark.circle.fill"), for: .normal)
        $0.tintColor = .gray8
        return $0
    }(UIButton(type: .system))
    private let typeImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "적금")
        return $0
    }(UIImageView())
    private let detailTextView: UITextView = {
        $0.font = .pretendard(.Regular, 16)
        $0.textColor = .gray8
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
        $0.layer.cornerRadius = 8
        return $0
    }(UILabel())
    private let targetTextView: UITextView = {
        $0.font = .pretendard(.Regular, 14)
        $0.textColor = .gray7
        $0.textAlignment = .center
        $0.isEditable = false
        $0.isSelectable = false
        $0.isScrollEnabled = false
        return $0
    }(UITextView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [
            typeLabel,
            linkButton,
            typeImageView,
            detailTextView,
            recommendTagLabel,
            targetTextView
        ].forEach { self.addSubview($0) }
        
        linkButton.addAction(UIAction { [weak self] _ in
            if let url = URL(string: self?.url ?? "") { UIApplication.shared.open(url, options: [:]) }
        }, for: .allTouchEvents)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        typeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(94)
            $0.left.equalToSuperview().inset(24)
        }
        linkButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(98)
            $0.width.height.equalTo(30)
            $0.right.equalToSuperview().inset(24)
        }
        typeImageView.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(250)
            $0.centerX.equalToSuperview()
        }
        detailTextView.snp.makeConstraints {
            $0.top.equalTo(typeImageView.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        recommendTagLabel.snp.makeConstraints {
            $0.top.equalTo(detailTextView.snp.bottom).offset(32)
            $0.width.equalTo(136)
            $0.height.equalTo(25)
            $0.centerX.equalToSuperview()
        }
        targetTextView.snp.makeConstraints {
            $0.top.equalTo(recommendTagLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
}
