//
//  FooterView.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 5/4/24.
//

import UIKit

import SnapKit
import Then

/// PageControl이 있는 첫번째 섹션의 푸터뷰
final class FooterView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifier = "FooterView"
    
    // MARK: - Components
    
    private lazy var pageControl = UIPageControl().then {
        $0.currentPageIndicatorTintColor = .white
        $0.pageIndicatorTintColor = .gray62
        $0.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FooterView {
    
    // MARK: - Set UI
    
    private func setLayout() {
        addSubviews(pageControl)
        pageControl.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(-24)
        }
    }
    
    // MARK: - Helpers
    
    func config(num: Int) {
        pageControl.numberOfPages = num
    }
    
    /// 페이지 이동
    func changePageControl(page: Int) {
        pageControl.currentPage = page
    }
}
