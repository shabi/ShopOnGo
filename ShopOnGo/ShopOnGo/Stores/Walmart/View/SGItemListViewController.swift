//
//  SGItemListViewController.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 07/05/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import BarcodeScanner
import Foundation
import UIKit

class SGItemListViewController: UIViewController {
    var itemViewModel: SGItemViewModel?
    @IBOutlet weak var itemListCollectionView: UICollectionView!
    @IBOutlet weak var totalUsers: UILabel!
    var allItems = [SGItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemViewModel = SGItemViewModel(viewController: self)
//        self.itemViewModel?.fetchEventInfo()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        
        let contactCellNib = UINib(nibName: "SGItemCollectionViewCell", bundle: nil)
        self.itemListCollectionView.register(
            contactCellNib, forCellWithReuseIdentifier: "SGItemCollectionViewCell")
        
        let footerView = UINib(nibName: "SGItemListFooter", bundle: nil)
        self.itemListCollectionView?.register(footerView,
                                          forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                                          withReuseIdentifier: "SGItemListFooter")
    }
    
    @IBAction func handleScannerPresent(_ sender: Any) {
    
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "Walmart Scanner"
        present(viewController, animated: true, completion: nil)
    }
    
    
    private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        return viewController
    }
    
    @IBAction func addItemToCart(_ sender: Any) {
        if let _ = AppDataManager.shared.cartItems, let item = self.itemViewModel?.itemInfo {
            AppDataManager.shared.cartItems?.append(item)
            
        } else if let item = self.itemViewModel?.itemInfo {
            AppDataManager.shared.cartItems = [item]
        }
        if let tabBarController = SGUtility.sharedDelegate.window?.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = 2
        }
    }
}

// MARK: - BarcodeScannerCodeDelegate

extension SGItemListViewController: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("Barcode Data: \(code)")
        print("Symbology Type: \(type)")
        self.itemViewModel?.itemUPCCode = code //"190198051875"//code
        self.itemViewModel?.fetchEventInfo()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            controller.resetWithError()
        }
    }
}

// MARK: - BarcodeScannerErrorDelegate

extension SGItemListViewController: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}

// MARK: - BarcodeScannerDismissalDelegate


extension SGItemListViewController: BarcodeScannerDismissalDelegate {
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
//        self.itemViewModel?.itemUPCCode =  "190198051875"  //"027000390146"   //"190198051875"//code
//        self.itemViewModel?.fetchEventInfo()
        controller.dismiss(animated: true, completion: nil)
        self.itemViewModel?.itemUPCCode = "190198051875"
        self.itemViewModel?.fetchEventInfo()
    }
}

extension SGItemListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1//allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(
            withReuseIdentifier: "SGItemCollectionViewCell",
            for: indexPath) as? SGItemCollectionViewCell)!
        
        if let info = self.itemViewModel?.itemInfo {
            cell.configureItem(itemDetails: info)
        }
//        if self.allItems.count > 0 {
//            cell.delegate = self
//            cell.configure(itemDetails: allItems[indexPath.row])
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView: UICollectionReusableView! = nil
        
        switch kind {
            
        case UICollectionElementKindSectionFooter:
            
            if let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionElementKindSectionFooter,
                withReuseIdentifier: "SGItemListFooter", for: indexPath) as? SGItemListFooter {
                footerView.configureView(itemCount: 0, itemPrice: 0.0)
                reusableView = footerView
            }
            return reusableView
            
            
        default:
            assert(false, "Unexpected element kind")
        }
        return reusableView
        
    }
}

extension SGItemListViewController: SGItemCollectionViewCellDelegate {
    func deleteItemForId(itemId: Int?) {
        
    }
    
    func itemCountChanged(itemPrice: Float) {
        
    }
    

}

// MARK: - UICollectionViewDelegateFlowLayout
extension SGItemListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width  , height: 220)
        return CGSize(width: collectionView.frame.size.width  , height: 500)

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width, height:66.0)
        return CGSize(width: collectionView.frame.size.width, height:0.0)

    }
}

extension SGItemListViewController: ViewController {
    
    func updateView() {
        if self.itemViewModel?.itemAPI?.serviceType == APIConstants.ServiceType.getSItems {
            
        }
        
//        if let item = self.itemViewModel?.itemDetail {
//
////            var itemArray = UserDefaultsWrapper.getObject(key: "keyItemList") as? [SGItems]
////            itemArray = itemArray == nil ? [SGItems]() : itemArray
//            if allItems.count == 0 {
//                allItems.append(item)
//                allItems.insert(item, at: 0)
//                allItems.insert(item, at: 0)
//                allItems.insert(item, at: 0)
//                allItems.insert(item, at: 0)
//                allItems.insert(item, at: 0)
//            } else {
//                allItems.insert(item, at: 0)
//                allItems.insert(item, at: 0)
//                allItems.insert(item, at: 0)
//                allItems.insert(item, at: 0)
//                allItems.insert(item, at: 0)
//            }
////            self.allItems = itemArray
//
////            UserDefaultsWrapper.setObject(key: "keyItemList", value: itemArray as Any)
//            print("Sucess")
//        }
        self.itemListCollectionView.reloadData()
    }
}
