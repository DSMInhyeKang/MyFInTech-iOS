//
//  ProductService.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/24/24.
//

import Foundation
import Moya
import RxSwift

class ProductService {
    private let manager: Session
    private let provider: MoyaProvider<ProductAPI>
    
    init() {
        self.manager = Session(configuration: URLSessionConfiguration.default, serverTrustManager: CustomServerTrustManager())
        self.provider = MoyaProvider<ProductAPI>(session: manager, plugins: [MoyaLoggingPlugin()])
    }
    
    func fetchAllDeposits() -> Single<[[DepositEntity]]> {
        return provider.rx.request(.fetchAllDeposits)
            .filterSuccessfulStatusCodes()
            .catch { .error($0) }
            .map(FetchDepositsResponseDTO.self)
            .map { $0.toDomain() }
    }
    
    func fetchAllSavings() -> Single<[[SavingsEntity]]> {
        return provider.rx.request(.fetchAllSavings)
            .filterSuccessfulStatusCodes()
            .catch { .error($0) }
            .map(FetchSavingsResponseDTO.self)
            .map { $0.toDomain() }
    }
}
