//
//  SGShopListViewController.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 13/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import UIKit

class SGShopListViewController: UIViewController {
    
    var shopListViewModel: SGShopListViewModel?
    @IBOutlet weak var shopListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shopListViewModel = SGShopListViewModel(viewController: self)
        self.shopListViewModel?.fetchEventInfo()
    }
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        let shopIconCellNib = UINib(nibName: "SGShopIconCell", bundle: nil)
        self.shopListCollectionView.register(
            shopIconCellNib, forCellWithReuseIdentifier: "SGShopIconCell")
        
    }
    
    @IBAction func goToHomePage(_ sender: Any) {
        if let tabBarController = SGUtility.sharedDelegate.window?.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = 0
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension SGShopListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shopListViewModel?.shopList?.shopList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(
            withReuseIdentifier: "SGShopIconCell",
            for: indexPath) as? SGShopIconCell)!
        
        if let shop = self.shopListViewModel?.shopList?.shopList {
            cell.configureItem(shop: shop[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shopNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "SGShopNavigationController") as! UINavigationController
        
        if let shopArray = self.shopListViewModel?.shopList?.shopList, let shopId = shopArray[indexPath.row].shopId, let userId = shopArray[indexPath.row].userId  {
            AppDataManager.shared.userId = userId
            AppDataManager.shared.shopId = shopId
        }
        self.present(shopNavigationController, animated: true, completion: nil)
    }

}


// MARK: - UICollectionViewDelegateFlowLayout
extension SGShopListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120  , height: 100)
        
    }
    
    
}

extension SGShopListViewController: ViewController {
    
    func updateView() {
        self.shopListCollectionView.reloadData()
    }
}


