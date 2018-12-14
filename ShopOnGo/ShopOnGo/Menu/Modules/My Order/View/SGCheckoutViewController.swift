//
//  SGCheckoutViewController.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 06/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import BarcodeScanner
import Foundation
import UIKit

class SGCheckoutViewController: UIViewController {
    var placeOrderViewModel: SGPlaceOrderViewModel?
    @IBOutlet weak var itemListCollectionView: UICollectionView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var totalCount: UILabel!
    
    var subTotalPrice: Float = 0.0
    var totalItem: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.placeOrderViewModel = SGPlaceOrderViewModel(viewController: self)
//        self.placeOrderViewModel?.fetchEventInfo()
    }
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        self.itemListCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        self.totalCount.text = "Total Item" + "(" + String(describing: self.totalItem) + ")"
        self.subTotal()
        self.totalPrice.text = "$" + String(describing: self.subTotalPrice)
        
        
        let contactCellNib = UINib(nibName: "SGItemCell", bundle: nil)
        self.itemListCollectionView.register(
            contactCellNib, forCellWithReuseIdentifier: "SGItemCell")
    }
    
    @IBAction func placeOrder(_ sender: Any) {
        self.placeOrderViewModel = SGPlaceOrderViewModel(viewController: self)
        self.placeOrderViewModel?.fetchEventInfo()
    }
    
    func subTotal() {
        if let cartItems = AppDataManager.shared.cartItems {
            self.subTotalPrice = Float(cartItems.reduce(0, { $0 + ($1.itemPrice ?? 0)}))
            self.totalItem = cartItems.reduce(1, { $0 + ($1.itemQuantity ?? 1)})
        }
    }
}

extension SGCheckoutViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppDataManager.shared.cartItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(
            withReuseIdentifier: "SGItemCell",
            for: indexPath) as? SGItemCell)!
        
        if let info = AppDataManager.shared.cartItems {
            cell.configureItem(itemDetails: info[indexPath.row])
            cell.indexPath = indexPath
            cell.delegate = self
        }
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension SGCheckoutViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width  , height: 160)
        
    }
}

extension SGCheckoutViewController: ViewController {
    
    func updateView() {
        let thankYouViewController = self.storyboard?.instantiateViewController(withIdentifier: "SGThankYouViewController") as! SGThankYouViewController
        thankYouViewController.placeOrder = self.placeOrderViewModel?.placeOrder
        self.present(thankYouViewController, animated: true, completion: nil)
    }
}

extension SGCheckoutViewController: SGItemCellDelegate {
    
    func itemCountChanged(itemPrice: Float) {
        subTotalPrice = subTotalPrice + itemPrice
        if itemPrice > 0 {
            self.totalItem = self.totalItem + 1
        } else {
            self.totalItem = self.totalItem - 1
        }
        self.totalItem = self.totalItem == 0 ? 1 : self.totalItem
        self.totalCount.text = "Total Item" + "(" + String(describing: self.totalItem) + ")"
        self.totalPrice.text = "$" + String(describing: subTotalPrice)
    }
}
