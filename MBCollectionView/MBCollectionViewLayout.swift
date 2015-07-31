//
//  MBCollectionViewLayout.swift
//  MBCollectionView
//
//  Created by Mikhail Burshteyn on 7/31/15.
//  Copyright (c) 2015 Michael Burshteyn. All rights reserved.
//

import UIKit

class MBCollectionViewLayout: UICollectionViewFlowLayout {
    
    //Expose eventially
    private let sizeCollapsed = 50;
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var attributes = [UICollectionViewLayoutAttributes]();
        
        //Only supports a single section Collection View at this point
        for x in 0..<collectionView!.numberOfItemsInSection(0)
        {
            attributes.append(self.layoutAttributesForItemAtIndexPath(NSIndexPath(forRow:x, inSection: 0)))
        }
        
        return attributes;
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath);
        
        var collectionViewController = self.collectionView!.dataSource as! MBCollectionViewController;
        
        var width = collectionView!.bounds.width;
        //Determine height of the collection view by testing whether it is embeded in a Navigation Controller
        var height = collectionView!.bounds.height - (collectionViewController.navigationController != nil ? 64 : 0);
        var itemHeight = CGFloat(collectionViewController.defaultCellHeight);
        var items = collectionView!.numberOfItemsInSection(0);
        
        var frame : CGRect!;

        var selecteCells = collectionView!.indexPathsForSelectedItems()
        //If none of the items are selected
        if selecteCells.count == 0
        {
            var y : CGFloat!;
            //Last item always placed right above bottom
            if (indexPath.row == items - 1)
            {
                y = height - itemHeight;
            }
            //First item placed right on top
            else if indexPath.row == 0
            {
                y = 0;
            }
            //All other items are evenly spaced between top and top of bottom item
            else
            {
                y = (height - itemHeight) / CGFloat(items - 1) * CGFloat(indexPath.row)
            }
            frame = CGRect(x: 0, y: y, width: width, height: itemHeight);
        }
        //if an item is selected
        else
        {
            //Selected Item gets placed on top
            if (selecteCells[0] as! NSIndexPath == indexPath)
            {
                frame = CGRect(x: 0, y: 0, width: Int(width), height: Int(itemHeight));
            }
            else
            {
                //Get the index of the item considering the selected item is not in play
                var index = indexPath.row < selecteCells[0].row ? indexPath.row : indexPath.row - 1
                //Spread items evently inside sizeCollapsed
                var y = (height - CGFloat(sizeCollapsed)) + CGFloat(sizeCollapsed) / CGFloat(items - 1) * CGFloat(index)
                //Shrink items as they fade into the back
                var transform = CGAffineTransformMakeScale(1.0 - CGFloat(items - index) * 0.02, 1);
                attributes.transform = transform;
                frame = CGRect(x: 0, y: y, width: width, height: itemHeight);
            }
        }
        
        attributes.frame = frame;
        
        return attributes;
        
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        //Only invalidate if frame of collectionView changed
        return newBounds.width != collectionView?.bounds.width
    }

}
