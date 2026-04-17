
import Foundation

class GetPassKitDataIssuerHostInteractor {
    func execute(request: IssuerRequest, onFinish: (IssuerResponse) -> ()) {
        // todo: Here goes your implementation thar connect with your IssuerHost
        let response = IssuerResponse(activationData: Data(),
                                      ephemeralPublicKey: Data(),
                                      encryptedPassData: Data())
        onFinish(response)
    }
}
