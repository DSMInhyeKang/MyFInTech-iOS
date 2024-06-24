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

enum DepositType: String, Decodable {
    case REGULAR  // 정기예금
    case PARKING  // 파킹통장
    case MMDA  // MMDA
}

enum SavingsType: String, Decodable {
    case REGULAR  // 정기적금
    case FREE  // 자유적금
    case YOUTH  // 청년적금
    case SOLDIER  // 군인적금
}

enum CMAType: String, Decodable {
    case CP  // 발행어음 + 종금형
    case RP  // RP형 CMA
    case MMF  // MMF형 CMA
    case MMW  // MMW형 CMA
}
