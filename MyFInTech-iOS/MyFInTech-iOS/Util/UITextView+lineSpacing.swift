//
//  UITextView+lineSpacing.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/23/24.
//

import UIKit

public extension UITextView {
// MARK: 1. Put Text  ->  2. Set Spacing  ->  3. Set Font
// This Function must be written at the second.
    func setLineAndLetterSpacing(
        _ lineSpacing: CGFloat,
        _ letterSpacing: CGFloat,
        _ color: UIColor,
        _ font: UIFont,
        _ alignment: NSTextAlignment
    ) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        
        let attributedString = NSMutableAttributedString(string: self.text)
        attributedString.addAttribute(
            NSAttributedString.Key.kern,
            value: letterSpacing,
            range: NSRange(location: 0, length: attributedString.length)
        )
        attributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: style,
            range: NSRange(location: 0, length: attributedString.length)
        )
        
        self.attributedText = attributedString
        self.textColor = color
        self.font = font
        self.textAlignment = alignment
    }
    
    func setLineHeight(
        _ lineHeight: CGFloat,
        _ color: UIColor,
        _ font: UIFont,
        _ alignment: NSTextAlignment
    ) {
        let attributedString = NSMutableAttributedString(string: self.text)
        
        attributedString.addAttribute(
            NSAttributedString.Key.baselineOffset,
            value: lineHeight,
            range: NSRange(location: 0, length: attributedString.length)
        )
        
        self.attributedText = attributedString
        self.textColor = color
        self.font = font
        self.textAlignment = alignment
    }
}
