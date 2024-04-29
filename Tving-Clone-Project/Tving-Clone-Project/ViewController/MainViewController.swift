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
    
    // MARK: - Properties
    
    let posterHeight = 498
    let deviceWidth = UIScreen.main.bounds.width
    let posterImages: [UIImage] = [.yournamePoster, .harryporterPoster, .doorPoster, .ringPoster]
    
    // MARK: - Components
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
    }
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
    
    private lazy var mainPosterImageView = UIImageView().then {
        $0.image = posterImages[pageControl.currentPage]
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
    
    private lazy var posterScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.delegate = self
    }
    private let posterContentView = UIView()
    
    private lazy var pageControl = UIPageControl().then {
        // Set the number of pages to page control.
        $0.numberOfPages = posterImages.count
        // Set the current page.
        $0.currentPage = 0
        $0.isUserInteractionEnabled = false
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
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7); //set value heres
    }
    
    // MARK: - Helpers
    
    private func setLayout() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        posterScrollView.addSubview(posterContentView)
        
        [
            mainPosterImageView,
            tvingTopLogoImageView,
            rightTopButtonStackView,
            posterScrollView,
            pageControl,
            mainTableView
        ].forEach { contentView.addSubview($0) }
        [
            posterTitleLabel,
            posterDetailLabel
        ].forEach { posterContentView.addSubview($0) }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
            $0.height.equalTo(1000)
        }
        
        mainPosterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(posterHeight)
        }
        tvingTopLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().inset(20)
        }
        rightTopButtonStackView.snp.makeConstraints {
            $0.centerY.equalTo(tvingTopLogoImageView)
            $0.trailing.equalToSuperview().inset(20)
        }
        posterScrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(posterHeight)
        }
        posterContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.greaterThanOrEqualTo(Int(deviceWidth) * posterImages.count)
        }
        posterTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(mainPosterImageView).offset(-70)
        }
        posterDetailLabel.snp.makeConstraints {
            $0.leading.equalTo(posterTitleLabel)
            $0.top.equalTo(posterTitleLabel.snp.bottom).offset(15)
        }
        pageControl.snp.makeConstraints {
            $0.top.equalTo(mainPosterImageView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(-23)
        }
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(23)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func register() {
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    // MARK: - Actions
    
}

extension MainViewController: UIScrollViewDelegate {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // When the number of scrolls is one page worth.
        if fmod(posterScrollView.contentOffset.x, posterScrollView.frame.maxX) == 0 {
            // Switch the location of the page.
            pageControl.currentPage = Int(posterScrollView.contentOffset.x / posterScrollView.frame.maxX)
            // 페이지 위치 변경
            let pageIndex = Int(posterScrollView.contentOffset.x / posterScrollView.frame.width)
            pageControl.currentPage = pageIndex

            // mainPosterImageView의 이미지 업데이트
            mainPosterImageView.image = posterImages[pageIndex]
        }
    }
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
