//
//  SignInViewController.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 4/2/24.
//

import UIKit
import FlexLayout
import PinLayout

class SignInViewController: UIViewController {
    private let flexContainer = UIView()
    private let signInLabel: UILabel = {
        $0.text = "로그인"
        $0.textColor = .black
        $0.font = UIFont(name: "SFPro-Bold", size: 36)
        return $0
    }(UILabel())
    private let googleSignInButton: UIButton = {
        $0.setBackgroundImage(UIImage(named: "GoogleSignIn"), for: .normal)
        return $0
    }(UIButton(type: .system))
    private let kakaoSignInButton: UIButton = {
        $0.setBackgroundImage(UIImage(named: "KakaoSignIn"), for: .normal)
        return $0
    }(UIButton(type: .system))

    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(flexContainer)
        
        flexContainer.flex
            .direction(.column)
            .alignItems(.start)
            .define {
                $0.addItem(signInLabel)
                $0.addItem(kakaoSignInButton)
                $0.addItem(googleSignInButton)
            }
    }
    
    override func viewDidLayoutSubviews() {
        flexContainer.pin.all(view.pin.safeArea)
        flexContainer.flex.layout()
        googleSignInButton.flex.layout(mode: .adjustHeight)
        kakaoSignInButton.flex.layout(mode: .adjustHeight)
        
        signInLabel.pin.top(80).left(24)
        kakaoSignInButton.pin.bottom(48).horizontally(28)
        googleSignInButton.pin.above(of: kakaoSignInButton, aligned: .center).marginBottom(10)
    }
}

