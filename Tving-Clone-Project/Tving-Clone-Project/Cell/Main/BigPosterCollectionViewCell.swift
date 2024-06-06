//
//  BigPosterCollectionViewCell.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 5/4/24.
//

import UIKit

import SnapKit
import Then

/// 맨 위에 제일 크게 있는 프로그램 포스터 컬렉션뷰 셀
final class BigPosterCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "BigPosterCollectionViewCell"
    
    // MARK: - Components
    
    private lazy var posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let posterTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .pretendard(weight: 700, size: 25)
    }
    
    private let posterExplainLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .pretendard(weight: 400, size: 17)
        $0.lineBreakMode = .byTruncatingTail
        $0.numberOfLines = 2
    }
    
    // MARK: - Set UI
    
    override func setLayout() {
        contentView.addSubviews(
            posterImageView,
            posterTitleLabel,
            posterExplainLabel
        )
        
        posterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-45)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        posterTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(posterImageView).offset(-70)
        }
        posterExplainLabel.snp.makeConstraints {
            $0.leading.equalTo(posterTitleLabel)
            $0.top.equalTo(posterTitleLabel.snp.bottom).offset(15)
        }
    }
}

extension BigPosterCollectionViewCell {
    
    // MARK: - Helpers
    
    /// 더미 데이터를 뷰에 연결
    func fetchData(model: Poster) {
        posterImageView.image = model.image
        posterTitleLabel.text = model.name
        posterExplainLabel.text = model.explaination
    }
}
