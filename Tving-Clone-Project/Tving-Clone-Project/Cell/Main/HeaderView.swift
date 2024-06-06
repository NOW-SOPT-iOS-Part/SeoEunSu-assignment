//
//  HeaderView.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/30/24.
//

import UIKit

import SnapKit
import Then

final class HeaderView: UICollectionReusableView {
    
    // MARK: - Components
    
    private let titleLabel = UILabel().then {
        $0.text = ""
        $0.font = .pretendard(weight: 600, size: 15)
        $0.textColor = .white
    }
    
    private let fullViewLabel = UILabel().then {
        $0.text = "전체보기"
        $0.font = .pretendard(weight: 500, size: 11)
        $0.textColor = .gray9C
    }
    
    private let fullViewButton = UIButton().then {
        $0.setImage(.init(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .gray9C
    }
    
    private lazy var fullViewStackView = UIStackView(arrangedSubviews: [fullViewLabel, fullViewButton]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 0
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderView {
    
    // MARK: - Set UI
    
    private func setLayout() {
        addSubviews(
            titleLabel,
            fullViewStackView
        )
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        fullViewButton.snp.makeConstraints {
            $0.size.equalTo(10)
        }
        fullViewStackView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Helpers
    
    /// 더미 데이터를 뷰에 연결
    func fetchData(_ data: String) {
        titleLabel.text = data
    }
}
