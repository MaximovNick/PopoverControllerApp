//
//  PopOverCollectionView.swift
//  PopoverApp
//
//  Created by Nikolai Maksimov on 01.09.2022.
//

import Foundation
import UIKit

protocol PopOverCollectionViewProtocol: AnyObject {
    func selectItem(indexPath: IndexPath)
}

class PopOverCollectionView: UICollectionView {
    
    weak var mainCellDelegate: PopOverCollectionViewProtocol?
    private var flowLayout = UICollectionViewFlowLayout()
    
    private let cellConfigureArray = [["Like", "Subscribe", "Contact"],
                                      ["hand.thumbsup.fill", "play.rectangle.fill",
                                       "person.crop.circle.fill.badge.plus"]]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        delegate = self
        dataSource = self
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        register(PopOverCollectionViewCell.self, forCellWithReuseIdentifier: PopOverCollectionViewCell().popOverCellId)
        flowLayout.minimumLineSpacing = 2
    }
}

// MARK: - UICollectionViewDataSource
extension PopOverCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellConfigureArray[0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopOverCollectionViewCell().popOverCellId, for: indexPath) as? PopOverCollectionViewCell else { return UICollectionViewCell() }
        
        let iconName = cellConfigureArray[1][indexPath.row]
        let text = cellConfigureArray[0][indexPath.row]
        cell.setConfigure(iconName: iconName, text: text)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PopOverCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainCellDelegate?.selectItem(indexPath: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PopOverCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: collectionView.frame.width, height: 40)
    }
}
