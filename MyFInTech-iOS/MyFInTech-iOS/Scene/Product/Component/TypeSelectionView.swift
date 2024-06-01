//
//  TypeSelectionView.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import FlexLayout
import PinLayout

class TypeSelectionView: UICollectionReusableView {
    var types: [String] = []
    var selected =  BehaviorRelay<Int>(value: 0)
    let disposeBag = DisposeBag()
    
    private lazy var segmentControl: UISegmentedControl = {
        $0.setTitleTextAttributes(
            [
                .foregroundColor: UIColor.gray4,
                .font: UIFont.pretendard(.Medium, 18)
            ],
            for: .normal
        )
        $0.setTitleTextAttributes(
            [
                .foregroundColor: UIColor.segment,
                .font: UIFont.pretendard(.Medium, 18)
            ],
            for: .selected
        )
        $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        $0.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        $0.setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default)
        $0.setDividerImage(
            UIImage(),
            forLeftSegmentState: .selected,
            rightSegmentState: .normal,
            barMetrics: .default
        )
        $0.apportionsSegmentWidthsByContent = true
        return $0
    }(UISegmentedControl())
    
    init() {
        super.init(frame: .zero)
        
        self.flex
            .direction(.row)
            .justifyContent(.center)
            .define {
                $0.addItem(segmentControl)
            }
        
        self.types.enumerated().forEach {
            self.segmentControl.insertSegment(withTitle: $1, at: $0, animated: true)
        }

        segmentControl.rx.selectedSegmentIndex
            .bind(to: self.selected)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flex.layout()
        
        segmentControl.pin.all()
    }
}
