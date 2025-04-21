

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var MyTable: UITableView!
    
    
    
    @IBOutlet var VIEW1: UIView!
    
    @IBOutlet var VIEW2: UIView!
    
    @IBOutlet var LBL: UILabel!
    
    
    
    @IBOutlet var checkoutBtn: UIButton!
    
    var cartItems: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        MyTable.delegate = self
        MyTable.dataSource = self
        
        
        LBL.layer.cornerRadius = 5
        LBL.layer.masksToBounds = true

        LBL.layer.shadowColor = UIColor.black.cgColor
        LBL.layer.shadowOpacity = 0.2
        LBL.layer.shadowOffset = CGSize(width: 0, height: 1)
        LBL.layer.shadowRadius = 4
        LBL.layer.masksToBounds = false

        
        checkoutBtn.layer.cornerRadius = 4
        checkoutBtn.layer.shadowColor = UIColor.black.cgColor
        checkoutBtn.layer.shadowOpacity = 0.3
        checkoutBtn.layer.shadowOffset = CGSize(width: 0, height: 2)
        checkoutBtn.layer.shadowRadius = 4
        checkoutBtn.layer.masksToBounds = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartItems = CartManager.shared.cartItems
        MyTable.reloadData()
        configureCornerRadii()
    }
    @IBAction func checkoutButtonAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Thank You!", message: "Your order has been placed successfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func configureCornerRadii() {
            let radius: CGFloat = 25

         
            VIEW1.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: radius)

         
            VIEW2.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: radius)
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = MyTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }

        let product = cartItems[indexPath.row]
        cell.titleLBL.text = product.title
        cell.priceLBL.text = "$\(product.price)"

     
        if let url = URL(string: product.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.productImg.image = image
                    }
                }
            }
        } 

        return cell
    }


}
