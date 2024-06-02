import Foundation
import Moya

enum UserAPI {
    case register(name: String, email: String, sub: String)
    case signIn(email: String, sub: String)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://localhost:8443")!
    }
    
    var path: String {
        switch self {
        case .register:
            return "/register"
        case .signIn:
            return "/signin"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register, .signIn:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .register(let name, let email, let sub):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "email": email,
                    "sub": sub
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .signIn(let email, let sub):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "sub": sub
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .register, .signIn:
            return TokenStorage.shared.toHeader(.empty)
        }
    }
}
