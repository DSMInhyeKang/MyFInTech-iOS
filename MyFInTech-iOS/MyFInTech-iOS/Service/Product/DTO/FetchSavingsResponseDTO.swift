//
//  SavingsResponse.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/20/24.
//

import Foundation

struct FetchSavingsResponseDTO: Decodable {
    let regular: [SavingsDTO]
    let free: [SavingsDTO]
    let youth: [SavingsDTO]
    let soldier: [SavingsDTO]
}

extension FetchSavingsResponseDTO {
    func toDomain() -> [[SavingsEntity]] {
        [
            regular.map { $0.toDomain() },
            free.map { $0.toDomain() },
            youth.map { $0.toDomain() },
            soldier.map { $0.toDomain() }
        ]
    }
}
