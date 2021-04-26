
import Foundation
import CommonCrypto

class JZJZEncryption {

    
    static func Encrpt_3DES_CBC(encryptText: String , key: String , iv: String? = nil) -> NSMutableData {
        let inputData : Data = encryptText.data(using: String.Encoding.utf8)!
        let keyData: Data = key.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let keyBytes = UnsafeMutableRawPointer(mutating: (keyData as NSData).bytes)
        let keyLength = size_t(kCCKeySize3DES)
     
        let dataLength = Int(inputData.count)
        let dataBytes = UnsafeRawPointer((inputData as NSData).bytes)
        
        let bufferData = NSMutableData(length: Int(dataLength) + kCCBlockSize3DES )!
        let bufferPointer = UnsafeMutableRawPointer(bufferData.mutableBytes) //指標
        let bufferLength = size_t(bufferData.length)
        var bytesDecrypted = Int(0)
        
        let cryptStatus = CCCrypt(
                UInt32(kCCEncrypt),
                UInt32(kCCAlgorithm3DES),
                UInt32(kCCOptionPKCS7Padding),
                keyBytes,
                keyLength,
                iv,
                dataBytes,
                dataLength,
                bufferPointer,
                bufferLength,
                &bytesDecrypted)
        if Int32(cryptStatus) == Int32(kCCSuccess) {
               bufferData.length = bytesDecrypted

        } else {
           print("加密錯誤: \(cryptStatus)")
        }
        
        return bufferData
    }
}
