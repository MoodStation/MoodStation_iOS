//
//  UICollectionView+.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/06.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(cell.self, forCellWithReuseIdentifier: String(describing: cell))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cell: T.Type, at indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath) as? T
    }
    
}
