//
//  ProductSection.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/31/24.
//

import Foundation
import RxDataSources

struct ProductSection: Equatable {
    var headers: HeaderItem
    var items: [SectionItem]
}

extension ProductSection: SectionModelType {
    init(original: ProductSection, items: [SectionItem]) {
        self = original
        self.items = items
    }
}

struct HeaderItem: Equatable {
//    var name: String
//    var detail: String
//    var target: String
    var types: [String]
}

struct SectionItem: Equatable {
    var id: Int
    var type: String
    var name: String
    var company: String
    var maxRate: String
    var defaultRate: String
    var target: String
    var isProtected: Bool
    var detail: String
    var URL: String
    var isBankingSector: Bool
}

struct Descriptions: Equatable {
    var name: String
    var detail: String
    var target: String
}
