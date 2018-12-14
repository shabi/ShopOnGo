//
//  SGThankYouViewController.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 12/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import UIKit

class SGThankYouViewController: UIViewController {
    var placeOrder: SSPlaceOrder?
    @IBOutlet weak var itemListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        let itemPurchasedCellNib = UINib(nibName: "SGItemPurchasedCell", bundle: nil)
        self.itemListCollectionView.register(
            itemPurchasedCellNib, forCellWithReuseIdentifier: "SGItemPurchasedCell")
        let itemPurchasedHeaderNib = UINib(nibName: "SGItemPurchasedHeader", bundle: nil)
        self.itemListCollectionView.register(itemPurchasedHeaderNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SGItemPurchasedHeader")
        let orderPlacedSummaryHeaderNib = UINib(nibName: "SGOrderPlacedSummaryHeader", bundle: nil)
        self.itemListCollectionView.register(orderPlacedSummaryHeaderNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SGOrderPlacedSummaryHeader")
        
    }
    
    @IBAction func goToHomePage(_ sender: Any) {
        if let tabBarController = SGUtility.sharedDelegate.window?.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = 0
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension SGThankYouViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return AppDataManager.shared.cartItems?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(
            withReuseIdentifier: "SGItemPurchasedCell",
            for: indexPath) as? SGItemPurchasedCell)!
        
        if let info = AppDataManager.shared.cartItems {
            cell.configureItem(itemDetails: info[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView: UICollectionReusableView! = nil
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            if indexPath.section == 0 {
                if let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SGOrderPlacedSummaryHeader", for: indexPath) as? SGOrderPlacedSummaryHeader {
                    reusableView.configureView(orderId: self.placeOrder?.orderId ?? "", shopName: AppDataManager.shared.cartItems?.first?.shopName ?? "")
                    return reusableView
                }
                
            } else if indexPath.section == 1 {
                reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SGItemPurchasedHeader", for: indexPath)
            }
            
            return reusableView
            
        case UICollectionElementKindSectionFooter:
            
            return reusableView
            
        default:
            assert(false, "Unexpected element kind")
            return reusableView
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension SGThankYouViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width  , height: 44)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.size.width  , height: 200)
        } else if section == 1 {
            return CGSize(width: collectionView.frame.size.width  , height: 50)
        }
        return CGSize.zero
    }
}

extension SGThankYouViewController: ViewController {
    
    func updateView() {
        self.itemListCollectionView.reloadData()
    }
}

