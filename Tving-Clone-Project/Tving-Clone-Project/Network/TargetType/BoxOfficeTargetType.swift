//
//  BoxOfficeTargetType.swift
//  Bubble
//
//  Created by 서은수 on 5/10/24.
//

import Foundation

import Moya

enum BoxOfficeTargetType {
    case getDailyBoxOffice(targetDt: String)
}

extension BoxOfficeTargetType: TargetType {
    var baseURL: URL {
        return URL(string: Secret.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getDailyBoxOffice:
            return "/boxoffice/searchDailyBoxOfficeList.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDailyBoxOffice:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getDailyBoxOffice(let targetDt):
            let params = [
                "key": Secret.apiKey,
                "targetDt": targetDt
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getDailyBoxOffice:
            return ["Content-Type": "application/json"]
        }
    }
}
