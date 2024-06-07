//
//  BaseViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/6/24.
//

import UIKit

import RxSwift

class BaseViewController<T: ViewModelType>: UIViewController {
    
    let viewModel: T
    let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(viewModel: T) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        addSubview()
        setLayout()
        setStyle()
        bindViewModel()
    }

    // MARK: - Set UI
    
    func addSubview() { }
    func setLayout() { }
    func setStyle() { }
    
    // MARK: - Rx
    
    func bindViewModel() { }
}
