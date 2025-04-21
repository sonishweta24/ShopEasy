

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet var iMG: UIImageView!
    
    @IBOutlet var titleLbll: UILabel!
    
    @IBOutlet var descriptionLbll: UILabel!
    
    @IBOutlet var priceLabl: UILabel!
    
    @IBOutlet var ratingLab: UILabel!
    
    @IBOutlet var addcard: UIButton!
    
    @IBOutlet var heartBtn: UIButton!
    
    @IBOutlet var cartCountLabel: UILabel!
    
    @IBOutlet var vieW: UIView!
    var Selectedproduct: Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vieW.layer.cornerRadius = 25
        vieW.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        vieW.clipsToBounds = true

        if let product = Selectedproduct {
            titleLbll.text = product.title
            descriptionLbll.text = product.description
            priceLabl.text = "$\(product.price)"
            ratingLab.text = " \(product.rating.rate)"
            if let imageURL = URL(string: product.image) {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: imageURL) {
                        DispatchQueue.main.async {
                            self.iMG.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
        addcard.layer.cornerRadius = 4
        addcard.layer.shadowColor = UIColor.black.cgColor
        addcard.layer.shadowOpacity = 0.3
        addcard.layer.shadowOffset = CGSize(width: 0, height: 2)
        addcard.layer.shadowRadius = 4
        addcard.layer.masksToBounds = false
        styleLabels(label1: ratingLab, label2: priceLabl)
        updateHeartIcon()
           updateCartCount()
    }
    @IBAction func AddcardAction(_ sender: Any) {
        showAutoDismissAlert()
       }
    func showAutoDismissAlert() {
        let alert = UIAlertController(title: nil, message: "For add item click above heart button", preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            alert.dismiss(animated: true)
        }
    }

    
    @IBAction func heartBtnAction(_ sender: Any) {
        guard let product = Selectedproduct else { return }

           if CartManager.shared.isInCart(product) {
               CartManager.shared.removeFromCart(product)
           } else {
               CartManager.shared.addToCart(product)
           }

           updateHeartIcon()
           updateCartCount()
           NotificationCenter.default.post(name: Notification.Name("cartUpdated"), object: nil)
       }

    func updateHeartIcon() {
        guard let product = Selectedproduct else { return }
        let isInCart = CartManager.shared.isInCart(product)
        heartBtn.tintColor = isInCart ? .red : .gray
        heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }

    func updateCartCount() {
        let count = CartManager.shared.itemCount()
        cartCountLabel.text = "\(count)"
        cartCountLabel.isHidden = count == 0
    }
    func styleLabels(label1: UILabel, label2: UILabel) {
      let labels = [label1, label2]
        for label in labels {
            label.layer.cornerRadius = 4
            label.layer.masksToBounds = false
            label.layer.shadowColor = UIColor.black.cgColor
            label.layer.shadowOffset = CGSize(width: 0, height: 2)
            label.layer.shadowRadius = 4
            label.layer.shadowOpacity = 0.3
        }


        label1.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
        label1.layer.borderWidth = 1.0
    }

}
