//
//  ThirdCollectionViewController.swift
//  Chumbak Assignment
//
//  Created by GAURAV NAYAK on 07/07/19.
//  Copyright © 2019 CaffeineDevotee. All rights reserved.
//

import UIKit

class ThirdCollectionViewController: UICollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCollectionCell", for: indexPath) as! ThirdCollectionViewCell
        
        cell.imageView.layer.shadowPath = UIBezierPath(roundedRect: cell.imageView.bounds, cornerRadius: cell.imageView.layer.cornerRadius).cgPath
        cell.imageView.layer.shadowColor = UIColor.gray.cgColor
        cell.imageView.layer.shadowOpacity = 0.05
        cell.imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.imageView.layer.shadowRadius = 3
        cell.imageView.layer.masksToBounds = false
        
        return cell
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize.width = min((collectionView?.bounds.size.width)! - 100, 128)
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let bounds = scrollView.bounds
        let xTarget = targetContentOffset.pointee.x
        
        // This is the max contentOffset.x to allow. With this as contentOffset.x, the right edge of the last column of cells is at the right edge of the collection view's frame.
        let xMax = scrollView.contentSize.width - scrollView.bounds.width
        
        if abs(velocity.x) <= snapToMostVisibleColumnVelocityThreshold {
            let xCenter = scrollView.bounds.midX
            let poses = layout.layoutAttributesForElements(in: bounds) ?? []
            // Find the column whose center is closest to the collection view's visible rect's center.
            let x = poses.min(by: { abs($0.center.x - xCenter) < abs($1.center.x - xCenter) })?.frame.origin.x ?? 0
            targetContentOffset.pointee.x = x
        } else if velocity.x > 0 {
            let poses = layout.layoutAttributesForElements(in: CGRect(x: xTarget, y: 0, width: bounds.size.width, height: bounds.size.height)) ?? []
            // Find the leftmost column beyond the current position.
            let xCurrent = scrollView.contentOffset.x
            let x = poses.filter({ $0.frame.origin.x > xCurrent}).min(by: { $0.center.x < $1.center.x })?.frame.origin.x ?? xMax
            targetContentOffset.pointee.x = min(x, xMax)
        } else {
            let poses = layout.layoutAttributesForElements(in: CGRect(x: xTarget - bounds.size.width, y: 0, width: bounds.size.width, height: bounds.size.height)) ?? []
            // Find the rightmost column.
            let x = poses.max(by: { $0.center.x < $1.center.x })?.frame.origin.x ?? 0
            targetContentOffset.pointee.x = max(x, 0)
        }
    }
    
    // Velocity is measured in points per millisecond.
    private var snapToMostVisibleColumnVelocityThreshold: CGFloat { return 0.3 }
    
}
