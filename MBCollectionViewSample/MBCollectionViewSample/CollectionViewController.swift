//
//  CollectionViewController.swift
//  MBCollectionViewSample
//
//  Created by Mikhail Burshteyn on 7/31/15.
//  Copyright (c) 2015 Michael Burshteyn. All rights reserved.
//

import UIKit
import MBCollectionView

let reuseIdentifier = "Cell"

class CollectionViewController: MBCollectionViewController {

    var data = [UIColor]();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the height of the Cell
        defaultCellHeight = collectionView!.bounds.width * 0.6;
        
        //Add data
        data.append(UIColor.redColor());
        data.append(UIColor.yellowColor());
        data.append(UIColor.greenColor());
        data.append(UIColor.blueColor());
        data.append(UIColor.purpleColor());
        data.append(UIColor.whiteColor());
        data.append(UIColor.orangeColor());
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
    
        var color = data[indexPath.row];
        
        cell.backgroundColor = color;

        cell.layer.cornerRadius = 10;
        cell.layer.shadowColor = UIColor.blackColor().CGColor;
        cell.layer.shadowOffset = CGSize(width: 0, height: 1);
        cell.layer.shadowOpacity = 0.5;
        cell.layer.masksToBounds = false;
        cell.clipsToBounds = false;

        return cell
    }
}
