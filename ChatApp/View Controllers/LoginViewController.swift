//
//  LoginViewController.swift
//  ChatApp
//
//  Created by 萬木大志 on 2020/03/13.
//  Copyright © 2020 makimaki. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    let accountidTextField = UITextField()
    let passwordTextField = UITextField()
    let a_errMessage: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 400,height: 25))
    let p_errMessage: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 300,height: 25))
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
        titleLabel.text = "Chat App"
        titleLabel.font = titleLabel.font.withSize(40.0)
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 200)
        self.view.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
        self.view.addSubview(titleLabel)
        
        accountidTextField.frame = CGRect(x: 30, y: 300, width: UIScreen.main.bounds.size.width-60, height: 38)
        accountidTextField.placeholder = "アカウントID"
        accountidTextField.keyboardType = .emailAddress
        accountidTextField.autocapitalizationType = .none
        accountidTextField.borderStyle = .roundedRect
        accountidTextField.returnKeyType = .done
        accountidTextField.clearButtonMode = .always
        self.accountidTextField.delegate = self
        self.view.addSubview(accountidTextField)
        
        passwordTextField.frame = CGRect(x: 30, y: 350, width: UIScreen.main.bounds.size.width-60, height: 38)
        passwordTextField.placeholder = "パスワード"
        passwordTextField.keyboardType = .alphabet
        //passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.returnKeyType = .done
        passwordTextField.clearButtonMode = .always
        self.passwordTextField.delegate = self
        self.view.addSubview(passwordTextField)
        
        let authButton = UIButton(frame: CGRect(x: 175,y: 450,width: 200,height: 100))
        authButton.setTitle("OK", for: UIControl.State.normal)
        authButton.sizeToFit()
        authButton.addTarget(self, action: #selector(authButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(authButton)
        
        let toRegisterButton = UIButton(frame: CGRect(x: 100,y: 600,width: 200,height: 100))
        toRegisterButton.setTitle("新規登録の方はこちらへ", for: UIControl.State.normal)
        toRegisterButton.sizeToFit()
        toRegisterButton.addTarget(self, action: #selector(toRegisterButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(toRegisterButton)
        
        // Firestore関連
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // キーボード以外をタッチすることでキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (accountidTextField.isFirstResponder) {
            accountidTextField.resignFirstResponder()
        } else if (passwordTextField.isFirstResponder) {
            passwordTextField.resignFirstResponder()
        }
    }
    
    // リターンキーでキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        accountidTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    @objc func authButtonEvent(_ sender: UIButton) {
        let launchVC = LaunchViewController()
        var errcount = 0
        
        if let accountid = accountidTextField.text {
            if accountid.count == 0 {
                a_errMessage.text = "アカウントIDが未入力です"
                errcount += 1
            } else {
                a_errMessage.text = ""
            }
            a_errMessage.font = a_errMessage.font.withSize(20.0)
            a_errMessage.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            a_errMessage.textAlignment = NSTextAlignment.center
            a_errMessage.layer.position = CGPoint(x: self.view.bounds.width/2,y: 410)
            self.view.addSubview(a_errMessage)
        }
        
        if let password = passwordTextField.text {
            if password.count == 0 {
                p_errMessage.text = "パスワードが未入力です"
                errcount += 1
            } else {
                p_errMessage.text = ""
            }
            p_errMessage.font = p_errMessage.font.withSize(20.0)
            p_errMessage.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            p_errMessage.textAlignment = NSTextAlignment.center
            p_errMessage.layer.position = CGPoint(x: self.view.bounds.width/2,y: 435)
            self.view.addSubview(p_errMessage)
        }
        if errcount > 0 {
            errcount = 0
            return
        } else {
            let accountid = accountidTextField.text!
            let docRef = db.collection("users").document(accountid)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    print("アカウントは合っている")
                    //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    let dataDescription = document.get("password") as? String
                    print(type(of: dataDescription))
                    
                    let password = self.passwordTextField.text
                    if password == dataDescription {
                        print("パスワードも合っているよ")
                        self.navigationController?.pushViewController(launchVC, animated: true)
                    } else {
                        print("パスワードが合っていないよ")
                    }
                    
                } else {
                    print("アカウントIDもしくはパスワードが間違っています")
                    self.a_errMessage.text = "アカウントIDまたはパスワードが間違っています"
                    self.a_errMessage.font = self.a_errMessage.font.withSize(15.0)
                    self.a_errMessage.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
                    self.a_errMessage.textAlignment = NSTextAlignment.center
                    self.a_errMessage.layer.position = CGPoint(x: self.view.bounds.width/2,y: 410)
                    self.view.addSubview(self.a_errMessage)
                }
            }
        }
    }
    
    @objc func toRegisterButtonEvent(_ sender: UIButton) {
        print("to RegisterPage")
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
