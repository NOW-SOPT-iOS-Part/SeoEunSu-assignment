//
//  BoxOfficeView.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/7/24.
//

import UIKit

import SnapKit
import Then

class BoxOfficeView: BaseView {
    
    // MARK: - Components
    
    private let titleLabel = UILabel().then {
        $0.text = StringLiteral.todayBoxOfficeRankStr
        $0.font = .pretendard(weight: 700, size: 25)
        $0.textColor = .white
    }
    
    lazy var boxOfficeTableView = UITableView().then {
        $0.backgroundColor = .black
        $0.register(
            BoxOfficeTableViewCell.self,
            forCellReuseIdentifier: BoxOfficeTableViewCell.className
        )
    }
    
    // MARK: - Set UI
    
    override func addSubview() {
        self.addSubviews(
            titleLabel,
            boxOfficeTableView
        )
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        boxOfficeTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.horizontalEdges.bottom.equalToSuperview().inset(10)
        }
    }
}
