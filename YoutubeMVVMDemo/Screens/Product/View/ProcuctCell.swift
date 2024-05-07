//
//  ProcuctCell.swift
//  YoutubeMVVMDemo
//
//  Created by Siddharth Adhvaryu on 29/04/24.
//

import UIKit

class ProcuctCell: UITableViewCell {
    
    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productTitleLbl: UILabel!
    @IBOutlet weak var productCategoryLbl: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    
    var product: Product? {
        didSet { productDetailConfiguration() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func productDetailConfiguration() {
        guard let product else { return }
        productTitleLbl.text = product.title
        productCategoryLbl.text = product.category
        descriptionLbl.text = product.description
        priceLbl.text = "$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImage.setImage(with: product.image)
    }
}
