

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var titleLBL: UILabel!
    
    @IBOutlet weak var priceLBL: UILabel!
    
    @IBOutlet weak var countLBL: UILabel!
    
    @IBOutlet weak var decreaseButton: UIButton!
    
    @IBOutlet weak var increaseButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
