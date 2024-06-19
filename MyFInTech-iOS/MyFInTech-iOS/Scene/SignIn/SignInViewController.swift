//
//  SignInViewController.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 4/2/24.
//

import UIKit
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa
import GoogleSignIn

class SignInViewController: UIViewController {
    let viewModel = SignInViewModel()
    private let disposeBag = DisposeBag()
    
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
        
        bind()
        
        
//        kakaoSignInButton.rx.tap
//            .subscribe(onNext: {
//            })
//            .disposed(by: disposeBag)
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
    
    func bind() {
        let isInfoEntered = PublishRelay<Bool>()
        
        googleSignInButton.rx.tap
            .subscribe(onNext: {
                GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
                    guard error == nil else { return }
                    guard let signInResult = signInResult else { return }
                    
                    self.viewModel.name = signInResult.user.profile!.name
                    self.viewModel.email = signInResult.user.profile!.email
                    self.viewModel.sub = signInResult.user.userID!
                    
                    isInfoEntered.accept(true)
                }
            })
            .disposed(by: disposeBag)
        
        let input = SignInViewModel.Input(isInfoEntered: isInfoEntered.asSignal())
        let _ = viewModel.transform(input: input)
        
        viewModel.isSucceededSignIn
            .subscribe(onNext: {
                if $0 == true {
                    let home = HomeViewController()
                    home.modalPresentationStyle = .fullScreen
                    self.present(home, animated: true)
                }
            }).disposed(by: disposeBag)
    }
}

