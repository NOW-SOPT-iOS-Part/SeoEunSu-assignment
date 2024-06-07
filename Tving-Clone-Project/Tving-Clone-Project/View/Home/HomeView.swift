//
//  HomeView.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/7/24.
//

import UIKit

import SnapKit
import Then

class HomeView: BaseView {
    
    // MARK: - Properties
    
    var headers: [String]
    var tabs: [Tab]
    
    var bigPosters: [Poster] = []
    var posters: [Poster] = []
    var livePrograms: [LiveProgram] = []
    var baseballSlogans: [BaseballSlogan] = []
    
    // MARK: - Init
    
    init(headers: [String], tabs: [Tab]) {
        self.headers = headers
        self.tabs = tabs
        super.init(frame: CGRect())
        
        register()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
        $0.isScrollEnabled = false
    }
    
    private var contentView = UIView()
    
    let tvingTopLogoImageView = UIImageView().then {
        $0.image = .tvingTitleWhite
    }
    
    private let shareButton = UIButton().then {
        $0.setImage(.init(systemName: StringLiteral.shareIconImgName), for: .normal)
        $0.tintColor = .white
    }
    
    private let bearsLogoButton = UIButton().then {
        $0.setImage(.bearsLogo, for: .normal)
    }
    
    lazy var rightTopButtonStackView = UIStackView(arrangedSubviews: [shareButton, bearsLogoButton]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    let bufferView = UIView().then {
        $0.backgroundColor = .none
    }
    
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 28
        $0.sectionInset = .init(top: 0, left: -5, bottom: 0, right: 0)
    }
    
    lazy var tabControlCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
        $0.tag = 1
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .none
        $0.showsHorizontalScrollIndicator = false
    }
    
    let config = UICollectionViewCompositionalLayoutConfiguration().then {
        $0.interSectionSpacing = 18
    }
    
    lazy var compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
        return self.createSection(for: sectionIndex)
    }, configuration: config)
    
    lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout).then {
        $0.tag = 2
        $0.backgroundColor = .black
        $0.delegate = self
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Set UI
    
    override func addSubview() {
        self.addSubviews(
            mainCollectionView,
            tvingTopLogoImageView,
            rightTopButtonStackView,
            bufferView,
            tabControlCollectionView
        )
    }
    
    override func setLayout() {
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tvingTopLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58)
            $0.leading.equalToSuperview().inset(20)
        }
        rightTopButtonStackView.snp.makeConstraints {
            $0.centerY.equalTo(tvingTopLogoImageView)
            $0.trailing.equalToSuperview().inset(20)
        }
        bufferView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(94)
        }
        tabControlCollectionView.snp.makeConstraints {
            $0.top.equalTo(bufferView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    
}

extension HomeView {
    
    // MARK: - Helpers
    
    private func register() {
        tabControlCollectionView.register(TabControlCollectionViewCell.self, forCellWithReuseIdentifier: TabControlCollectionViewCell.className)
        mainCollectionView.register(BigPosterCollectionViewCell.self, forCellWithReuseIdentifier: BigPosterCollectionViewCell.className)
        mainCollectionView.register(LiveCollectionViewCell.self, forCellWithReuseIdentifier: LiveCollectionViewCell.className)
        mainCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.className)
        mainCollectionView.register(BaseballCollectionViewCell.self, forCellWithReuseIdentifier: BaseballCollectionViewCell.className)
        mainCollectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.className
        )
        mainCollectionView.register(
            FooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: FooterView.className
        )
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection? {
        switch sectionIndex {
            case 0:
                return createBigPosterSection()
            case 2:
                return createLiveSection()
            case 4:
                return createBaseballSloganItem()
            default: // 1, 3, 5
                return createPosterSection()
        }
    }
    
    /// 맨 위의 큰 크기의 포스터 섹션 부분 만드는 함수
    private func createBigPosterSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(730.0 + 100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging // 페이징
        
        // FooterView의 자리를 SectionLayout 안에서 잡아주는 코드
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        ]
        
        return section
    }
    
    /// 작은 크기의 포스터 섹션 부분 만드는 함수
    private func createPosterSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .estimated(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // 가로 스크롤
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)

        // HeaderView의 자리를 SectionLayout 안에서 잡아주는 코드
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)),
                elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        
        return section
    }
    
    /// 라이브 프로그램 섹션 부분 만드는 함수
    private func createLiveSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .estimated(155))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(7)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // 가로 스크롤
        section.interGroupSpacing = 7
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)

        // HeaderView의 자리를 SectionLayout 안에서 잡아주는 코드
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)),
                elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]

        return section
    }
    
    /// 야구 슬로건 섹션 부분 만드는 함수
    private func createBaseballSloganItem() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(58))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(0)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // 가로 스크롤
        section.contentInsets = NSDirectionalEdgeInsets(top: 27, leading: 15, bottom: 30, trailing: 15)
        
        return section
    }
}

// MARK: - UIScrollViewDelegate

extension HomeView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y, bufferView.frame.minY)
        
        if scrollView == self.mainCollectionView {
            // sticky 타이밍을 계산
            let shouldShowSticky = scrollView.contentOffset.y >= bufferView.frame.minY
            // top에 있는 뷰들 숨김
            tvingTopLogoImageView.isHidden = shouldShowSticky
            rightTopButtonStackView.isHidden = shouldShowSticky
            
            // 애니메이션 적용에서 자연스럽게
            UIView.animate(withDuration: 0.3) { [self] in
                bufferView.backgroundColor = shouldShowSticky ? .black : .none
                tabControlCollectionView.backgroundColor = shouldShowSticky ? .black : .none
                bufferView.snp.updateConstraints {
                    $0.top.equalToSuperview()
                    $0.width.equalToSuperview()
                    $0.height.equalTo(shouldShowSticky ? 40 : 94)
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: tabs[indexPath.row].width, height: 45)
        } else {
            return CGSize()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension HomeView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.className, for: indexPath) as! HeaderView
            header.fetchData(headers[indexPath.section])
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterView.className, for: indexPath) as! FooterView
            footer.config(num: bigPosters.count)
            return footer
        default:
            return UICollectionReusableView()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionView.tag == 1 ? 1 : 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return tabs.count
        } else {
            switch section {
            case 0:
                return bigPosters.count
            case 2:
                return livePrograms.count
            case 4:
                return baseballSlogans.count
            default: // 1, 3, 5
                return posters.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabControlCollectionViewCell.className, for: indexPath) as? TabControlCollectionViewCell else { return UICollectionViewCell() }
            cell.fetchData(model: tabs[indexPath.row])
            return cell
        } else {
            switch indexPath.section {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigPosterCollectionViewCell.className, for: indexPath) as? BigPosterCollectionViewCell else { return UICollectionViewCell() }
                cell.fetchData(model: bigPosters[indexPath.row])
                return cell
            case 2:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveCollectionViewCell.className, for: indexPath) as? LiveCollectionViewCell else { return UICollectionViewCell() }
                cell.fetchData(model: livePrograms[indexPath.row])
                return cell
            case 4:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseballCollectionViewCell.className, for: indexPath) as? BaseballCollectionViewCell else { return UICollectionViewCell() }
                cell.fetchData(model: baseballSlogans[indexPath.row])
                return cell
            default: // 1, 3, 5
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.className, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
                cell.fetchData(model: posters[indexPath.row])
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == mainCollectionView && indexPath.section == 0 {
            if let footers = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionFooter) as? [FooterView],
               let footer = footers.first {
                let currentPage = indexPath.row
                footer.changePageControl(page: currentPage)
            }
        }
    }
}
