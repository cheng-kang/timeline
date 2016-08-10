//
//  Functions.swift
//  CA
//
//  Created by Ant on 16/7/29.
//  Copyright © 2016年 Ant. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift
import Alamofire
import Wilddog

//import CommonCrypto

func getCustomizedCurrentDatetimeString() -> String {
    let df1 = NSDateFormatter()
    df1.dateFormat = "EEEE"
    
    let df2 = NSDateFormatter()
    df2.dateFormat = "MMMM dd | HH:mm:ss"
    
    let string = NSLocalizedString("Today is ", comment: "DatetimeString") + df1.stringFromDate(NSDate()) + "\n" + df2.stringFromDate(NSDate())
    
    return string
}

func getDaysSinceBeginningOfRelationShip() -> Int {
    
    let df = NSDateFormatter()
    df.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let startDate = df.dateFromString("2016-05-31 00:00:00")
    let diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: startDate!, toDate: NSDate(), options: NSCalendarOptions.init(rawValue: 0))
    
    return diffDateComponents.day
}

func getImageById(id: String, complete: ((image: UIImage?)->())) {
    let ref = Wilddog(url: "https://catherinewei.wilddogio.com/Photos/\(id)")
    ref.observeEventType(.Value) { (snapshot: WDataSnapshot) in
        if snapshot.value != nil {
            let data = snapshot.value as! [String:AnyObject]
            if let count = data["count"]{
                var imageDataString = ""
                for i in 0..<(count as! Int) {
                    imageDataString += data["\(i)"] as! String
                }
                let imageData = NSData(base64EncodedString: imageDataString,
                                       options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                let decodedImage = UIImage(data:imageData!)
                
                complete(image: decodedImage)
                return
            }
        }
        
        complete(image: nil)
    }
}

func getTypeLblText(type: String, subtype: String) -> String {
    
    switch type {
    case "Life":
        if subtype == "Moment" {
            return "M\nO\nM\nE\nN\nT"
        } else if subtype == "Post" {
            return "P\nS\nO\nT"
        }
    case "Event":
        return "E\nV\nE\nN\nT"
    case "Wish":
        return "W\nI\nS\nH"
    default:
        break
    }
    
    return ""
}

func uploadImageAndGetImageId(data: NSData) -> String {
    var ref = Wilddog(url: "https://catherinewei.wilddogio.com/Photos")
    var newChildRef = ref.childByAutoId()
    
    var newPhoto = [
        "createAt": NSDate().timeIntervalSince1970
    ]
    
    newChildRef.setValue(newPhoto)
    
    var chunks = [String: AnyObject]()
    let length = data.length
    let chunkSize = 900000      // 1mb chunk sizes 1048576
    var offset = 0
    var count = 0
    
    repeat {
        // get the length of the chunk
        let thisChunkSize = ((length - offset) > chunkSize) ? chunkSize : (length - offset)
        
        // get the chunk
        let chunk = data.subdataWithRange(NSMakeRange(offset, thisChunkSize))
        
        // -----------------------------------------------
        // do something with that chunk of data...
        // -----------------------------------------------
        chunks["\(count)"] = chunk.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        newChildRef.updateChildValues(["\(count)": chunk.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)])
        
        // update the offset
        offset += thisChunkSize
        count += 1
    } while (offset < length);
    
    chunks["count"] = count
    chunks["creatAt"] = NSDate().timeIntervalSince1970
    newChildRef.updateChildValues(["count": count])
    
    return newChildRef.key
}

func generateQiniuToken(fileNameWithFormat: String) -> String {
    let AccessKey = "VXQRJTMmML8JoXLxCqpeOXu3IsK32UIVke5aRvLe"
    let SecretKey = "UdvV39nYPk58SUmh8J_Oet-BRdD9x_LY1wHHxZlY"
    let Bucket = "chengkang"
    
    let scope = "\(Bucket):\(fileNameWithFormat)"
    let deadline = NSDate(timeIntervalSinceNow: 6000)
    let putPolicy = "{\"scope\":\"\(scope)\",\"deadline\":\(Int(deadline.timeIntervalSince1970)),\"returnBody\":\"{\\\"name\\\":$(fname),\\\"size\\\":$(fsize),\\\"w\\\":$(imageInfo.width),\\\"h\\\":$(imageInfo.height),\\\"hash\\\":$(etag)}\"}"
    
    print("putPolicy: "+putPolicy)
    
    let encodedPutPolicy = putPolicy.dataUsingEncoding(NSUTF8StringEncoding)?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    
    print("encodedPutPolicy: "+encodedPutPolicy!)
    
    
    
    let sign = encodedPutPolicy?.hmac(.SHA1, key: SecretKey)
    
    
    print("sign: "+sign!)

    let encodedSign = sign!.dataFromHexadecimalString()?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    
    print("encodedSign: "+encodedSign!)
    
    let token = "\(AccessKey):\(encodedSign ?? ""):\(encodedPutPolicy ?? "")"
    print("token: "+token)
    
//    test()

    return token
}

