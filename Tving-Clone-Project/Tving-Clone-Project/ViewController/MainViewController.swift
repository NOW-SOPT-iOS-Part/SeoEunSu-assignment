//
//  MainViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/27/24.
//

import UIKit

import SnapKit
import Then

/// 티빙 메인 화면
final class MainViewController: UIViewController {
    
    // MARK: - Components
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let tvingTopLogoImageView = UIImageView().then {
        $0.image = .tvingTitleWhite
    }
    
    private let shareButton = UIButton().then {
        $0.setImage(.init(systemName: "square.and.arrow.up"), for: .normal)
        $0.tintColor = .white
    }
    
    private let bearsLogoButton = UIButton().then {
        $0.setImage(.bearsLogo, for: .normal)
    }
    
    private lazy var rightTopButtonStackView = UIStackView(arrangedSubviews: [shareButton, bearsLogoButton]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    private let mainPosterImageView = UIImageView().then {
        $0.image = .yournamePoster
        $0.contentMode = .scaleAspectFill
    }
    
    private let posterTitleLabel = UILabel().then {
        $0.text = "너의 이름은"
        $0.textColor = .white
        $0.font = .pretendard(weight: 700, size: 25)
    }
    
    private let posterDetailLabel = UILabel().then {
        $0.text = "sdfdsfdsfdsf\n아랑라ㅘ저로ㅓ동라ㅏㅇㄹ"
        $0.textColor = .white
        $0.font = .pretendard(weight: 400, size: 17)
        $0.lineBreakMode = .byTruncatingTail
        $0.numberOfLines = 2
    }
    
    private lazy var mainTableView = UITableView().then {
        $0.backgroundColor = .black
        $0.delegate = self
        $0.dataSource = self
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setLayout()
        register()
    }
    
    // MARK: - Helpers
    
    private func setLayout() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            mainPosterImageView,
            tvingTopLogoImageView,
            rightTopButtonStackView,
            posterTitleLabel,
            posterDetailLabel,
            mainTableView,
        ].forEach { contentView.addSubview($0) }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
            $0.height.equalTo(1000)
        }
        
        mainPosterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(498)
        }
        tvingTopLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().inset(20)
        }
        rightTopButtonStackView.snp.makeConstraints {
            $0.centerY.equalTo(tvingTopLogoImageView)
            $0.trailing.equalToSuperview().inset(20)
        }
        posterTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(mainPosterImageView).offset(-70)
        }
        posterDetailLabel.snp.makeConstraints {
            $0.leading.equalTo(posterTitleLabel)
            $0.top.equalTo(posterTitleLabel.snp.bottom).offset(15)
        }
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(mainPosterImageView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func register() {
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    // MARK: - Actions
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        return cell
    }
}
