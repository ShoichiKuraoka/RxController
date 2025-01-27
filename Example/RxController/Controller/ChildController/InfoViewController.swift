//
//  InfoViewController.swift
//  RxController
//
//  Created by Meng Li on 04/01/2019.
//  Copyright (c) 2019 MuShare. All rights reserved.
//

import UIKit
import RxController
import SnapKit

class InfoViewController: RxViewController<InfoViewModel> {
    
    private lazy var nameLabel = UILabel()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update All", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.rx.tap.bind { [unowned self] in
            self.viewModel.updateAll()
        }.disposed(by: disposeBag)
        return button
    }()
    
    private lazy var numberContainerView = UIView()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.backgroundColor = .blue
        button.rx.tap.bind { [unowned self] in
            self.viewModel.close()
        }.disposed(by: disposeBag)
        return button
    }()
    
    private lazy var nameViewController = NameViewController(viewModel: .init())

    private lazy var numberViewController = NumberViewController(viewModel: .init())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        view.addSubview(numberLabel)
        view.addSubview(updateButton)
        view.addSubview(numberContainerView)
        view.addSubview(closeButton)
        
        addChild(nameViewController)
        addChild(numberViewController, to: numberContainerView)
        
        createConstraints()
        
        viewModel.name ~> nameLabel.rx.text ~ disposeBag
        viewModel.number ~> numberLabel.rx.text ~ disposeBag
    }
    
    private func createConstraints() {
        nameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(100)
        }
        
        numberLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.right.equalToSuperview().offset(-10)
        }
        
        updateButton.snp.makeConstraints {
            $0.right.equalTo(numberLabel)
            $0.top.equalTo(numberLabel.snp.bottom).offset(10)
            $0.width.equalTo(150)
        }
        
        nameViewController.view.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(360)
            $0.top.equalTo(self.updateButton.snp.bottom).offset(30)
        }
        
        numberContainerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(100)
            $0.top.equalTo(self.nameViewController.view.snp.bottom).offset(30)
        }
        
        closeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
}
