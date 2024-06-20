//
//  SavingsDTO.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/20/24.
//

import Foundation

struct SavingsDTO: Decodable {
    let id: Int
    let type: SavingsType
    let name: String
    let company: String
    let maxRate: String
    let defaultRate: String
    let target: String
    let isProtected: Bool
    let detail: String
    let interest: String
    let url: String
    let isBankingSector: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, type, name, company, maxRate, defaultRate, target, detail, interest, url
        case isProtected = "protected"
        case isBankingSector = "bankingSector"
    }
}

extension SavingsDTO {
    func toDomain() -> SavingsEntity {
        .init(
            id: 10000,
            type: .REGULAR,
            name: "",
            company: "",
            maxRate: "",
            defaultRate: "",
            target: "",
            isProtected: true,
            detail: "",
            interest: "",
            url: "",
            isBankingSector: true
        )
    }
}
