//
//  SurveyResultController.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 4/18/24.
//

import UIKit
import FlexLayout
import PinLayout

class SurveyResultController: UIViewController {
    private let flexContainer = UIView()
    private let titleLabel: UILabel = {
        $0.text = "당신의 투자 성향은"
        $0.textColor = .black
        $0.font = .pretendard(.Bold, 32)
        return $0
    }(UILabel())
    private let recommendationImageView: UIImageView = {
//        $0.image = UIImage(named: "bitcoin")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    private let typeLabel: UILabel = {
        $0.font = .pretendard(.Bold, 20)
        $0.textColor = .black
        return $0
    }(UILabel())
    private let typeTextView: UITextView = {
        $0.setLineHeight(24, .gray8, .pretendard(.Regular, 17), .center)
        return $0
    }(UITextView())
    private let productLabel: UILabel = {
        $0.font = .pretendard(.Bold, 20)
        $0.textColor = .black
        return $0
    }(UILabel())
    private let productTextView: UITextView = {
        $0.setLineHeight(24, .gray8, .pretendard(.Regular, 17), .center)
        return $0
    }(UITextView())
    private let toHomeButton: UIButton = {
        $0.setTitle("홈 화면으로", for: .normal)
        $0.setTitleColor(.title, for: .normal)
        $0.titleLabel?.font = .pretendard(.SemiBold, 18)
        $0.backgroundColor = .background
        return $0
    }(UIButton(type: .system))

    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(flexContainer)
        
        flexContainer.flex
            .direction(.column)
            .alignItems(.center)
            .define {
                $0.addItem(titleLabel)
                $0.addItem(recommendationImageView)
                $0.addItem(typeLabel)
                $0.addItem(typeTextView)
                $0.addItem(productLabel)
                $0.addItem(productTextView)
                $0.addItem(toHomeButton)
            }
    }
    
    override func viewDidLayoutSubviews() {
        flexContainer.pin.all(view.pin.safeArea)
        flexContainer.flex.layout()
        
        titleLabel.pin.top(100).left(24)
        recommendationImageView.pin
            .below(of: titleLabel)
            .height(248)
            .marginTop(42)
        typeLabel.pin
            .marginTop(54)
            .hCenter()
        typeTextView.pin
            .marginTop(8)
            
    }
}
