//
//  CMAEntity.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/21/24.
//

import Foundation

struct CMAEntity: Equatable, Hashable {
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
    
    init(
        id: Int,
        type: CMAType,
        name: String,
        company: String,
        maxRate: String,
        target: String,
        detail: String,
        interest: String,
        url: String,
        isProtected: Bool,
        isBankingSector: Bool
    ) {
        self.id = id
        self.type = type
        self.name = name
        self.company = company
        self.maxRate = maxRate
        self.target = target
        self.detail = detail
        self.interest = interest
        self.url = url
        self.isProtected = isProtected
        self.isBankingSector = isBankingSector
    }
}
