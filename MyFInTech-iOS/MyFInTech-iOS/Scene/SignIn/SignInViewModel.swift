//
//  SignInViewModel.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/3/24.
//

import Foundation
import Moya
import RxSwift
import RxRelay
import RxCocoa
import GoogleSignIn

class SignInViewModel: BaseViewModel {
    var disposeBag = DisposeBag()
    let userService = UserService()
    
    let isSucceededSignIn = BehaviorRelay<Bool>(value: false)
    var name = String()
    var email = String()
    var sub = String()
    
    struct Input {
        let buttonTapped: Signal<Void>
        let name: PublishRelay<String>
        let email: PublishRelay<String>
        let sub: PublishRelay<String>
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        Observable.combineLatest(input.name, input.email, input.sub)
            .subscribe { name, email, sub in
            self.name = name
            self.email = email
            self.sub = sub
        }.disposed(by: disposeBag)
        
        input.buttonTapped.asObservable()
            .subscribe(onNext: {
                self.signIn()
            })
            .disposed(by: disposeBag)
            
        return Output()
    }
    
    func signUp() {
        self.userService.register(self.name, self.email, self.sub)
            .subscribe {
                switch $0 {
                case .completed:
                    self.signIn()
                case .error(let error):
                    guard let statusCode = (error as? MoyaError)?.response?.statusCode else { return }
                    if statusCode == 409 { self.signIn() }
                }
            }.disposed(by: disposeBag)
    }
    
    func signIn() {
        self.userService.signIn(self.email, self.sub)
            .subscribe {
                switch $0 {
                case .completed:
                    self.isSucceededSignIn.accept(true)
                case .error(let error):
                    guard let statusCode = (error as? MoyaError)?.response?.statusCode else { return }
                    if statusCode == 404 { self.signUp() }
                }
            }.disposed(by: disposeBag)
    }
}
