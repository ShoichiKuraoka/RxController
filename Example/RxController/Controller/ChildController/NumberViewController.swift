//
//  NumberViewController.swift
//  RxController_Example
//
//  Created by Meng Li on 2019/04/16.
//  Copyright © 2019 MuShare. All rights reserved.
//

import UIKit
import RxController

class NumberViewController: RxViewController<NumberViewModel> {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NumberChildViewController"
        label.textColor = .blue
        return label
    }()
    
    private lazy var nameLabel = UILabel()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .red
        return label
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update Number", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.rx.tap.bind { [unowned self] in
            self.viewModel.updateNumber()
        }.disposed(by: disposeBag)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(numberLabel)
        view.addSubview(updateButton)
        createConstraints()
        
        viewModel.name ~> nameLabel.rx.text ~ disposeBag
        viewModel.number ~> numberLabel.rx.text ~ disposeBag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.updateNumber()
    }
    
    private func createConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
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
        
    }
    
}
