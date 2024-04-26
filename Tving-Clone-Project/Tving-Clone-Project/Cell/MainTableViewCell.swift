//
//  MainTableViewCell.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/27/24.
//

import UIKit

import SnapKit
import Then

final class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "서은수님이 시청하는 콘텐츠"
        $0.font = .pretendard(weight: 600, size: 15)
        $0.textColor = .white
    }
    
    private lazy var showEntireListStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 3
        
        let label = UILabel().then {
            $0.text = "전체보기"
            $0.font = .pretendard(weight: 500, size: 12)
            $0.textColor = .gray2
        }
        let button = UIButton().then {
            $0.setImage(.rightArrow, for: .normal)
        }
        button.snp.makeConstraints {
            $0.width.height.equalTo(15)
        }
        
        $0.addArrangedSubview(label)
        $0.addArrangedSubview(button)
    }
    
    private let dummyGuideView = UIView().then {
        $0.backgroundColor = .white
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .black
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [
            titleLabel,
            showEntireListStackView,
            dummyGuideView
        ].forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(15)
        }
        showEntireListStackView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(5)
        }
        dummyGuideView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.leading.equalTo(titleLabel)
            $0.width.equalTo(98)
            $0.height.equalTo(146)
        }
    }
}
