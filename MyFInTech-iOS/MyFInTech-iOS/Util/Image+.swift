//
//  Image+.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/30/24.
//

import UIKit

extension String {
    func convertCompany() -> UIImage {
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
        case "iM뱅크":
            return .iM뱅크
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
        case "예금", "정기예금", "MMDA":
            return .예금
        case "적금", "정기적금", "자유적금":
            return .적금
        case "랩(WRAP)":
            return .랩
        case "금":
            return .금
        case "외환":
            return .외환
        case "파킹통장":
            return .파킹통장
        case "군인적금\n/장병 내일준비적금":
            return .군인적금
        case "청년적금/청년도약계좌":
            return .청년적금
        case "CMA":
            return .CMA
        case "RP형 CMA", "MMF형 CMA", "MMW형 CMA":
            return .CMA_RP_MMF_MMW
        case "암호화폐":
            return .암호화폐
        case "주식/ETF":
            return .주식
        case "ISA":
            return .ISA
        default:
            return UIImage(systemName: "square.fill") ?? .init()
        }
    }
    
    func convertType() -> UIImage {
        switch self {
        case "단기 공격투자형", "장기 공격투자형":
            return .object4
        case "단기 적극투자형", "장기 적극투자형":
            return .object2
        case "단기 위험중립형", "장기 위험중립형":
            return .object1
        case "단기 안정추구형", "장기 안정추구형":
            return .object5
        case "단기 안정형", "장기 안정형":
            return .object3
        default:
            return UIImage(systemName: "square.fill") ?? .init()
        }
    }
}
