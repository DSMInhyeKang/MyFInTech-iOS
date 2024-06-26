//
//  SurveyViewController.swift
//  MyFInTech-iOS
//
//  Created by 강인혜 on 4/18/24.
//

import UIKit
import FlexLayout
import PinLayout
import ReactorKit
import RxCocoa

class SurveyViewController: UIViewController, View {
    typealias Reactor = SurveyReactor
    var disposeBag = DisposeBag()
    var surveyAnswers = BehaviorRelay<[Bool]>(value: [])
    let viewModel = SurveyViewModel()
    
    private let flexContainer = UIView()
    private let questionLabel: UILabel = {
        $0.text = "정기적으로\n금액을 불입할\n의향이 있다."
        $0.textColor = .black
        $0.font = .pretendard(.Bold, 32)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    private let menuButton: UIButton = {
        $0.setTitle("투자 성향을 선택해주세요.", for: .normal)
        $0.setTitleColor(.primary, for: .normal)
        $0.titleLabel?.font = .pretendard(.SemiBold, 18)
        $0.backgroundColor = .blur
        $0.showsMenuAsPrimaryAction = true
        return $0
    }(UIButton(type: .system))
    private let yesButton: UIButton = {
        $0.setTitle("예", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .pretendard(.SemiBold, 18)
        $0.backgroundColor = .title
        return $0
    }(UIButton(type: .system))
    private let noButton: UIButton = {
        $0.setTitle("아니오", for: .normal)
        $0.setTitleColor(.title, for: .normal)
        $0.titleLabel?.font = .pretendard(.SemiBold, 18)
        $0.backgroundColor = .background
        return $0
    }(UIButton(type: .system))

    convenience init(reactor: SurveyReactor) {
        self.init()
        self.reactor = reactor
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(flexContainer)
        
        flexContainer.flex
            .direction(.column)
            .alignItems(.start)
            .define {
                $0.addItem(questionLabel)
                $0.addItem(menuButton).cornerRadius(8)
                $0.addItem(yesButton).cornerRadius(8)
                $0.addItem(noButton).cornerRadius(8)
            }
        
        let menuTapped = { (action: UIAction) in
            self.menuButton.setTitle(action.title, for: .normal)
            let idx = action.title.firstIndex(of: "(") ?? action.title.endIndex
            self.viewModel.type = String(action.title[..<idx])
        }
        self.menuButton.menu = UIMenu(children: [
            UIAction(title: "공격투자형(매우 높은 수익률 추구, 매우 위험)", handler: menuTapped),
            UIAction(title: "적극투자형(높은 수익률 추구, 위험)", handler: menuTapped),
            UIAction(title: "위험중립형(중간 수준 수익률 추구, 다소 위험)", handler: menuTapped),
            UIAction(title: "안정추구형(낮은 수익률, 원금 손실 최소화)", handler: menuTapped),
            UIAction(title: "안정형(매우 낮은 수익률, 원금 보장)", handler: menuTapped)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        flexContainer.pin.all()
        yesButton.flex.layout(mode: .adjustHeight)
        noButton.flex.layout(mode: .adjustHeight)
        
        questionLabel.pin.top(134)
            .horizontally(24)
        questionLabel.flex.layout(mode: .adjustHeight)
        menuButton.pin
            .below(of: questionLabel)
            .marginTop(150)
            .height(56)
            .horizontally(28)
        noButton.pin.bottom(62).horizontally(28).height(56)
        yesButton.pin
            .above(of: noButton, aligned: .center)
            .width(of: noButton)
            .height(of: noButton)
            .marginBottom(12)
    }
    
    func bind(reactor: SurveyReactor) {
        yesButton.rx.tap
            .map { Reactor.Action.isAnswerYes }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        noButton.rx.tap
            .map { Reactor.Action.isAnswerNo }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.answers }
            .distinctUntilChanged()
            .bind(to: surveyAnswers)
            .disposed(by: disposeBag)
        reactor.state.map { $0.cnt }
            .subscribe(with: self, onNext: { owner, cnt in
                if cnt == 0 {
                    owner.questionLabel.text = owner.viewModel.surveyQuestions[cnt]
                    owner.yesButton.isHidden = true
                    owner.noButton.setTitle("다음", for: .normal)
                } else if 0 < cnt && cnt < 4 {
                    owner.menuButton.isHidden = true
                    owner.yesButton.isHidden = false
                    owner.questionLabel.text = owner.viewModel.surveyQuestions[cnt]
                    owner.yesButton.setTitle(owner.viewModel.surveyOptions[cnt][0], for: .normal)
                    owner.noButton.setTitle(owner.viewModel.surveyOptions[cnt][1], for: .normal)
                } else {
                    let result = SurveyResultController()
                    result.productsDetail = owner.viewModel.investType(answers: owner.surveyAnswers.value)
                    result.type = owner.viewModel.type
                    print(result.type)
                    print(result.productsDetail)
                    owner.navigationController?.pushViewController(result, animated: true)
                }
            }).disposed(by: disposeBag)
        surveyAnswers
            .withUnretained(self)
            .subscribe(onNext: { print($0.1) })
            .disposed(by: disposeBag)
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
