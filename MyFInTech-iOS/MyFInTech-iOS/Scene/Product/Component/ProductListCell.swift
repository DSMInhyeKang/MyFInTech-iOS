//
//  ProductListCell.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/30/24.
//

import UIKit
import FlexLayout
import PinLayout

class ProductListCell: UICollectionViewCell {
    var ranking: Int {
        get { Int(rankingLabel.text ?? "0") ?? 0 }
        set { rankingLabel.text = "\(newValue)" }
    }
    var company: String {
        get { companyLabel.text ?? "" }
        set { companyLabel.text = newValue }
    }
    var name: String {
        get { nameLabel.text ?? "" }
        set { nameLabel.text = newValue }
    }
    
    private let rankingLabel: UILabel = {
        $0.font = .pretendard(.SemiBold, 18)
        $0.textColor = .gray5
        return $0
    }(UILabel())
    private let companyLabel: UILabel = {
        $0.font = .pretendard(.Bold, 18)
        $0.textColor = .gray6
        return $0
    }(UILabel())
    private let nameLabel: UILabel = {
        $0.font = .pretendard(.Regular, 16)
        $0.textColor = .gray5
        return $0
    }(UILabel())
    private let companyImageView: UIImageView = {
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
