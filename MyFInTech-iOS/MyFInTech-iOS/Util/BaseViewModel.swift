//
//  BaseViewModel.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/3/24.
//

import Foundation
import RxSwift

protocol BaseViewModel {
    var disposeBag: DisposeBag { get set }

    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
