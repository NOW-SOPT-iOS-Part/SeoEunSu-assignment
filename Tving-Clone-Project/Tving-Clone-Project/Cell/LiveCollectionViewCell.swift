//
//  LiveCollectionViewCell.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/29/24.
//

import UIKit

import SnapKit

/// 티빙 라이브 프로그램 컬렉션뷰 셀
final class LiveCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let ranking: Int = 1
    static let identifier = "LiveCollectionViewCell"
    
    // MARK: - Components
    
    private let liveImageView = UIImageView().then {
        $0.image = .queenOfTearLive
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
    }
    private lazy var rankingLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString(string: "\(ranking)", attributes: [
            .font : UIFont.pretendard(weight: 700, size: 19),
            .foregroundColor : UIColor.white,
            .obliqueness : 0.3
        ])
    }
    private lazy var channelLabel = UILabel().then {
        $0.text = "Mnet"
        $0.textColor = .white
        $0.font = .pretendard(weight: 400, size: 10)
    }
    private lazy var titleLabel = UILabel().then {
        $0.text = "눈물의 여왕 16화"
        $0.textColor = .gray9C
        $0.font = .pretendard(weight: 400, size: 10)
    }
    private lazy var viewingRatingLabel = UILabel().then {
        $0.text = "80.0%"
        $0.textColor = .gray9C
        $0.font = .pretendard(weight: 400, size: 10)
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
            liveImageView,
            rankingLabel,
            channelLabel,
            titleLabel,
            viewingRatingLabel
        )
        
        liveImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        rankingLabel.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.top.equalTo(liveImageView.snp.bottom).offset(8)
            $0.leading.equalTo(liveImageView).offset(6)
        }
        channelLabel.snp.makeConstraints {
            $0.top.equalTo(rankingLabel).offset(2)
            $0.leading.equalTo(rankingLabel.snp.trailing).offset(3)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(channelLabel.snp.bottom).offset(4)
            $0.leading.equalTo(channelLabel)
        }
        viewingRatingLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(channelLabel)
        }
    }
    
    /// 더미 데이터를 뷰에 연결
    func fetchData(model: LiveProgram) {
        liveImageView.image = model.image
        titleLabel.text = model.title
        rankingLabel.text = model.ranking
        channelLabel.text = model.channel
        viewingRatingLabel.text = model.viewingRating + "%"
    }
}
