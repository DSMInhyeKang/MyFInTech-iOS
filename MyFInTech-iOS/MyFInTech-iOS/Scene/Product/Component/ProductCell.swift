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
        $0.textColor = .gray6
        $0.textAlignment = .center
        return $0
    }(UILabel())
    private let companyLabel: UILabel = {
        $0.font = .pretendard(.SemiBold, 18)
        $0.textColor = .gray8
        return $0
    }(UILabel())
    private let nameLabel: UILabel = {
        $0.font = .pretendard(.Regular, 16)
        $0.textColor = .gray6
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    private let companyImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.flex.direction(.row)
            .alignItems(.start)
            .define {
                $0.addItem(rankingLabel)
                    .width(24)
                    .marginHorizontal(24)
                $0.addItem()
                    .justifyContent(.start)
                    .define { (sub) in
                        sub.addItem(companyLabel)
                        sub.addItem(nameLabel)
                    }
                $0.addItem(companyImageView)
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flex.layout()
        
//        self.pin.height(100)
        
        rankingLabel.pin
            .vCenter()
        companyLabel.pin
            .top(28)
        nameLabel.pin
            .below(of: companyLabel)
            .marginTop(4)
            .marginBottom(28)
        companyImageView.pin
            .width(48)
            .height(48)
            .right(30)
            .vCenter()
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ProductCell_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            UIViewPreview {
                let cell = ProductCell()
                cell.ranking = 1
                cell.company = "SC제일은행"
                cell.name = "2024 신한 프로야구 적금"
                return cell
            }
            UIViewPreview {
                let cell = ProductCell()
                cell.ranking = 30
                cell.company = "KDB산업은행"
                cell.name = "온국민 건강적금"
                return cell
            }
            UIViewPreview {
                let cell = ProductCell()
                cell.ranking = 30
                cell.company = "토스뱅크"
                cell.name = "온국민 건강적금"
                return cell
            }
        }
        .frame(height: 300)
    }
}
#endif
