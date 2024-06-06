//
//  BoxOfficeViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 5/10/24.
//

import UIKit

import SnapKit
import Then

final class BoxOfficeViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var boxOfficeData: [DailyBoxOffice] = []
    
    // MARK: - Components
    
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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        requestDailyBoxOfficeList()
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
    
    // MARK: - Helpers
    
    private func register() {
        boxOfficeTableView.register(
            BoxOfficeTableViewCell.self,
            forCellReuseIdentifier: BoxOfficeTableViewCell.identifier
        )
    }
    
    /// TMI: 시간이 일러서 그런지 오늘 날짜로 하면 아직 데이터가 없길래...
    /// 어제 날짜를 yyyyMMdd 형태로 반환해주는 함수
    private func getYesterdayDateStr() -> String {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let yesterdayDateStr = dateFormatter.string(from: yesterday)
        return yesterdayDateStr
    }

    /// 일별 박스오피스 조회 API를 호출
    private func requestDailyBoxOfficeList() {
        BoxOfficeService.shared.getDailyBoxOffice(targetDt: getYesterdayDateStr()) { res in
            switch res {
            case .success(let data):
                guard let data = data as? BoxOfficeResModel else { return }
                self.boxOfficeData = data.boxOfficeResult.dailyBoxOfficeList
                self.boxOfficeTableView.reloadData()
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
        boxOfficeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        cell.dataBind(boxOfficeData[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BoxOfficeViewController: UITableViewDelegate {
    
}
