//
//  LoginViewController.swift
//  ChatApp
//
//  Created by 萬木大志 on 2020/03/13.
//  Copyright © 2020 makimaki. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

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
        
        let accountidTextField = UITextField()
        accountidTextField.frame = CGRect(x: 30, y: 300, width: UIScreen.main.bounds.size.width-60, height: 38)
        accountidTextField.placeholder = "メールアドレス"
        accountidTextField.keyboardType = .emailAddress
        accountidTextField.borderStyle = .roundedRect
        accountidTextField.returnKeyType = .done
        accountidTextField.clearButtonMode = .always
        self.view.addSubview(accountidTextField)
        
        let passwordTextField = UITextField()
        passwordTextField.frame = CGRect(x: 30, y: 350, width: UIScreen.main.bounds.size.width-60, height: 38)
        passwordTextField.placeholder = "パスワード"
        passwordTextField.keyboardType = .alphabet
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.returnKeyType = .done
        passwordTextField.clearButtonMode = .always
        self.view.addSubview(passwordTextField)
        
        let authButton = UIButton(frame: CGRect(x: 200,y: 500,width: 200,height: 100))
        authButton.setTitle("OK", for: UIControl.State.normal)
        authButton.sizeToFit()
        authButton.addTarget(self, action: #selector(authButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(authButton)
        
        let toRegisterButton = UIButton(frame: CGRect(x: 120,y: 700,width: 200,height: 100))
        toRegisterButton.setTitle("新規登録の方はこちらへ", for: UIControl.State.normal)
        toRegisterButton.sizeToFit()
        toRegisterButton.addTarget(self, action: #selector(toRegisterButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(toRegisterButton)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func authButtonEvent(_ sender: UIButton) {
        print("button pushed.")
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
