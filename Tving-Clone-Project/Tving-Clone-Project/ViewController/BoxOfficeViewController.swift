//
//  BoxOfficeViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 5/10/24.
//

import UIKit

import SnapKit
import Then

class BoxOfficeViewController: UIViewController {
    
    private let titleLabel = UILabel().then {
        $0.text = "오늘의 박스 오피스 순위"
        $0.font = .pretendard(weight: 700, size: 25)
        $0.textColor = .white
    }
    
    private lazy var boxOfficeTableView = UITableView().then {
        $0.backgroundColor = .black
        $0.delegate = self
        $0.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setLayout()
        register()
        requestDailyBoxOfficeList()
    }
    
    // MARK: - Helpers
    
    private func setLayout() {
        self.view.addSubviews(
            titleLabel,
            boxOfficeTableView
        )
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        boxOfficeTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.horizontalEdges.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func register() {
        boxOfficeTableView.register(
            BoxOfficeTableViewCell.self,
            forCellReuseIdentifier: BoxOfficeTableViewCell.identifier
        )
    }
    
    private func requestDailyBoxOfficeList() {
        BoxOfficeService.shared.getDailyBoxOffice(targetDt: "20240509") { res in
            switch res {
            case .success(let data):
                guard let data = data as? BoxOfficeResModel else { return }
                print("응답값! \(data)")
            case .requestError:
                print("요청 오류 입니다")
            case .decodingError:
                print("디코딩 오류 입니다")
            case .pathError:
                print("경로 오류 입니다")
            case .serverError:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension BoxOfficeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BoxOfficeViewController: UITableViewDelegate {
    
}
