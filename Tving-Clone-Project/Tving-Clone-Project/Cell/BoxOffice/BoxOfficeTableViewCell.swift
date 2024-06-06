//
//  BoxOfficeTableViewCell.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 5/10/24.
//

import UIKit

import SnapKit
import Then

final class BoxOfficeTableViewCell: BaseTableViewCell {
    
    // MARK: - Components
    
    private let rankLabel = UILabel().then {
        $0.text = "1"
        $0.font = .pretendard(weight: 700, size: 18)
        $0.textColor = .white
    }
    
    private let movieTitleLabel = UILabel().then {
        $0.text = "범죄도시4"
        $0.font = .pretendard(weight: 500, size: 15)
        $0.textColor = .white
    }
    
    private let openDateLabel = UILabel().then {
        $0.text = "개봉일: 2024-04-24"
        $0.font = .pretendard(weight: 400, size: 15)
        $0.textColor = .white
    }
    
    // MARK: - Set UI
    
    override func setLayout() {
        contentView.addSubviews(
            rankLabel,
            movieTitleLabel,
            openDateLabel
        )
        
        rankLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        movieTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(rankLabel)
            $0.leading.equalTo(rankLabel.snp.trailing).offset(10)
        }
        openDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(movieTitleLabel)
            $0.leading.equalTo(movieTitleLabel.snp.trailing).offset(10)
        }
    }
}

extension BoxOfficeTableViewCell {
    
    // MARK: - Helpers
    
    func dataBind(_ boxOfficeData: DailyBoxOffice) {
        rankLabel.text = boxOfficeData.rank
        movieTitleLabel.text = boxOfficeData.movieNm
        openDateLabel.text = boxOfficeData.openDt
    }
}
