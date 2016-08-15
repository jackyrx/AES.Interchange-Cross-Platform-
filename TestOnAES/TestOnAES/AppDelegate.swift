//
//  AppDelegate.swift
//  TestOnAES
//
//  Created by Jacky Rx on 10/8/2016.
//  Copyright © 2016 Jacky Rx. All rights reserved.
//

import UIKit
import CryptoSwift

extension String {
//    Ref: http://stackoverflow.com/questions/26501276/converting-hex-string-to-nsdata-in-swift
    func dataWithHexString() -> NSData {
        var hex = self
        let data = NSMutableData()
        while(hex.characters.count > 0) {
            let c: String = hex.substringToIndex(hex.startIndex.advancedBy(2))
            hex = hex.substringFromIndex(hex.startIndex.advancedBy(2))
            var ch: UInt32 = 0
            NSScanner(string: c).scanHexInt(&ch)
            data.appendBytes(&ch, length: 1)
        }
        return data
    }
}

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        let data = "Hello World"
        let byteText = data.dataUsingEncoding(NSUTF8StringEncoding)!.arrayOfBytes()
        
        let key = "57119C07F45756AF6E81E662BE2CCE62"
        let byteKey = key.dataUsingEncoding(NSUTF8StringEncoding)!.arrayOfBytes()

        let iv = AES.randomIV(AES.blockSize)
        
        do {
            
            let aes = try AES(key: byteKey, iv: iv, blockMode: .CBC, padding: PKCS7())
            
            var encrypted = try aes.encrypt(byteText)
            
            let strIV = NSData(bytes:iv).base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            print("iv: " + strIV)
            
            let strEnc = NSData(bytes:encrypted).base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            print("encrypted: " + strEnc)
            
            print("=====================================================")
            
            do {
                
                let key = "57119C07F45756AF6E81E662BE2CCE62"
                let byteKey = key.dataUsingEncoding(NSUTF8StringEncoding)!.arrayOfBytes()
                
                let raw_iv_data = "b35cf5ec81bdf0f875e0bef34eaa116e".dataWithHexString()
                let hex_iv = raw_iv_data.toHexString()
                
                let base64_iv = raw_iv_data.arrayOfBytes().toBase64()!
//                let base64_iv = "s1z17IG98Ph14L7zTqoRbg=="
                
                print("base64_iv: \(base64_iv)")
                
                let iv = NSData(base64EncodedString: base64_iv, options: NSDataBase64DecodingOptions())!.arrayOfBytes()
                
                let raw_encrypted = "25be364c760f457ef6eaee6bbc82ad7d".dataWithHexString()
                let hex_encrypted = raw_encrypted.toHexString()
                
                let base64_encrypted = raw_encrypted.arrayOfBytes().toBase64()!
//                let base64_encrypted = "Jb42THYPRX726u5rvIKtfQ=="
                
                print("base64_encrypted: \(base64_encrypted)")
                
//                let tmp_iv = NSData(base64EncodedString: "s1z17IG98Ph14L7zTqoRbg==", options: NSDataBase64DecodingOptions())!.arrayOfBytes().toHexString()
//                print("tmp_iv: \(tmp_iv)")
//                
//                let tmp_encrypted = NSData(base64EncodedString: "Jb42THYPRX726u5rvIKtfQ==", options: NSDataBase64DecodingOptions())!.arrayOfBytes().toHexString()
//                print("tmp_encrypted: \(tmp_encrypted)")
                
                encrypted = NSData(base64EncodedString: base64_encrypted, options: NSDataBase64DecodingOptions())!.arrayOfBytes()
                
                let aes = try AES(key: byteKey, iv: iv, blockMode: .CBC, padding: PKCS7())
                let decrypted = try aes.decrypt(encrypted)
            
                if let strDec = String(bytes: decrypted, encoding: NSUTF8StringEncoding) {
                    print("decrypted: " + strDec)
                } else {
                    print("not a valid UTF-8 sequence")
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch {
            print("Error")
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

