//
//  ViewController.swift
//  ioskeychainsample1
//
//  Created by ppengotsu on 2024/05/05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var _logLabel:UILabel!
    @IBOutlet weak var _inputField:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        _inputField.text=dateFormatter.string(from: date)
    }
    
    
    @IBAction func onTouchedSaveButton(_ sender:Any){
        let customKeychainManager = CustomKeychianManager()
        
        let serviceName = Bundle.main.bundleIdentifier! ;
        
        print("保存します")
        customKeychainManager.save(serviceName: serviceName, keyName: "test2", saveValue: _inputField.text!)
    }
    
    @IBAction func onTouchedReadButton(_ sender:Any){
        let customKeychainManager = CustomKeychianManager()
        
        let serviceName = Bundle.main.bundleIdentifier! ;
        
        if(customKeychainManager.isExistData(serviceName: serviceName, keyName: "test2") == true){
            print("読み込みます")
            let savedTxt:String? = customKeychainManager.read(serviceName: serviceName, keyName: "test2")
            if(savedTxt != nil){
                _logLabel.text = savedTxt
            }else{
                _logLabel.text = ""
            }
        }
    }

    @IBAction func onEndEdit(_ sender: Any) {
        

    }
    
}

