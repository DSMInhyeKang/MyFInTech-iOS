//
//  SurveyViewController.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 4/18/24.
//

import UIKit
import FlexLayout
import PinLayout

class SurveyViewController: UIViewController {
    private let flexContainer = UIView()
    private let questionTextView: UITextView = {
        $0.text = "정기적으로\n금액을 불입할\n의향이 있다."
        $0.textColor = .black
        $0.font = UIFont(name: "SFPro-Bold", size: 36)
        return $0
    }(UITextView())
    private let yesButton: UIButton = {
        $0.setTitle("예", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "SFPro-Semibold", size: 20)
        $0.backgroundColor = UIColor(named: "primary")
        return $0
    }(UIButton(type: .system))
    private let noButton: UIButton = {
        $0.setTitle("아니오", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "SFPro-Semibold", size: 20)
        $0.backgroundColor = UIColor(named: "primary")
        return $0
    }(UIButton(type: .system))

    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(flexContainer)
        
        flexContainer.flex
            .direction(.column)
            .alignItems(.start)
            .define {
                $0.addItem(questionTextView)
                $0.addItem(yesButton).cornerRadius(8)
                $0.addItem(noButton).cornerRadius(8)
            }
    }
    
    override func viewDidLayoutSubviews() {
        flexContainer.pin.all(view.pin.safeArea)
        flexContainer.flex.layout()
        yesButton.flex.layout(mode: .adjustHeight)
        noButton.flex.layout(mode: .adjustHeight)
        
        questionTextView.pin.top(80).left(24)
        noButton.pin.bottom(48).horizontally(28).height(54)
        yesButton.pin
            .above(of: noButton, aligned: .center)
            .width(of: noButton)
            .height(of: noButton)
            .marginBottom(12)
    }
}
