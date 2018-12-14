//
//  SGItemCollectionViewCell.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 07/05/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import UIKit

protocol SGItemCollectionViewCellDelegate: class {
    func deleteItemForId(itemId: Int?)
    func itemCountChanged(itemPrice: Float)
}
//    {
//    "ItemId": 1,
//    "ShopId": 1,
//    "ShopName": "Toys And Games",
//    "ShopNumber": "G-105",
//    "ItemCode": "10011",
//    "ItemBarCode": "",
//    "ItemPrice": 50,
//    "ItemSize": 34,
//    "ItemSizeUnit": "gm",
//    "ItemQuantity": 0,
//    "ItemName": "Bracelet",
//    "ItemDetail": "Because you loved the charm bracelet so much, we now have a NEW addition! Amp up your looks instantly with these stunner charms and versatile bracelets (Psst Shop as many charms as you like to reinvent and renew your looks)",
//    "CategoryName": "General Items",
//    "CategoryId": 1,
//    "ItemImage": "Item-1539368905209.jpg",
//    "ImagePath": "Uploads/Items/"
//    }
class SGItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemId: UILabel!
    @IBOutlet weak var itemRetailPrice: UILabel!
    @IBOutlet weak var itemSalePrice: UILabel!
    @IBOutlet weak var upc: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var ItemDetail: UILabel!
    @IBOutlet weak var itemSize: UILabel!
    var totalItemCount = 0
    weak var delegate: SGItemCollectionViewCellDelegate?
    var itemDetails: SGItems?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func itemCountChanged(_ sender: Any) {
        let btn = sender as! UIButton
        if btn.tag == 0 {
            if totalItemCount == 0 {
                return
            } else if totalItemCount > 0 {
                totalItemCount-=1
                self.delegate?.itemCountChanged(itemPrice: -(self.itemDetails?.salePrice ?? 0.0))
            }
            
        } else if btn.tag == 1 {
            totalItemCount+=1
            self.delegate?.itemCountChanged(itemPrice: (self.itemDetails?.salePrice ?? 0.0))
        }
    }
    
    func configure(itemDetails: SGItems) {
        self.itemDetails = itemDetails
        
        self.itemName.text = itemDetails.name
        self.itemId.text = String(describing: itemDetails.itemId ?? 0)
        self.itemRetailPrice.text = "NA"
        self.itemSalePrice.text = "$" + String(describing: itemDetails.salePrice ?? 0.0)
        self.upc.text = itemDetails.upc
        
        
        if let checkedUrl = URL(string: (itemDetails.thumbnailImage) ?? "") {
            self.itemImageView.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl)
        }
    }
//    {
//    "ItemId": 1,
//    "ShopId": 1,
//    "ShopName": "Toys And Games",
//    "ShopNumber": "G-105",
//    "ItemCode": "10011",
//    "ItemBarCode": "",
//    "ItemPrice": 50,
//    "ItemSize": 34,
//    "ItemSizeUnit": "gm",
//    "ItemQuantity": 0,
//    "ItemName": "Bracelet",
//    "ItemDetail": "Because you loved the charm bracelet so much, we now have a NEW addition! Amp up your looks instantly with these stunner charms and versatile bracelets (Psst Shop as many charms as you like to reinvent and renew your looks)",
//    "CategoryName": "General Items",
//    "CategoryId": 1,
//    "ItemImage": "Item-1539368905209.jpg",
//    "ImagePath": "Uploads/Items/"
//    }
    
//    @IBOutlet weak var ItemDetail: UILabel!
//    @IBOutlet weak var itemSize: UILabel!
    
    func configureItem(itemDetails: SSItemList) {
        
        self.itemName.text = (itemDetails.itemName ?? "") + " - " + (itemDetails.itemCode ?? "")
        self.itemId.text = String(describing: itemDetails.itemId ?? 0)
        self.itemRetailPrice.text = "NA"
        self.itemSalePrice.text = "$" + String(describing: itemDetails.itemPrice ?? 0)
        
        self.shopName.text = (itemDetails.shopName ?? "") + ", " + (itemDetails.shopNumber ?? "")
        self.ItemDetail.text = itemDetails.itemDetail ?? ""
        self.itemSize.text = String(describing: itemDetails.itemSize ?? 0) + " " + (itemDetails.itemSizeUnit ?? "")
        self.upc.text = "NA"
        
        
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
