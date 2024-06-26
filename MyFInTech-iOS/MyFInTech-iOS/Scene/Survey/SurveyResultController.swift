//
//  SurveyResultController.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 4/18/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SurveyResultController: UIViewController {
    let disposeBag = DisposeBag()
    var type: String {
        get { typeLabel.text ?? "" }
        set {
            typeLabel.text = newValue
            typeTextView.text = newValue.convertTypeDetail()
            typeImageView.image = newValue.convertType()
        }
    }
    var productsDetail: String {
        get { productTextView.text }
        set { productTextView.text = newValue }
    }
    private let flexContainer = UIView()
    private let titleLabel: UILabel = {
        $0.text = "당신의 투자 성향은"
        $0.textColor = .black
        $0.font = .pretendard(.Bold, 32)
        return $0
    }(UILabel())
    private let typeImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    private let typeLabel: UILabel = {
        $0.font = .pretendard(.Bold, 20)
        $0.textColor = .black
        return $0
    }(UILabel())
    private let typeTextView: UITextView = {
        $0.isScrollEnabled = false
        $0.setLineHeight(24, .gray8, .pretendard(.Regular, 17), .center)
        return $0
    }(UITextView())
    private let productLabel: UILabel = {
        $0.text = "추천 금융 상품"
        $0.font = .pretendard(.Bold, 20)
        $0.textColor = .black
        return $0
    }(UILabel())
    private let productTextView: UITextView = {
        $0.isScrollEnabled = false
        $0.setLineHeight(24, .gray8, .pretendard(.Regular, 17), .center)
        return $0
    }(UITextView())
    private let toHomeButton: UIButton = {
        $0.setTitle("홈 화면으로", for: .normal)
        $0.setTitleColor(.title, for: .normal)
        $0.titleLabel?.font = .pretendard(.SemiBold, 18)
        $0.backgroundColor = .background
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        return $0
    }(UIButton(type: .system))

    override func viewDidLoad() {
        view.backgroundColor = .white
        
        [
            titleLabel,
            typeImageView,
            typeLabel,
            typeTextView,
            productLabel,
            productTextView,
            toHomeButton
        ].forEach {
            view.addSubview($0)
        }
        
        toHomeButton.rx.tap
            .subscribe(onNext: {
                let home = HomeViewController()
                self.navigationController?.pushViewController(home, animated: true)
            }).disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.left.equalToSuperview().inset(24)
        }
        typeImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.width.height.equalTo(244)
            $0.centerX.equalToSuperview()
        }
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(typeImageView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        typeTextView.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(26)
        }
        productLabel.snp.makeConstraints {
            $0.top.equalTo(typeTextView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        productTextView.snp.makeConstraints {
            $0.top.equalTo(productLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(26)
        }
        toHomeButton.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(48)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}
