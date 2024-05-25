//
//  UIFont+Pretendard.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/23/24.
//

import UIKit

extension UIFont {
    enum Scale: String {
        case Black, ExtraBold, Bold, SemiBold, Medium, Regular, Light, ExtraLight, Thin
    }
    
    static func pretendard(_ scale: Scale, _ size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-\(scale)", size: size) ?? .init()
    }
}
