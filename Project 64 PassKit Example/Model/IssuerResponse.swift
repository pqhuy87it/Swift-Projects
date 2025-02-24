import Foundation

struct IssuerResponse {
    let activationData: Data
    let ephemeralPublicKey: Data
    let encryptedPassData: Data
}
