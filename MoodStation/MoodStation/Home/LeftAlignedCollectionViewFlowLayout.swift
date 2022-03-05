//
//  L.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/05.
//

import UIKit.UICollectionViewFlowLayout

final class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    convenience init(minimumLineSpacing: CGFloat, minimumInteritemSpacing: CGFloat, estimatedItemSize: CGSize) {
        self.init()
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.estimatedItemSize = estimatedItemSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        let leftAlignedMargin = sectionInset.left
        
        var cellLeftMargin = leftAlignedMargin
        var maxY: CGFloat = -1.0
        
        attributes?.forEach { cellLayoutAttribute in
            if cellLayoutAttribute.frame.origin.y >= maxY {
                cellLeftMargin = leftAlignedMargin
            }
            
            cellLayoutAttribute.frame.origin.x = cellLeftMargin
            cellLeftMargin += (cellLayoutAttribute.frame.width + minimumInteritemSpacing)
            maxY = max(cellLayoutAttribute.frame.maxY, maxY)
        }
        
        return attributes
    }
}
