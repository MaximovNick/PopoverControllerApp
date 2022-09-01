//
//  PopOverViewController.swift
//  PopoverApp
//
//  Created by Nikolai Maksimov on 01.09.2022.
//

import UIKit

class PopOverViewController: UIViewController {
    
    private let popOverCollectionView = PopOverCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor =  .white
        view.addSubview(popOverCollectionView)
    }
}

extension PopOverViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            popOverCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            popOverCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            popOverCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            popOverCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
}
