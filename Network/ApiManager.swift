import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    private init() {}

    func fetchProducts(completion: @escaping ([Product]?) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("API Error:", error.localizedDescription)
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(products)
            } catch {
                print("Decoding Error:", error)
                completion(nil)
            }

        }.resume()
    }
}
