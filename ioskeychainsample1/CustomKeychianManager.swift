//
//  CustomKeychianManager.swift
//  ioskeychainsample1
//
//  Created by ppengotsu on 2024/05/05.
//

import Foundation

class CustomKeychianManager{
    
    public func isExistData(serviceName:String,keyName:String) -> Bool{
        
        let saveDataDic:[String: Any] = [kSecClass as String:kSecClassGenericPassword
                                         ,kSecAttrService as String : serviceName
                                         ,kSecAttrAccount as String : keyName
                                        ]
        
        
        let matchingStatus = SecItemCopyMatching(saveDataDic as CFDictionary, nil)
        
        switch matchingStatus {
        
            case errSecItemNotFound:
                //データがなかったとき
                return false

            case errSecSuccess:
                //データが存在したとき
                return true
            default:
                return false
        }
    }
    
    
    public func save(serviceName:String,keyName:String,saveValue:String){
        
        let saveDataValue = saveValue.data(using: .utf8)!
        
        let saveDataDic = [kSecClass as String:kSecClassGenericPassword
                                         ,kSecAttrService as String : serviceName
                                         ,kSecAttrAccount as String : keyName
                                         ,kSecValueData  : saveDataValue
                                        ]as CFDictionary
        
        
        let matchingStatus = SecItemCopyMatching(saveDataDic, nil)
        
        switch matchingStatus {
        
            case errSecItemNotFound:
                //データがなかったとき
                SecItemAdd(saveDataDic as CFDictionary, nil)//保存する
                break

            case errSecSuccess:
                //データが存在したとき
                SecItemUpdate(saveDataDic as CFDictionary
                              ,[kSecValueData : saveDataValue] as CFDictionary)//保存データ更新する
                break
            default:
                break
        }
    }
    
    public func read(serviceName:String,keyName:String) -> String?{
        
        let searchDataDic = [kSecClass as String:kSecClassGenericPassword
                                         ,kSecAttrService as String : serviceName
                                         ,kSecAttrAccount as String : keyName
                                        ,kSecReturnData: true
                                        ] as CFDictionary
        
        var result: AnyObject?
        let matchingStatus = SecItemCopyMatching(searchDataDic, &result)
        
        
        
        switch matchingStatus {
        
            case errSecItemNotFound:
                //データがなかったとき
                return ""
            case errSecSuccess:
                //データが存在したとき
            let resultTxt=String(data: result as! Data, encoding: .utf8)
                return resultTxt
            default:
                return ""
        }
    }
    
    
}
