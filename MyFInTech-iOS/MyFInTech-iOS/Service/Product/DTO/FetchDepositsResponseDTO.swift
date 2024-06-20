//
//  DepositsResponseDTO.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/20/24.
//

import Foundation

struct FetchDepositsResponseDTO: Decodable {
    let regular: [DepositDTO]
    let parking: [DepositDTO]
    let mmda: [DepositDTO]
}

extension FetchDepositsResponseDTO {
    func toDomain() -> [[DepositEntity]] {
        [
            regular.map { $0.toDomain() },
            parking.map { $0.toDomain() },
            mmda.map { $0.toDomain() }
        ]
    }
}
