//
//  DepositEntity.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/24/24.
//

import Foundation

struct DepositEntity: Equatable, Hashable {
    let id: Int
    let type: DepositType
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
    
    init(
        id: Int,
        type: DepositType,
        name: String,
        company: String,
        maxRate: String,
        defaultRate: String,
        target: String,
        isProtected: Bool,
        detail: String,
        interest: String,
        url: String,
        isBankingSector: Bool
    ) {
        self.id = id
        self.type = type
        self.name = name
        self.company = company
        self.maxRate = maxRate
        self.defaultRate = defaultRate
        self.target = target
        self.isProtected = isProtected
        self.detail = detail
        self.interest = interest
        self.url = url
        self.isBankingSector = isBankingSector
    }
}
