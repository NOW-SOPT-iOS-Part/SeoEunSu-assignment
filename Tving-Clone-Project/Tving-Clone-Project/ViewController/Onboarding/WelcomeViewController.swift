//
//  WelcomeViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/16/24.
//

import UIKit

import SnapKit
import Then

final class WelcomeViewController: BaseViewController<WelcomeViewModel> {
    
    // MARK: - Properties
    
    var id: String = ""
    var nickname: String = ""
    
    // MARK: - Components
    
    private let tvingImageView = UIImageView().then {
        $0.image = .tvingTitleRed
    }
    
    private lazy var welcomeLabel = UILabel().then {
        // 행간 (피그마의 lineheight 값) 설정
        let style = NSMutableParagraphStyle()
        let lineheight = 37.0
        style.minimumLineHeight = lineheight
        $0.attributedText = NSAttributedString(
            string: nickname + StringLiteral.welcomeLabelStr,
            attributes: [
                .paragraphStyle: style
            ])
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = .pretendard(weight: 700, size: 23)
        $0.textColor = .grayD6
    }
    
    private lazy var toMainButton = UIButton().then {
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 3
        $0.setAttributedTitle(
            NSAttributedString(
                string: StringLiteral.toMainButtonStr,
                attributes: [
                    .font : UIFont.pretendard(weight: 600, size: 14),
                    .foregroundColor : UIColor.white
                ]
            ),
            for: .normal
        )
        $0.addTarget(self, action: #selector(toMainButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Set UI
    
    override func addSubview() {
        self.view.addSubviews(
            tvingImageView,
            welcomeLabel,
            toMainButton
        )
    }
    
    override func setLayout() {
        tvingImageView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().inset(58)
            $0.height.equalTo(211)
        }
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(tvingImageView.snp.bottom).offset(67)
            $0.centerX.equalToSuperview()
        }
        toMainButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(66)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: - Actions
    
    /// 메인으로 버튼 클릭 시 호출되는 함수
    @objc private func toMainButtonDidTap(_ sender: UIButton) {
        let tabBarVC = TabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.modalTransitionStyle = .crossDissolve
        self.present(tabBarVC, animated: true)
    }
}
