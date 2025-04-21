import Foundation


class CartManager {
    static let shared = CartManager()
    private init() {}

    var cartItems: [Product] = []

    func addToCart(_ product: Product) {
        if !cartItems.contains(where: { $0.id == product.id }) {
            cartItems.append(product)
        }
    }

    func removeFromCart(_ product: Product) {
        cartItems.removeAll { $0.id == product.id }
    }

    func isInCart(_ product: Product) -> Bool {
        return cartItems.contains { $0.id == product.id }
    }

    func itemCount() -> Int {
        return cartItems.count
    }
}
