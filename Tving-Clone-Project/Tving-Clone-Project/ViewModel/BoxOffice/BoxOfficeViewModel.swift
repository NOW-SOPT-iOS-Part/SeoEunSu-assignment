//
//  BoxOfficeViewModel.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/6/24.
//

import UIKit

import RxRelay
import RxSwift
import SnapKit
import Then

final class BoxOfficeViewModel: ViewModelType {
    
    // MARK: - Properties
    
    private var dailyBoxOffice: [DailyBoxOffice] = []
    
    // MARK: - Input
    
    struct Input {
        let viewWillAppearEvent: Observable<Bool>
    }
    
    // MARK: - Output
    
    struct Output {
        let daliyBoxOfficeList = PublishRelay<[DailyBoxOffice]>()
    }
}

extension BoxOfficeViewModel {
    
    // MARK: - transform
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        input.viewWillAppearEvent
            .flatMapLatest { _ -> Observable<[DailyBoxOffice]> in
                return self.requestDailyBoxOfficeList()
            }
            .bind(to: output.daliyBoxOfficeList)
            .disposed(by: disposeBag)
        return output
    }
}
    
extension BoxOfficeViewModel {
    
    // MARK: - Helpers
    
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
    private func requestDailyBoxOfficeList() -> Observable<[DailyBoxOffice]> {
        return Observable.create { [self] observer in
            BoxOfficeService.shared.getDailyBoxOffice(targetDt: getYesterdayDateStr()) { res in
                switch res {
                case .success(let data):
                    guard let data = data as? BoxOfficeResModel else { return }
                    observer.onNext(data.boxOfficeResult.dailyBoxOfficeList)
                    observer.onCompleted()
                case .requestError:
                    print(StringLiteral.requestErr)
                case .decodingError:
                    print(StringLiteral.decodingErr)
                case .pathError:
                    print(StringLiteral.pathErr)
                case .serverError:
                    print(StringLiteral.serverErr)
                case .networkFail:
                    print(StringLiteral.networkFailErr)
                }
            }
            return Disposables.create()
        }
    }
}
