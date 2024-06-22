//
//  DepositsDTO.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/20/24.
//

import Foundation

struct DepositDTO: Decodable {
    let id: Int
    let type: DepositType
    let name: String
    let company: String
    let maxRate: String
    let defaultRate: String
    let target: String
    let detail: String
    let interest: String
    let url: String
    let isProtected: Bool
    let isBankingSector: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, type, name, company, maxRate, defaultRate, target, detail, interest, url
        case isProtected = "protected"
        case isBankingSector = "bankingSector"
    }
}

extension DepositDTO {
    func toDomain() -> DepositEntity {
        .init(
            id: id,
            type: type,
            name: name,
            company: company,
            maxRate: maxRate,
            defaultRate: defaultRate,
            target: target,
            detail: detail,
            interest: interest,
            url: url,
            isProtected: isProtected,
            isBankingSector: isBankingSector
        )
    }
}
