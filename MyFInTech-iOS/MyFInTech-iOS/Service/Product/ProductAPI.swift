//
//  ProductAPI.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/20/24.
//

import Foundation
import Moya

enum ProductAPI {
    case fetchAllDeposits
    case fetchAllSavings
    case fetchAllCMAs
}

extension ProductAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://127.0.0.1:8443/product")!
    }
    
    var path: String {
        switch self {
        case .fetchAllDeposits:
            return "/deposits"
        case .fetchAllSavings:
            return "/savings"
        case .fetchAllCMAs:
            return "/cmas"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAllDeposits, .fetchAllSavings, .fetchAllCMAs:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchAllDeposits, .fetchAllSavings, .fetchAllCMAs:
            return TokenStorage.shared.toHeader(.accessToken)
        }
    }
}
