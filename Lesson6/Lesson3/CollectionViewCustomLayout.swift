//
//  CollectionViewCustomLayout.swift
//  Lesson3
//
//  Created by Владимир Рузавин on 9/23/21.
//

import UIKit

class CollectionViewCustomLayout: UICollectionViewLayout {
    private var cachedAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    private let columnsCount = 2
    private let cellHeight: CGFloat = 150
    private var totalHeight:CGFloat = 0
    private let inset:CGFloat = 8
    
    override func prepare() {
        guard let collectionView = self.collectionView else { return }
        
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else { return }
       
        var lastY: CGFloat = 0
        var lastX:CGFloat = 0
        
        let bigCellWidth: CGFloat = collectionView.frame.width
        let smallCellWidth: CGFloat = (collectionView.frame.width -  (CGFloat(self.columnsCount - 1) * self.inset)) / CGFloat(self.columnsCount)
       
        for index in 0..<itemsCount {
            let indexPath = IndexPath(row: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let isBig = (index + 1) % (self.columnsCount + 1) == 0
            
            if isBig {
                attributes.frame = .init(x: 0, y: lastY, width: bigCellWidth, height: self.cellHeight)
                lastY += self.cellHeight + self.inset
            } else {
                attributes.frame = .init(x: lastX, y: lastY, width: bigCellWidth, height: self.cellHeight)
                let isLastColumn = ((index + 2) % (self.columnsCount + 1) == 0) || index == itemsCount - 1
                
                if isLastColumn {
                    lastX = 0
                    lastY += self.cellHeight + inset
                } else {
                    lastX += smallCellWidth + inset
                }
                self.cachedAttributes[indexPath] = attributes
            }
            self.totalHeight = lastY
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.cachedAttributes.values.filter { rect.intersects(0$.frame) }
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cachedAttributes[indexPath]
    }
    override var collectionViewContentSize: CGSize {
        return .init(width: self.collectionView?.frame.width ?? 0, height: self.totalHeight)
    }
}
