//
//  SGItemDetail.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 11/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import UIKit

protocol SGItemCellDelegate: class {
//    func deleteItemForId(itemId: Int?)
    func itemCountChanged(itemPrice: Float)
}

class SGItemCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemSalePrice: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var itemSize: UILabel!
    var totalItemCount = 1
    var indexPath: IndexPath?
    
    weak var delegate: SGItemCellDelegate?
    var itemDetails: SSItemList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func itemCountChanged(_ sender: Any) {
        let price = AppDataManager.shared.cartItems?[self.indexPath?.row ?? 0].itemPrice
        let btn = sender as! UIButton
        if btn.tag == 0 {
            
            if totalItemCount == 1 {
                return
            } else if totalItemCount > 0 {
                totalItemCount-=1
                self.delegate?.itemCountChanged(itemPrice: Float(-1*(price ?? 0)))
            }
            
        } else if btn.tag == 1 {
            totalItemCount+=1
            self.delegate?.itemCountChanged(itemPrice: Float(price ?? 0))
        }
        self.itemSalePrice.text = "$" + String(describing: (price ?? 0) * totalItemCount)
        self.itemCount.text = String(describing: self.totalItemCount)
    }
  
    
    func configureItem(itemDetails: SSItemList) {
        self.itemName.text = (itemDetails.itemName ?? "") + " - " + (itemDetails.itemCode ?? "")
        self.itemSalePrice.text = "$" + String(describing: itemDetails.itemPrice ?? 0)
        self.itemCount.text = String(describing: self.totalItemCount)
        self.itemSize.text = String(describing: itemDetails.itemSize ?? 0) + " " + (itemDetails.itemSizeUnit ?? "")
        
        //        if let checkedUrl = URL(string: (itemDetails.thumbnailImage) ?? "") {
        //            self.itemImageView.contentMode = .scaleAspectFit
        //            downloadImage(url: checkedUrl)
        //        }
    }
    
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.itemImageView.image = UIImage(data: data)
            }
        }
    }
}

