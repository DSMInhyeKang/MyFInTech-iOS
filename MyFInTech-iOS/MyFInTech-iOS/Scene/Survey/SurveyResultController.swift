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
    private let questionTextView: UITextView = {
        $0.text = "당신에게 어울리는\n재테크 방법은"
        $0.textColor = .black
        $0.font = UIFont(name: "SFPro-Bold", size: 36)
        return $0
    }(UITextView())
    private let recommendationImageView: UIImageView = {
        $0.image = UIImage(named: "bitcoin")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(flexContainer)
        
        flexContainer.flex
            .direction(.column)
            .alignItems(.center)
            .define {
                $0.addItem(questionTextView)
                $0.addItem(recommendationImageView)
            }
    }
    
    override func viewDidLayoutSubviews() {
        flexContainer.pin.all(view.pin.safeArea)
        flexContainer.flex.layout()
        
        questionTextView.pin.top(80).left(24)
        recommendationImageView.pin
            .below(of: questionTextView)
            .height(340)
            .marginTop(90)
    }
}
