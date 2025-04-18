

import UIKit

class FilteredProductCell: UICollectionViewCell {

    @IBOutlet var titleLbl: UILabel!
    
    
    @IBOutlet var descriptionLbl: UILabel!
   
    
    
    @IBOutlet var priceLbl: UILabel!
    

    
    @IBOutlet var img: UIImageView!
    
    
    @IBOutlet var ratingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        img.layer.shadowColor = UIColor.black.cgColor
        img.layer.shadowOpacity = 0.25
        img.layer.shadowOffset = CGSize(width: 0, height: 2)
        img.layer.shadowRadius = 4
        img.layer.cornerRadius = 10 // same as imageView for consistency
        img.layer.masksToBounds = false
    }

    
    
}
