
import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        productImageView.layer.cornerRadius = productImageView.frame.size.width / 2
        productImageView.clipsToBounds = true
        productImageView.layer.borderWidth = 2
        productImageView.layer.borderColor = UIColor.white.cgColor

    }

}
