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
    
    private let boxOfficeView = BoxOfficeView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = boxOfficeView
    }
    
    // MARK: - bindViewModel
    
    override func bindViewModel() {
        let input = BoxOfficeViewModel.Input(viewWillAppearEvent: self.rx.viewWillAppear.asObservable())
        
        let output = viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.daliyBoxOfficeList.subscribe(onNext: { [self] daliyBoxOfficeList in
            boxOfficeData = daliyBoxOfficeList
            boxOfficeView.boxOfficeTableView.reloadData()
        }).disposed(by: disposeBag)
        
        output.daliyBoxOfficeList
            .asObservable()
            .bind(to: boxOfficeView.boxOfficeTableView.rx.items(
                cellIdentifier: BoxOfficeTableViewCell.className,
                cellType: BoxOfficeTableViewCell.self
            )) { (row, element, cell) in
                cell.dataBind(element)
            }.disposed(by: disposeBag)
    }
}
