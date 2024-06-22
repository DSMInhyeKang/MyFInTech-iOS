//
//  TypeSelectionView.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TypeSelectionView: UIView {
    var types: [String] = []
    var selected =  BehaviorRelay<Int>(value: 0)
    let disposeBag = DisposeBag()
    
    private lazy var segmentControl: UISegmentedControl = {
        $0.setTitleTextAttributes(
            [
                .foregroundColor: UIColor.gray2,
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
    private let underlineView: UIView = {
        $0.backgroundColor = .gray3
        return $0
    }(UIView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        segmentControl.selectedSegmentIndex = 0
        
        [segmentControl, underlineView].forEach { self.addSubview($0) }
        
        segmentControl.rx.selectedSegmentIndex
            .distinctUntilChanged()
            .filter({ $0 >= 0 })
            .bind(to: self.selected)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        segmentControl.removeAllSegments()
        
        self.types.enumerated().forEach {
            self.segmentControl.insertSegment(withTitle: $1, at: $0, animated: true)
            segmentControl.selectedSegmentIndex = 0
        }
        
        segmentControl.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        underlineView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct TypeSelectionView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let typeSelectionView = TypeSelectionView()
            typeSelectionView.types = ["정기적금", "자유적금", "청년적금"/*, "청년도약계좌", "주택청약통장"*/, "군인적금"]
            return typeSelectionView
        }
    }
}
#endif
