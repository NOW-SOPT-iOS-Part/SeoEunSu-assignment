//
//  BaseballCollectionViewCell.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/29/24.
//

import UIKit

import SnapKit
import Then

/// 야구 슬로건 컬렉션뷰 셀
final class BaseballCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "BaseballCollectionViewCell"
    
    // MARK: - Components
    
    private let baseballImageView = UIImageView()
    
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
        contentView.addSubviews(baseballImageView)
        baseballImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// 더미 데이터를 뷰에 연결
    func fetchData(model: BaseballSlogan) {
        baseballImageView.image = model.image
    }
}
