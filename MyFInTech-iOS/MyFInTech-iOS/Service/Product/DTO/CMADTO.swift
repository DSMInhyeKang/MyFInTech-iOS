//
//  CMADTO.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/24/24.
//

import Foundation

struct CMADTO: Decodable {
    let id: Int
    let type: CMAType
    let name: String
    let company: String
    let maxRate: String
    let target: String
    let detail: String
    let interest: String
    let url: String
    let isProtected: Bool
    let isBankingSector: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, type, name, company, maxRate, target, detail, interest, url
        case isProtected = "protected"
        case isBankingSector = "bankingSector"
    }
}

extension CMADTO {
    func toDomain() -> CMAEntity {
        .init(
            id: id,
            type: type,
            name: name,
            company: company,
            maxRate: maxRate,
            target: target,
            detail: detail,
            interest: interest,
            url: url,
            isProtected: isProtected,
            isBankingSector: isBankingSector
        )
    }
}
