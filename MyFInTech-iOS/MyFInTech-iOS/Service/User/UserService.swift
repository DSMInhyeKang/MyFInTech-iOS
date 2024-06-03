//
//  UserService.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/24/24.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

class UserService {
    private let provider = MoyaProvider<UserAPI>(plugins: [MoyaLoggingPlugin()])
    
    func register(_ name: String, _ email: String, _ sub: String) ->  Completable {
        return Completable.create { [weak self] completable in
            guard let self else { return Disposables.create() }
            return provider.rx.request(.register(name: name, email: email, sub: sub))
                .subscribe(onSuccess: { _ in
                    completable(.completed)
                }, onFailure: { completable(.error($0)) })
        }
    }
    
    func signIn(_ email: String, _ sub: String) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self else { return Disposables.create() }
            return provider.rx.request(.signIn(email: email, sub: sub))
                .map(SignInResponse.self)
                .subscribe(onSuccess: {
                    TokenStorage.shared.accessToken = $0.accessToken
                    TokenStorage.shared.refreshToken = $0.refreshToken
                    completable(.completed)
                }, onFailure: { completable(.error($0)) })
        }
    }
}
