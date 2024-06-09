//
//  ProductTypeCell.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/3/24.
//

import UIKit
import FlexLayout
import PinLayout

class ProductTypeCell: UICollectionViewCell {
    var type: String {
        get { typeLabel.text ?? "" }
        set {
            typeLabel.text = newValue
            typeImageView.image = newValue.convertProduct()
        }
    }
    var detail: String {
        get { detailLabel.text ?? "" }
        set { detailLabel.text = newValue }
    }
    
    private let typeImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    private let typeLabel: UILabel = {
        $0.font = .pretendard(.SemiBold, 20)
        $0.textColor = .gray8
        return $0
    }(UILabel())
    private let detailLabel: UILabel = {
        $0.font = .pretendard(.Regular, 14)
        $0.textColor = .gray5
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.flex.direction(.column)
            .define {
                $0.addItem(typeImageView)
                $0.addItem(typeLabel)
                $0.addItem(detailLabel)
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flex.layout()
        
        self.layer.borderColor = UIColor.gray1.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 14
        
        typeImageView.pin
            .width(40)
            .height(40)
            .top(24)
            .left(22)
        typeLabel.pin
            .below(of: typeImageView)
            .marginTop(12)
            .horizontally(24)
        detailLabel.pin
            .below(of: typeLabel)
            .marginTop(4)
            .horizontally(24)
            .bottom(24)
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ProductTypeCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = ProductTypeCell()
            cell.type = "랩(WRAP)"
            cell.detail = "시중은행 랩 Top 20"
            return cell
        }
        .frame(width: 168, height: 145)
    }
}
#endif
