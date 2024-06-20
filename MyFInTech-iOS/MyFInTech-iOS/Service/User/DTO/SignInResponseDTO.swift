//
//  SignInResponseDTO.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/24/24.
//

import Foundation

struct SignInResponseDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken, refreshToken
    }
}
