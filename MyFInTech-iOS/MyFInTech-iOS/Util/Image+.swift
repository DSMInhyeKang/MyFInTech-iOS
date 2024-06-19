//
//  Image+.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/30/24.
//

import UIKit

extension String {
    func convertCopany() -> UIImage {
        switch self {
        case "광주은행", "전북은행":
            return .광주은행
        case "수협은행":
            return .수협은행
        case "신한은행", "제주은행":
            return .신한은행
        case "우리은행":
            return .우리은행
        case "카카오뱅크":
            return .카카오뱅크
        case "케이뱅크":
            return .케이뱅크
        case "토스뱅크":
            return .토스뱅크
        case "하나은행":
            return .하나은행
        case "경남은행", "부산은행":
            return .BNK
        case "IBK기업은행":
            return .ibk기업은행
        case "KB국민은행":
            return .kb국민은행
        case "KDB산업은행":
            return .kdb산업은행
        case "NH농협은행":
            return .nh농협은행
        case "SC제일은행":
            return .sc제일은행
        default:
            return UIImage(systemName: "circle.fill") ?? .init()
        }
    }

    func convertProduct() -> UIImage {
        switch self {
        case "예금":
            return .예금
        case "적금":
            return .적금
        case "랩(WRAP)":
            return .랩
        case "금":
            return .금
        case "외환":
            return .외환
        default:
            return UIImage(systemName: "square.fill") ?? .init()
        }
    }
}
