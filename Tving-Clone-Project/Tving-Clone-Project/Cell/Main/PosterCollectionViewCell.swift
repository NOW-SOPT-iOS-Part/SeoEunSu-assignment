//
//  PosterCollectionViewCell.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/29/24.
//

import UIKit

import SnapKit
import Then

/// 프로그램 포스터 컬렉션뷰 셀
final class PosterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "PosterCollectionViewCell"
    
    // MARK: - Components
    
    private let posterImageView = UIImageView().then {
        $0.layer.cornerRadius = 3
    }
    private lazy var posterTitleLabel = UILabel().then {
        $0.textColor = .gray9C
        $0.font = .pretendard(weight: 500, size: 10)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func setLayout() {
        contentView.addSubviews(
            posterImageView,
            posterTitleLabel
        )
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(146)
        }
        posterTitleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(3)
            $0.leading.equalToSuperview()
        }
    }
    
    /// 더미 데이터를 뷰에 연결
    func fetchData(model: Poster) {
        posterTitleLabel.text = model.name
        posterImageView.image = model.image
    }
}
