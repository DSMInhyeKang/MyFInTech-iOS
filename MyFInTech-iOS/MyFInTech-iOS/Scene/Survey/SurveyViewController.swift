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
    var surveyAnswers = PublishRelay<[Bool]>()
    let viewModel = SurveyViewModel()
    
    private let flexContainer = UIView()
    private let questionLabel: UILabel = {
        $0.text = "정기적으로\n금액을 불입할\n의향이 있다."
        $0.textColor = .black
        $0.font = .pretendard(.Bold, 32)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
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
                $0.addItem(yesButton).cornerRadius(8)
                $0.addItem(noButton).cornerRadius(8)
            }
    }
    
    override func viewDidLayoutSubviews() {
        flexContainer.pin.all()
        yesButton.flex.layout(mode: .adjustHeight)
        noButton.flex.layout(mode: .adjustHeight)
        
        questionLabel.pin.top(134)
            .horizontally(24)
        noButton.pin.bottom(62).horizontally(28).height(56)
        yesButton.pin
            .above(of: noButton, aligned: .center)
            .width(of: noButton)
            .height(of: noButton)
            .marginBottom(12)
        questionLabel.flex.layout(mode: .adjustHeight)
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
                if cnt < 4 {
                    owner.questionLabel.text = owner.viewModel.surveyQuestions[cnt]
                    owner.yesButton.setTitle(owner.viewModel.surveyOptions[cnt][0], for: .normal)
                    owner.noButton.setTitle(owner.viewModel.surveyOptions[cnt][1], for: .normal)
                } else { 
                    let input = SurveyViewModel.Input()
                    let output = owner.viewModel.transform(input: input)
                    
                    let home = HomeViewController()
                    self.navigationController?.pushViewController(home, animated: true)
                }
            }).disposed(by: disposeBag)
        surveyAnswers
            .withUnretained(self)
            .subscribe(onNext: { print($0.1) })
            .disposed(by: disposeBag)
    }
}
