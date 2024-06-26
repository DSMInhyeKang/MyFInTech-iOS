//
//  String+ConvertTypeDetail.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/26/24.
//

import UIKit

extension String {
    func convertTypeDetail() -> String {
        switch self {
        case "단기 공격투자형", "장기 공격투자형":
            return """
            원금 손실 위험이 매우 높지만, 매우 높은 수익률의
            투자 방식을 원하는 유형이에요.
            """
        case "단기 적극투자형", "장기 적극투자형":
            return """
            원금 손실 위험이 있지만, 높은 수익률의
            투자 방식을 원하는 유형이에요.
            """
        case "단기 위험중립형", "장기 위험중립형":
            return """
            어느 정도 높은 수익률을 위해 원금 손실 위험을
            감수하는 방식의 투자 유형이에요.
            """
        case "단기 안정추구형", "장기 안정추구형":
            return """
            수익률이 낮더라도 원금 손실을 최소화하는
            투자 방식을 원하는 유형이에요.
            """
        case "단기 안정형", "장기 안정형":
            return """
            수익률이 아주 낮더라도 원금 손실이 없는
            투자 방식을 원하는 유형이에요.
            """
        default:
            return ""
        }
    }
}
