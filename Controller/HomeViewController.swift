

import UIKit


class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var offersBtn: UIButton!
    
    
    @IBOutlet var bellBtn: UIButton!
    
    
    @IBOutlet var searchbar: UISearchBar!
    

    
    @IBOutlet var VIEw: UIView!
    
    
    @IBOutlet var LBL: UILabel!
    
    
    @IBOutlet var VIEW1: UIView!
    
    
    @IBOutlet var VIEW2: UIView!
    
    
    
    @IBOutlet var collectionVIEW: UICollectionView!
    
    
    @IBOutlet var collectionView2: UICollectionView!
    var products: [Product] = []
    var allProducts: [Product] = []
    var filteredProducts: [Product] = []
    var categories: [String] = []
    var selectedCategory: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircularButtons()
        self.searchbar.delegate = self
        styleLabel()
        
   
        collectionVIEW.delegate = self
        collectionVIEW.dataSource = self
        collectionView2.delegate = self
        collectionView2.dataSource = self
        fetchProductData()

    }


    func fetchProductData() {
            ApiManager.shared.fetchProducts { [weak self] result in
                guard let self = self, let result = result else { return }
                DispatchQueue.main.async {
                    self.products = result
                    self.categories = Array(Set(result.map { $0.category }))
                    self.selectedCategory = self.categories.first ?? ""
                    self.filteredProducts = result.filter { $0.category == self.selectedCategory }
                    self.collectionVIEW.reloadData()
                    self.collectionView2.reloadData()
                }
            }
        }

    func setupCircularButtons() {
     
        offersBtn.layer.cornerRadius = 19.5
        offersBtn.clipsToBounds = true
        
        bellBtn.layer.cornerRadius = 19.5
        bellBtn.clipsToBounds = true
        
        customizeSearchBarVIEw()
        
    }
    
    func customizeSearchBarVIEw() {
    
        searchbar.searchBarStyle = .minimal
        searchbar.placeholder = "Search the entire shop"
        searchbar.barTintColor = .clear
        searchbar.backgroundColor = .clear
        
       
        if let textField = searchbar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.systemGray5
            textField.layer.cornerRadius = 20
            textField.clipsToBounds = true
            textField.font = UIFont.systemFont(ofSize: 16)
            textField.textColor = .gray
            textField.leftView?.tintColor = .gray
            
     
            textField.layer.shadowColor = UIColor.black.cgColor
            textField.layer.shadowOffset = CGSize(width: 0, height: 1)
            textField.layer.shadowOpacity = 0.1
            textField.layer.shadowRadius = 4
            textField.layer.masksToBounds = false
        }
        
        
        VIEw.layer.cornerRadius = 10
        VIEw.layer.masksToBounds = false
        VIEw.layer.shadowColor = UIColor.black.cgColor
        VIEw.layer.shadowOffset = CGSize(width: 0, height: 1)
        VIEw.layer.shadowOpacity = 0.1
        VIEw.layer.shadowRadius = 4
        configureCornerRadii()
    }
    
    
    func configureCornerRadii() {
            let radius: CGFloat = 25

            VIEW1.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: radius)

        
            VIEW2.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: radius)
        }
    func styleLabel() {
          
          let fullText = "Delivery is 50% cheaper"
          let attributedString = NSMutableAttributedString(string: fullText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
          let boldFont = UIFont.boldSystemFont(ofSize: 17)
          let range = (fullText as NSString).range(of: "50%")
          attributedString.addAttribute(NSAttributedString.Key.font, value: boldFont, range: range)
          attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0), range: range)
          attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)

          LBL.attributedText = attributedString
          LBL.textAlignment = .left
          LBL.backgroundColor = .clear
          LBL.numberOfLines = 0
      }
    
    
    
    @IBAction func OfferAction(_ sender: Any) {
        showAlert(title: "Offer", message: "You tapped the Offer button.")
    }
    
    @IBAction func bellAction(_ sender: Any) {
        showAlert(title: "Notifications", message: "You tapped the Bell button.")
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionVIEW {
            return products.count
        } else {
            return filteredProducts.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionVIEW {
          
            let cell = collectionVIEW.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            let product = products[indexPath.item]
            cell.categoryLabel.text = product.category

            if let imageURL = URL(string: product.image) {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: imageURL) {
                        DispatchQueue.main.async {
                            cell.productImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }
            return cell
        } else {
            let cell = collectionView2.dequeueReusableCell(withReuseIdentifier: "FilteredProductCell", for: indexPath) as! FilteredProductCell
            let product = filteredProducts[indexPath.item]
            
            cell.titleLbl.text = product.title
            cell.descriptionLbl.text = product.description
            cell.priceLbl.text = "$\(product.price)"
            cell.ratingLbl.text = " \(product.rating.rate)"
            
            if let imageURL = URL(string: product.image) {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: imageURL) {
                        DispatchQueue.main.async {
                            cell.img.image = UIImage(data: imageData)
                        }
                    }
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionVIEW {
            let selected = products[indexPath.item].category
            selectedCategory = selected
            filteredProducts = products.filter { $0.category == selected }
            collectionView2.reloadData()
        } else if collectionView == collectionView2 {

            let selectedProduct = filteredProducts[indexPath.item]

           
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let productVC = storyboard.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
                
                productVC.Selectedproduct = selectedProduct

                navigationController?.pushViewController(productVC, animated: true)
            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionView2 {
            let padding: CGFloat = 30
            let collectionViewSize = collectionView.frame.size.width - padding
            let cellWidth = collectionViewSize / 2
            return CGSize(width: cellWidth, height: 250)
        } else {
            return CGSize(width: 120, height: 140)
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == collectionView2 ? 10 : 0
    }

  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == collectionView2 ? 10 : 0
    }

   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionView == collectionView2 ? UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) : .zero
    }


}
extension HomeViewController: UISearchBarDelegate{
    
}

extension UIView {
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
}

