import Foundation

struct MovieRequest: NetworkRequest {
    var path: String {
        return "/upcoming"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]?
    
    var params: [String : Any?]? = ["api_key": "da9bc8815fb0fc31d5ef6b3da097a009"]
    
    var accessToken: String?
    
    var port: String?
    
    
}
