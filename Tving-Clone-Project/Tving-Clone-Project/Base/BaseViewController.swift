//
//  BaseViewController.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 6/6/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
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
    }

    // MARK: - Set UI
    
    func addSubview() { }
    func setLayout() { }
    func setStyle() { }
}
