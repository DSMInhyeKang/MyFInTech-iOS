//
//  SavingDetailViewController
//  MyFInTech-iOS
//
//  Created by 강인혜 on 6/25/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SavingDetailViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var saving = SavingsEntity(id: 0, type: .FREE, name: "", company: "", maxRate: "", defaultRate: "", target: "", detail: "", interest: "", url: "", isProtected: true, isBankingSector: true)
    
    private let contentView: UIView = {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        return $0
    }(UIView())
    private let xButton: UIButton = {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .gray8
        return $0
    }(UIButton(type: .system))
    private let linkButton: UIButton = {
        $0.setTitle("공식홈", for: .normal)
        $0.titleLabel?.font = .pretendard(.Medium, 16)
        return $0
    }(UIButton(type: .system))
    private let protectionImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = .예금자보호
        return $0
    }(UIImageView())
    private let nameLabel: UILabel = {
        $0.font = .pretendard(.Bold, 28)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .black
        return $0
    }(UILabel())
    private let companyImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "circle.fill")
        return $0
    }(UIImageView())
    private let companyLabel: UILabel = {
        $0.font = .pretendard(.Medium, 18)
        $0.numberOfLines = 0
        $0.textColor = .black
        return $0
    }(UILabel())
    private let maxLabel: UILabel = {
        $0.text = "최고"
        $0.backgroundColor = .blur
        $0.textColor = .title
        $0.font = .pretendard(.SemiBold, 14)
        $0.textAlignment = .center
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        return $0
    }(UILabel())
    private let maxRateLabel: UILabel = {
        $0.font = .pretendard(.SemiBold, 16)
        $0.textColor = .black
        return $0
    }(UILabel())
    private let defaultLabel: UILabel = {
        $0.text = "기본"
        $0.backgroundColor = .blur
        $0.textColor = .title
        $0.font = .pretendard(.SemiBold, 14)
        $0.textAlignment = .center
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        return $0
    }(UILabel())
    private let defaultRateLabel: UILabel = {
        $0.font = .pretendard(.SemiBold, 16)
        $0.textColor = .black
        return $0
    }(UILabel())
    private let scrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        return $0
    }(UIScrollView())
    private let backView: UIView = {
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    private let detailTextView: UITextView = {
        $0.font = .pretendard(.Regular, 16)
        $0.textColor = .gray7
        $0.isEditable = false
        $0.isSelectable = false
        $0.isScrollEnabled = false
        return $0
    }(UITextView())
    private let targetLabel: UILabel = {
        $0.text = "가입 대상"
        $0.font = .pretendard(.SemiBold, 16)
        $0.numberOfLines = 0
        $0.textColor = .black
        return $0
    }(UILabel())
    private let targetTextView: UITextView = {
        $0.font = .pretendard(.Regular, 16)
        $0.textColor = .gray7
        $0.isEditable = false
        $0.isSelectable = false
        $0.isScrollEnabled = false
        return $0
    }(UITextView())
    private let interestLabel: UILabel = {
        $0.text = "이자"
        $0.font = .pretendard(.SemiBold, 16)
        $0.numberOfLines = 0
        $0.textColor = .black
        return $0
    }(UILabel())
    private let interestTextView: UITextView = {
        $0.font = .pretendard(.Regular, 16)
        $0.textColor = .gray7
        $0.isEditable = false
        $0.isSelectable = false
        $0.isScrollEnabled = false
        return $0
    }(UITextView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        view.backgroundColor = .black.withAlphaComponent(0.2)
        
        view.addSubview(contentView)
        [
            xButton,
            linkButton,
            protectionImageView,
            nameLabel,
            companyImageView,
            companyLabel,
            maxRateLabel,
            maxLabel,
            defaultLabel,
            defaultRateLabel,
            scrollView
        ].forEach { contentView.addSubview($0) }
        scrollView.addSubview(backView)
        [
            detailTextView,
            targetLabel,
            targetTextView,
            interestLabel,
            interestTextView
        ].forEach { backView.addSubview($0)}
        
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(72)
            $0.bottom.equalToSuperview().inset(62)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        xButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalToSuperview().inset(18)
            $0.width.height.equalTo(20)
        }
        linkButton.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(18)
        }
        protectionImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(44)
            $0.height.equalTo(29)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(protectionImageView.snp.bottom).offset(7)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
        companyImageView.snp.makeConstraints {
            $0.width.height.equalTo(130)
            $0.top.equalTo(nameLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        companyLabel.snp.makeConstraints {
            $0.top.equalTo(companyImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        maxRateLabel.snp.makeConstraints {
            $0.top.equalTo(companyLabel.snp.bottom).offset(32)
            $0.height.equalTo(19)
            $0.right.equalTo(contentView.snp.centerX).offset(-12)
        }
        maxLabel.snp.makeConstraints {
            $0.width.equalTo(41)
            $0.height.equalTo(24)
            $0.centerY.equalTo(maxRateLabel.snp.centerY)
            $0.right.equalTo(maxRateLabel.snp.left).offset(-10)
        }
        defaultLabel.snp.makeConstraints {
            $0.centerY.equalTo(maxRateLabel.snp.centerY)
            $0.width.equalTo(41)
            $0.height.equalTo(24)
            $0.left.equalTo(contentView.snp.centerX).offset(12)
        }
        defaultRateLabel.snp.makeConstraints {
            $0.centerY.equalTo(defaultLabel.snp.centerY)
            $0.left.equalTo(defaultLabel.snp.right).offset(10)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(defaultRateLabel.snp.bottom).offset(40)
            $0.bottom.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        backView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        detailTextView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        targetLabel.snp.makeConstraints {
            $0.top.equalTo(detailTextView.snp.bottom).offset(20)
            $0.left.equalToSuperview()
        }
        targetTextView.snp.makeConstraints {
            $0.top.equalTo(targetLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
        }
        interestLabel.snp.makeConstraints {
            $0.top.equalTo(targetTextView.snp.bottom).offset(20)
            $0.left.equalToSuperview()
        }
        interestTextView.snp.makeConstraints {
            $0.top.equalTo(interestLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func bind() {
        xButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: false)
            }).disposed(by: disposeBag)
        linkButton.rx.tap
            .subscribe(onNext: {
                if let url = URL(string: self.saving.url) { UIApplication.shared.open(url, options: [:]) }
            }).disposed(by: disposeBag)
        nameLabel.text = saving.name
        protectionImageView.isHidden = saving.isProtected ? false : true
        companyImageView.image = saving.company.convertCompany()
        companyLabel.text = saving.company
        maxRateLabel.text = saving.maxRate
        defaultRateLabel.text = saving.defaultRate
        detailTextView.text = saving.detail
        targetTextView.text = saving.target
        interestTextView.text = saving.interest
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
