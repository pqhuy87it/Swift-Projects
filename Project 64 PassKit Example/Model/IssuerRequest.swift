import Foundation

struct IssuerRequest {
    let certificates: [Data]
    let nonce: Data
    let nonceSignature: Data
    
    // todo: Another data that your IssuerHost needs
}
