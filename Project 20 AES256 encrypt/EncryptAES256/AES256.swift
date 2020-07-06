
import Foundation
import CommonCrypto

protocol Cryptable {
	func encrypt(_ string: String) throws -> Data
	func decrypt(_ data: Data) throws -> String
}

enum AESError: Swift.Error {
	case invalidKeySize
	case generateRandomIVFailed
	case encryptionFailed
	case decryptionFailed
	case dataToStringFailed
}

struct AES256 {
	private let key: Data
	private let ivSize: Int         = kCCBlockSizeAES128
	private let options: CCOptions  = CCOptions(kCCOptionPKCS7Padding)

	init(keyString: String) throws {
		guard keyString.count == kCCKeySizeAES256 else {
			throw AESError.invalidKeySize
		}
		self.key = Data(keyString.utf8)
	}
}

private extension AES256 {

	func generateRandomIV(for data: inout Data) throws {

		try data.withUnsafeMutableBytes { dataBytes in

			guard let dataBytesBaseAddress = dataBytes.baseAddress else {
				throw AESError.generateRandomIVFailed
			}

			let status: Int32 = SecRandomCopyBytes(
				kSecRandomDefault,
				kCCBlockSizeAES128,
				dataBytesBaseAddress
			)

			guard status == 0 else {
				throw AESError.generateRandomIVFailed
			}
		}
	}
}

extension AES256: Cryptable {

	func encrypt(_ string: String) throws -> Data {
		let dataToEncrypt = Data(string.utf8)

		let bufferSize: Int = ivSize + dataToEncrypt.count + kCCBlockSizeAES128
		var buffer = Data(count: bufferSize)
		try generateRandomIV(for: &buffer)

		var numberBytesEncrypted: Int = 0

		do {
			try key.withUnsafeBytes { keyBytes in
				try dataToEncrypt.withUnsafeBytes { dataToEncryptBytes in
					try buffer.withUnsafeMutableBytes { bufferBytes in

						guard let keyBytesBaseAddress = keyBytes.baseAddress,
							let dataToEncryptBytesBaseAddress = dataToEncryptBytes.baseAddress,
							let bufferBytesBaseAddress = bufferBytes.baseAddress else {
								throw AESError.encryptionFailed
						}

						let cryptStatus: CCCryptorStatus = CCCrypt( // Stateless, one-shot encrypt operation
							CCOperation(kCCEncrypt),                // op: CCOperation
							CCAlgorithm(kCCAlgorithmAES),           // alg: CCAlgorithm
							options,                                // options: CCOptions
							keyBytesBaseAddress,                    // key: the "password"
							key.count,                              // keyLength: the "password" size
							bufferBytesBaseAddress,                 // iv: Initialization Vector
							dataToEncryptBytesBaseAddress,          // dataIn: Data to encrypt bytes
							dataToEncryptBytes.count,               // dataInLength: Data to encrypt size
							bufferBytesBaseAddress + ivSize,        // dataOut: encrypted Data buffer
							bufferSize,                             // dataOutAvailable: encrypted Data buffer size
							&numberBytesEncrypted                   // dataOutMoved: the number of bytes written
						)

						guard cryptStatus == CCCryptorStatus(kCCSuccess) else {
							throw AESError.encryptionFailed
						}
					}
				}
			}

		} catch {
			throw AESError.encryptionFailed
		}

		let encryptedData: Data = buffer[..<(numberBytesEncrypted + ivSize)]
		return encryptedData
	}

	func decrypt(_ data: Data) throws -> String {

		let bufferSize: Int = data.count - ivSize
		var buffer = Data(count: bufferSize)

		var numberBytesDecrypted: Int = 0

		do {
			try key.withUnsafeBytes { keyBytes in
				try data.withUnsafeBytes { dataToDecryptBytes in
					try buffer.withUnsafeMutableBytes { bufferBytes in

						guard let keyBytesBaseAddress = keyBytes.baseAddress,
							let dataToDecryptBytesBaseAddress = dataToDecryptBytes.baseAddress,
							let bufferBytesBaseAddress = bufferBytes.baseAddress else {
								throw AESError.encryptionFailed
						}

						let cryptStatus: CCCryptorStatus = CCCrypt( // Stateless, one-shot encrypt operation
							CCOperation(kCCDecrypt),                // op: CCOperation
							CCAlgorithm(kCCAlgorithmAES128),        // alg: CCAlgorithm
							options,                                // options: CCOptions
							keyBytesBaseAddress,                    // key: the "password"
							key.count,                              // keyLength: the "password" size
							dataToDecryptBytesBaseAddress,          // iv: Initialization Vector
							dataToDecryptBytesBaseAddress + ivSize, // dataIn: Data to decrypt bytes
							bufferSize,                             // dataInLength: Data to decrypt size
							bufferBytesBaseAddress,                 // dataOut: decrypted Data buffer
							bufferSize,                             // dataOutAvailable: decrypted Data buffer size
							&numberBytesDecrypted                   // dataOutMoved: the number of bytes written
						)

						guard cryptStatus == CCCryptorStatus(kCCSuccess) else {
							throw AESError.decryptionFailed
						}
					}
				}
			}
		} catch {
			throw AESError.encryptionFailed
		}

		let decryptedData: Data = buffer[..<numberBytesDecrypted]

		guard let decryptedString = String(data: decryptedData, encoding: .utf8) else {
			throw AESError.dataToStringFailed
		}

		return decryptedString
	}
}