func test() {
    let AccessKey = "VXQRJTMmML8JoXLxCqpeOXu3IsK32UIVke5aRvLe"
    let SecretKey = "MY_SECRET_KEY"
    let Bucket = "catherine"
    
    let putPolicy = "{\"scope\":\"my-bucket:sunflower.jpg\",\"deadline\":1451491200,\"returnBody\":\"{\\\"name\\\":$(fname),\\\"size\\\":$(fsize),\\\"w\\\":$(imageInfo.width),\\\"h\\\":$(imageInfo.height),\\\"hash\\\":$(etag)}\"}"
    
    print(putPolicy)
    
    let encodedPutPolicy = putPolicy.dataUsingEncoding(NSUTF8StringEncoding)?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    
    print(encodedPutPolicy ?? "")
    
    let t = encodedPutPolicy?.hmac(.SHA1, key: "MY_SECRET_KEY")
    print(t)
    print(t!.dataUsingEncoding(NSUTF8StringEncoding)?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0)))
    print(t!.dataFromHexadecimalString())
    print(t!.dataFromHexadecimalString()?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0)))
//
//    let a = ""
    
//    let parameters: [String:AnyObject] = [
//        "msg": encodedPutPolicy ?? "",
//        "key": "MY_SECRET_KEY"
//    ]
    
//    Alamofire.request(.GET, "http://weixin.mrliao.cn/hash", parameters: parameters).responseString(completionHandler: { (response) in
//        print(response)
//        print("")
//    })
    
}

enum CryptoAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:		result = kCCHmacAlgMD5
        case .SHA1:		result = kCCHmacAlgSHA1
        case .SHA224:	result = kCCHmacAlgSHA224
        case .SHA256:	result = kCCHmacAlgSHA256
        case .SHA384:	result = kCCHmacAlgSHA384
        case .SHA512:	result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    typealias DigestAlgorithm = (UnsafePointer<Void>, CC_LONG, UnsafeMutablePointer<CUnsignedChar>) -> UnsafeMutablePointer<CUnsignedChar>
    
    var digestAlgorithm: DigestAlgorithm {
        switch self {
        case .MD5:      return CC_MD5
        case .SHA1:     return CC_SHA1
        case .SHA224:   return CC_SHA224
        case .SHA256:   return CC_SHA256
        case .SHA384:   return CC_SHA384
        case .SHA512:   return CC_SHA512
        }
    }
    
    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:		result = CC_MD5_DIGEST_LENGTH
        case .SHA1:		result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:	result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:	result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:	result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:	result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

extension String {
    
    // MARK: HMAC
    
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = Int(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        let keyStr = key.cStringUsingEncoding(NSUTF8StringEncoding)
        let keyLen = Int(key.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        
        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
        
        let digest = stringFromResult(result, length: digestLen)
        
        result.dealloc(digestLen)
        
        return digest
    }
    
    // MARK: Digest
    
    var md5: String {
        return digest(.MD5)
    }
    
    var sha1: String {
        return digest(.SHA1)
    }
    
    var sha224: String {
        return digest(.SHA224)
    }
    
    var sha256: String {
        return digest(.SHA256)
    }
    
    var sha384: String {
        return digest(.SHA384)
    }
    
    var sha512: String {
        return digest(.SHA512)
    }
    
    func digest(algorithm: CryptoAlgorithm) -> String {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        algorithm.digestAlgorithm(str!, strLen, result)
        
        let digest = stringFromResult(result, length: digestLen)
        
        result.dealloc(digestLen)
        
        return digest
    }
    
    // MARK: Private
    
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
    
}























