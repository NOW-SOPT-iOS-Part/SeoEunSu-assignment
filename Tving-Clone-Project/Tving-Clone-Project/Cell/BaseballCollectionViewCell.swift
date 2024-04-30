//
//  BaseballCollectionViewCell.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/29/24.
//

import UIKit

import SnapKit

/// 야구 슬로건 컬렉션뷰 셀
final class BaseballCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "BaseballCollectionViewCell"
    
    // MARK: - Components
    
    private let baseballImageView = UIImageView().then {
        $0.image = .bearsSloganBlack
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
        contentView.addSubview(baseballImageView)
        
        baseballImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
