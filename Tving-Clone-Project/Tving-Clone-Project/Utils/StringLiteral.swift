//
//  StringLiteral.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/6/24.
//

import Foundation

struct StringLiteral {
    // 탭바 타이틀
    static var homeStr = "홈"
    static var soonStr = "공개예정"
    static var searchStr = "검색"
    static var recordStr = "기록"
    
    // 탭바 기본 이미지
    static var homeImgName = "house"
    static var soonImgName = "video"
    static var searchImgName = "magnifyingglass"
    static var recordImgName = "clock"
    
    // 탭바 클릭 안 됐을 때 이미지
    static var homeUnselectedImgName = "house.fill"
    static var soonUnselectedImgName = "video.fill"
    static var recordUnselectedImgName = "clock.fill"
    
    // 로그인 화면 뷰
    static var idLoginLabelStr = "TVING ID 로그인"
    static var idTextFieldPlaceHolder = "아이디"
    static var pwTextFieldPlaceHolder = "비밀번호"
    static var loginButtonStr = "로그인하기"
    static var findIdButtonStr = "아이디 찾기"
    static var findPwButtonStr = "비밀번호 찾기"
    static var noAccountGuideLabelStr = "아직 계정이 없으신가요?"
    static var makeNicknameButtonStr = "닉네임 만들러가기"
    
    // 로그인 화면 에러
    static var noNicknameErrTitle = "닉네임 미설정 에러"
    static var noNicknameErrMsg = "닉네임을 먼저 설정해주세요!"
    static var regexErrTitle = "정규식 에러"
    static var regexErrMsg = "이메일 또는 비밀번호의 형식을 다시 확인해주세요!"
    
    // 닉네임 바텀 시트 화면
    static var enterNicknameLabelStr = "닉네임을 입력해주세요"
    static var nicknameTextFieldPlaceHolder = "한글 2-10자로 설정해주세요"
    
    // 닉네임 바텀 시트 화면 에러
    static var nicknameRegexErrTitle = "닉네임 정규식 에러"
    static var nicknameRegexErrMsg = "닉네임 형식을 다시 확인해주세요!"
    
    // 환영합니다 화면
    static var welcomeLabelStr = "님\n반가워요!"
    static var toMainButtonStr = "메인으로"
    
    // 티빙 메인 화면
    static var liveStr = "실시간"
    static var tvProgramStr = "TV프로그램"
    static var movieStr = "영화"
    static var paramountPlusStr = "파라마운트+"
    static var fullViewStr = "전체보기"
    static var shareIconImgName = "square.and.arrow.up"
    static var rightArrowImgName = "chevron.right"
    
    // 공개예정 화면
    static var todayBoxOfficeRankStr = "오늘의 박스 오피스 순위"
    
    static var requestErr = "요청 오류입니다"
    static var decodingErr = "디코딩 오류입니다"
    static var pathErr = "경로 오류입니다"
    static var serverErr = "서버 오류입니다"
    static var networkFailErr = "네트워크 오류입니다"
    
    // 메인 화면 헤더
    static var emptyHeaderStr = ""
    static var contentsHeaderStr = "티빙에서 꼭 봐야하는 콘텐츠"
    static var popularLiveHeaderStr = "인기 LIVE 채널"
    static var paramountPlusHeaderStr = "1화 무료! 파라마운트+ 인기 시리즈"
    static var userContentsHeaderStr = "서은수님이 시청하는 콘텐츠"
}
