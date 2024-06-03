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
    
    let isSucceededSignIn = PublishRelay<Bool>()
    
    struct Input {
        let buttonTapped: Signal<Void>
        let name: Driver<String>
        let email: Driver<String>
        let sub: Driver<String>
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        self.signIn(input: input)
            
        return Output()
    }
    
    func signUp(input: Input) {
        let registerParam = Driver.combineLatest(input.name, input.email, input.sub)
        
        Driver.combineLatest(input.name, input.email, input.sub).asObservable()
            .flatMap { name, email, sub in
                self.userService.register(name, email, sub)
            }
            .subscribe {
                switch $0 {
                case .completed:
                    self.signIn(input: input)
                case .error(let error):
                    guard let statusCode = (error as? MoyaError)?.response?.statusCode else { return }
                    print(statusCode)
                }
            }.disposed(by: disposeBag)
    }
    
    func signIn(input: Input) {
        let signInParam = Driver.combineLatest(input.email, input.sub)
        
        input.buttonTapped.asObservable()
            .withLatestFrom(signInParam)
            .flatMap { email, sub in
                self.userService.signIn(email, sub)
            }
            .subscribe {
                switch $0 {
                case .completed:
                    self.isSucceededSignIn.accept(true)
                case .error(let error):
                    guard let statusCode = (error as? MoyaError)?.response?.statusCode else { return }

                    if statusCode == 409 {
                        self.signUp(input: input)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
