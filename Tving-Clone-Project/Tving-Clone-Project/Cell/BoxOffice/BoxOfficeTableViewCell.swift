//
//  BoxOfficeTableViewCell.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 5/10/24.
//

import UIKit

import SnapKit
import Then

final class BoxOfficeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = NSObject.className
    
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
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func setLayout() {
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

// MARK: - Extension

extension BoxOfficeTableViewCell {
    func dataBind(_ boxOfficeData: DailyBoxOffice) {
        rankLabel.text = boxOfficeData.rank
        movieTitleLabel.text = boxOfficeData.movieNm
        openDateLabel.text = boxOfficeData.openDt
    }
}
