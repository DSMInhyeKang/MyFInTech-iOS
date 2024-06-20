//
//  CustomServerTrustManager.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/20/24.
//

import Foundation
import Alamofire

class CustomServerTrustManager : ServerTrustManager {
    override func serverTrustEvaluator(forHost host: String) throws -> (any ServerTrustEvaluating)? {
        return DisabledTrustEvaluator()
    }
    
    public init() {
        super.init(evaluators: [:])
    }
}
