
import Foundation

enum AppConfig {
    static var baseURL: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            fatalError("API_BASE_URL not found in Config.plist")
        }
        return url
    }
}
