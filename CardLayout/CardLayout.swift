//
//  CardLayout.swift
//  CardLayout
//
//  Created by 陈凯 on 2017/3/2.
//  Copyright © 2017年 陈凯. All rights reserved.
//

import UIKit

class CardLayout: UICollectionViewLayout {

    var itemSize: CGSize = CGSize(width: 280, height: 400)
    var spacing: CGFloat = 10.0
    var scale: CGFloat = 1.0
    var edgeInset: UIEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20)
    var scrollDirection: UICollectionViewScrollDirection = .horizontal
    
    private var rectAttributes:[UICollectionViewLayoutAttributes] = [];
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize {
        
        guard let collectionView = collectionView else {
            return .zero
        }
        let count = collectionView.numberOfItems(inSection: 0)
        
        var width, height: CGFloat
        switch scrollDirection {
        case .horizontal:
            width = CGFloat(count)*(itemSize.width+spacing)-spacing+edgeInset.left+edgeInset.right
            height = collectionView.bounds.height
            
        case .vertical:
            width = collectionView.bounds.width
            height = CGFloat(count)*(itemSize.height+spacing)-spacing+edgeInset.top+edgeInset.bottom
        }
        return CGSize(width: width, height: height)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let collectionView = collectionView else {
            return nil
        }
        
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attribute.size = itemSize
        
        var x, y:CGFloat
        switch scrollDirection {
        case .horizontal:
            x = edgeInset.left + CGFloat(indexPath.item)*(itemSize.width+spacing)
            y = 0.5*(collectionView.bounds.height - itemSize.height)
            
        case .vertical:
            x = edgeInset.left + CGFloat(indexPath.item)*(itemSize.width+spacing)
            y = 0.5*(collectionView.bounds.width - itemSize.width)
        }
        attribute.frame = CGRect(origin: CGPoint(x:x, y:y), size: itemSize)
        return attribute
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let collectionView = collectionView else {
            return nil
        }
        
        let attributes = self.attributes(in: rect)
        
        var scale, offset, deno: CGFloat
        switch scrollDirection {
        case .horizontal:
            let centerX = collectionView.contentOffset.x+0.5*collectionView.bounds.width
            for attribute in attributes {
                offset = abs(attribute.center.x - centerX)
                deno = itemSize.width+spacing
                scale = offset<deno ? 1+(1-offset/deno)*(self.scale-1) : 1
                attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            
        case .vertical:
            let centerY = collectionView.contentOffset.y+0.5*collectionView.bounds.height
            for attribute in attributes {
                offset = abs(attribute.center.y - centerY)
                deno = itemSize.height+spacing
                scale = offset<deno ? 1+(1-offset/deno)*(self.scale-1) : 1
                attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        return attributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }
        
        let rect = CGRect(x: proposedContentOffset.x, y: proposedContentOffset.y, width: collectionView.bounds.width, height: collectionView.bounds.height)
        guard let attributes = layoutAttributesForElements(in: rect) else {
            return proposedContentOffset
        }
        
        var minOffset = CGFloat(Int.max)
        switch scrollDirection {
        case .horizontal:
            let centerX = collectionView.contentOffset.x+0.5*collectionView.bounds.width
            for attribute in attributes {
                let offsetX = attribute.center.x-centerX
                if abs(offsetX)<abs(minOffset) {
                    minOffset = offsetX
                }
            }
            return CGPoint(x:proposedContentOffset.x+minOffset, y:proposedContentOffset.y)
            
        case .vertical:
            let centerY = collectionView.contentOffset.y+0.5*collectionView.bounds.height
            for attribute in attributes {
                let offsetY = attribute.center.y-centerY
                if abs(offsetY)<abs(minOffset) {
                    minOffset = offsetY
                }
            }
            return CGPoint(x:proposedContentOffset.x, y:proposedContentOffset.y+minOffset)
        }
    }
    
    private func attributes(in rect: CGRect) -> [UICollectionViewLayoutAttributes] {
        
        guard let collectionView = collectionView else {
            return []
        }
        
        let itemCount = collectionView.numberOfItems(inSection: 0)
        var preIndex, latIndex: Int;
        switch scrollDirection {
        case .horizontal:
            preIndex = Int((rect.origin.x-edgeInset.left)/(itemSize.width+spacing))
            latIndex = Int((rect.maxX-edgeInset.left)/(itemSize.width+spacing))
            
        case .vertical:
            preIndex = Int((rect.origin.y-edgeInset.top)/(itemSize.height+spacing))
            latIndex = Int((rect.maxY-edgeInset.top)/(itemSize.height+spacing))
        }
        preIndex = preIndex<0 ? 0 : preIndex
        latIndex = latIndex>=itemCount ? itemCount-1 : latIndex
        
        rectAttributes.removeAll()
        for i in preIndex...latIndex {
            let indexPath = IndexPath(item: i, section: 0)
            let attribute = layoutAttributesForItem(at: indexPath)
            if rect.intersects(attribute!.frame) {
                rectAttributes.append(attribute!)
            }
        }
        
        return rectAttributes;
    }
    
}
