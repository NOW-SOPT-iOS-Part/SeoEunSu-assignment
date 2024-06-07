//
//  WelcomeView.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/7/24.
//

import UIKit

import SnapKit
import Then

class WelcomeView: BaseView {
    
    // MARK: - Properties
    
    var nickname: String
    
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
    
    let toMainButton = UIButton().then {
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
    }
    
    // MARK: - Init
    
    init(nickname: String) {
        self.nickname = nickname
        super.init(frame: CGRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    
    override func addSubview() {
        self.addSubviews(
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
}
