//
//  MBCollectionViewController.swift
//  MBCollectionView
//
//  Created by Mikhail Burshteyn on 7/31/15.
//  Copyright (c) 2015 Michael Burshteyn. All rights reserved.
//

import UIKit

var reuseIdentifier = "Cell"

public class MBCollectionViewController: UICollectionViewController {

    public var defaultCellHeight: CGFloat!;
    private let layout = MBCollectionViewLayout();
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.collectionViewLayout = layout;
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDelegate
    
    override public func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        var result = true;
    
        for indexPath in collectionView.indexPathsForSelectedItems()
        {
            result = false;
            collectionView.deselectItemAtIndexPath((indexPath as! NSIndexPath), animated: false);
            self.collectionView(collectionView, didDeselectItemAtIndexPath: (indexPath as! NSIndexPath));
        }
        return result;
    }
    
    public override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.performBatchUpdates(nil, completion: nil)
        //Disable scroll when item is selected
        collectionView.scrollEnabled = false;
    }
    
    public override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.performBatchUpdates(nil, completion: nil)
        //Enable scroll when in default layout
        collectionView.scrollEnabled = true;
    }
}
