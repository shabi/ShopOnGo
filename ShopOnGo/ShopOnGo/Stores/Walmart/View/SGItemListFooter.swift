//
//  SGItemListFooter.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 08/05/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import UIKit

class SGItemListFooter: UICollectionReusableView {
    
    @IBOutlet weak var totalItemCount: UILabel!
    @IBOutlet weak var totalItemsPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureView(itemCount: Int, itemPrice: Float) {
        totalItemCount.text = String(describing: itemCount)
        totalItemsPrice.text = String(describing: itemPrice)

    }
}

