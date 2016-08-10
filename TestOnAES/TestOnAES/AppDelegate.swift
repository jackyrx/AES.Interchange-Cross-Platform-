//
//  AppDelegate.swift
//  TestOnAES
//
//  Created by Jacky Rx on 10/8/2016.
//  Copyright © 2016 Jacky Rx. All rights reserved.
//

import UIKit
import CryptoSwift

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
            
            let aes = try AES(key: byteKey, iv: iv, blockMode: .CBC)
            var encrypted = try aes.encrypt(byteText)
            
            let strIV = NSData(bytes:iv).base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            print("iv: " + strIV)
            
            let strEnc = NSData(bytes:encrypted).base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            print("encrypted: " + strEnc)
            
            do {
                
//                let key = "57119C07F45756AF6E81E662BE2CCE62"
                let iv = NSData(base64EncodedString: "faMbpBYB8a9v+zcIWXuE8w==", options: NSDataBase64DecodingOptions())!.arrayOfBytes()
                
                encrypted = NSData(base64EncodedString: "oktI4NxPlpZeYVRqDoLPPQ==", options: NSDataBase64DecodingOptions())!.arrayOfBytes()
                
                let aes = try AES(key: byteKey, iv: iv, blockMode: .CBC)
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

