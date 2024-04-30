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
    let numOfSection = 5
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
        $0.numberOfPages = posterImages.count
        $0.currentPage = 0
        $0.isUserInteractionEnabled = false
        $0.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    let config = UICollectionViewCompositionalLayoutConfiguration().then {
        $0.interSectionSpacing = 90
    }
    lazy var layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
        
        return self.createSection(for: sectionIndex)
    }
    private lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.backgroundColor = .black
        $0.delegate = self
        $0.dataSource = self
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        register()
        setLayout()
    }
    
    // MARK: - Helpers
    
    private func register() {
        mainCollectionView.register(LiveCollectionViewCell.self, forCellWithReuseIdentifier: LiveCollectionViewCell.identifier)
        mainCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        mainCollectionView.register(BaseballCollectionViewCell.self, forCellWithReuseIdentifier: BaseballCollectionViewCell.identifier)
    }
    
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
            mainCollectionView
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
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(23)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(500)
        }
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection? {
        switch sectionIndex {
            case 0, 2, 4:
                return createPosterItem(sectionIndex: sectionIndex)
            case 1:
                return createLiveItem()
            case 3:
                return createBaseballSloganItem()
            default:
            return createPosterItem(sectionIndex: sectionIndex)
        }
    }
    
    private func createPosterItem(sectionIndex: Int) -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .estimated(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // 가로 스크롤
        section.interGroupSpacing = 8

        return section
    }
    
    private func createLiveItem() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .estimated(155))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(7)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // 가로 스크롤
        section.interGroupSpacing = 7

        return section
    }
    
    private func createBaseballSloganItem() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(58))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(0)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // 가로 스크롤
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        return section
    }
    
    // MARK: - Actions
    
}

extension MainViewController: UIScrollViewDelegate {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 한 페이지만큼 스크롤 하면
        if fmod(posterScrollView.contentOffset.x, posterScrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(posterScrollView.contentOffset.x / posterScrollView.frame.maxX)
            // 페이지 위치 변경
            let pageIndex = Int(posterScrollView.contentOffset.x / posterScrollView.frame.width)
            pageControl.currentPage = pageIndex

            // mainPosterImageView의 이미지 업데이트
            mainPosterImageView.image = posterImages[pageIndex]
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        numOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0, 2, 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveCollectionViewCell.identifier, for: indexPath) as? LiveCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseballCollectionViewCell.identifier, for: indexPath) as? BaseballCollectionViewCell else { return UICollectionViewCell() }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
    }
}
