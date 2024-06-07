//
//  BoxOfficeViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 5/10/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class BoxOfficeViewController: BaseViewController<BoxOfficeViewModel> {
    
    // MARK: - Properties
    
    private var boxOfficeData: [DailyBoxOffice] = []
    
    // MARK: - Components
    
    private let titleLabel = UILabel().then {
        $0.text = StringLiteral.todayBoxOfficeRankStr
        $0.font = .pretendard(weight: 700, size: 25)
        $0.textColor = .white
    }
    
    private lazy var boxOfficeTableView = UITableView().then {
        $0.backgroundColor = .black
        $0.register(
            BoxOfficeTableViewCell.self,
            forCellReuseIdentifier: BoxOfficeTableViewCell.className
        )
    }
    
    // MARK: - Set UI
    
    override func addSubview() {
        self.view.addSubviews(
            titleLabel,
            boxOfficeTableView
        )
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        boxOfficeTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.horizontalEdges.bottom.equalToSuperview().inset(10)
        }
    }
    
    // MARK: - bindViewModel
    
    override func bindViewModel() {
        let input = BoxOfficeViewModel.Input(viewWillAppearEvent: self.rx.viewWillAppear.asObservable())
        
        let output = viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.daliyBoxOfficeList.subscribe(onNext: { daliyBoxOfficeList in
            self.boxOfficeData = daliyBoxOfficeList
            self.boxOfficeTableView.reloadData()
        }).disposed(by: disposeBag)
        
        output.daliyBoxOfficeList
            .asObservable()
            .bind(to: boxOfficeTableView.rx.items(
                cellIdentifier: BoxOfficeTableViewCell.className,
                cellType: BoxOfficeTableViewCell.self
            )) { (row, element, cell) in
                cell.dataBind(element)
            }.disposed(by: disposeBag)
    }
}
