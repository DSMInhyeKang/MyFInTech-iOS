import Foundation
import KeychainSwift

enum TokenType {
    case accessToken, refreshToken, empty

    var key: String {
        switch self {
        case .accessToken: return "accessToken"
        case .refreshToken: return "refreshToken"
        case .empty: return "empty"
        }
    }
}

class TokenStorage {
    static let shared = TokenStorage()
    private let keyChain = KeychainSwift()

    private init() {}
    var accessToken: String? {
        get { keyChain.get(TokenType.accessToken.key) }
        set {
            guard let newValue else { return }
            keyChain.set(newValue, forKey: TokenType.accessToken.key)
        }
    }

    var refreshToken: String? {
        get { keyChain.get(TokenType.refreshToken.key) }
        set {
            guard let newValue else { return }
            keyChain.set(newValue, forKey: TokenType.refreshToken.key)
        }
    }
    
    func toHeader(_ tokenType: TokenType) -> [String: String] {
        guard let accessToken = self.accessToken,
              let refreshToken = self.refreshToken
        else {
            return ["Content-type": "application/json"]
        }
        
        switch tokenType {
        case .accessToken:
            return [
                "Content-type": "application/json",
                "Authorization": "Bearer " + accessToken
            ]
        case .refreshToken:
            return [
                "Content-type": "application/json",
                "X-Refresh-Token": refreshToken
            ]
        default:
            return ["Content-type": "application/json"]
        }
    }

    func removeToken() {
        accessToken = nil
        refreshToken = nil
    }
}
