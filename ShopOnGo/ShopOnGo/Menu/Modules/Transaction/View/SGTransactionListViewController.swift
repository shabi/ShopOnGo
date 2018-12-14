//
//  SGTransactionListViewController.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 25/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import UIKit

class SGTransactionListViewController: UIViewController {
    
    var transactionListViewModel: SGTransactionListViewModel?
    @IBOutlet weak var transactionListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transactionListViewModel = SGTransactionListViewModel(viewController: self)
        self.transactionListViewModel?.fetchEventInfo()
    }
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        let shopIconCellNib = UINib(nibName: "SGTransactionCell", bundle: nil)
        self.transactionListCollectionView.register(
            shopIconCellNib, forCellWithReuseIdentifier: "SGTransactionCell")
        
    }
    
//    @IBAction func goToHomePage(_ sender: Any) {
//        if let tabBarController = SGUtility.sharedDelegate.window?.rootViewController as? UITabBarController {
//            tabBarController.selectedIndex = 0
//        }
//        self.dismiss(animated: true, completion: nil)
//    }
}

extension SGTransactionListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.transactionListViewModel?.transactionList?.transactionList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(
            withReuseIdentifier: "SGTransactionCell",
            for: indexPath) as? SGTransactionCell)!
        
        if let transaction = self.transactionListViewModel?.transactionList?.transactionList {
            cell.configureItem(transaction: transaction[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shopNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "SGShopNavigationController") as! UINavigationController
        
        self.present(shopNavigationController, animated: true, completion: nil)
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension SGTransactionListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 110)
    }
}

extension SGTransactionListViewController: ViewController {
    
    func updateView() {
        self.transactionListCollectionView.reloadData()
    }
}



