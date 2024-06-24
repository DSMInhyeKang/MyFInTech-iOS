//
//  FetchCMAsReponseDTO.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/24/24.
//

import Foundation

struct FetchCMAsReponseDTO: Decodable {
    let cp: [CMADTO]
    let rp: [CMADTO]
    let mmf: [CMADTO]
    let mmw: [CMADTO]
}

extension FetchCMAsReponseDTO {
    func toDomain() -> [[CMAEntity]] {
        [
            cp.map { $0.toDomain() },
            rp.map { $0.toDomain() },
            mmf.map { $0.toDomain() },
            mmw.map { $0.toDomain() }
        ]
    }
}
