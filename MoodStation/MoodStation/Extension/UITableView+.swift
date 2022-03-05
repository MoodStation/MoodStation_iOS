//
//  UITableView+.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/05.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        self.register(cell.self, forCellReuseIdentifier: String(describing: cell))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type, at indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: String(describing: cell.self), for: indexPath) as? T
    }
    
}
