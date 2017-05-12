//
//  ItemCellTableViewCell.swift
//  DreamLister
//
//  Created by Bruno Vargas Versignassi de Carvalho on 14/04/17.
//  Copyright © 2017 Bruno Vargas Versignassi de Carvalho. All rights reserved.
//

import UIKit

class ItemCellTableViewCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
   
    func configureCell(item: Item) {
        
        title.text = item.title
        price.text = "R$ \(item.price)"
        details.text = item.deatails
        thumb.image = item.toImage?.image as? UIImage
    }
}
