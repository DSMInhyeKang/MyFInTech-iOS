//
//  ProductType.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/24/24.
//

import Foundation

enum ProductType {
    case deposit
    case savings
}

enum DepositType: String {
    case REGULAR = "정기 예금"
    case CMA = "CMA"
    case PARKING = "파킹통장"
    case MMDA = "MMDA"
}

enum SavingsType: String {
    case REGULAR = "정기적금"
    case FREE = "자유적금"
    case YOUTH = "청년적금"
    case YOUNG_JUMP = "청년도약계좌"
    case HOUSING_SUBS = "주택청약통장"
    case SOLDIER = "군인적금"
}
