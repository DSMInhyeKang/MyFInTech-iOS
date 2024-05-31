//
//  ProductListCell.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 5/30/24.
//

import UIKit
import FlexLayout
import PinLayout

class ProductCell: UICollectionViewCell {
    var ranking: Int {
        get { Int(rankingLabel.text ?? "0") ?? 0 }
        set { rankingLabel.text = "\(newValue)" }
    }
    var company: String {
        get { companyLabel.text ?? "" }
        set { 
            companyLabel.text = newValue
            companyImageView.image = newValue.convertCopany()
        }
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
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.flex.direction(.row)
            .define {
                $0.addItem(rankingLabel)
                $0.addItem(companyLabel)
                $0.addItem(nameLabel)
                $0.addItem(companyImageView)
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flex.layout()
        
        rankingLabel.pin
            .width(24)
            .left(24)
            .vCenter()
        companyLabel.pin
            .top(28)
            .left(24)
        nameLabel.pin
            .below(of: companyLabel)
            .marginTop(4)
            .bottom(28)
        companyImageView.pin
            .width(48)
            .height(48)
            .right(30)
            .vCenter()
    }
}
