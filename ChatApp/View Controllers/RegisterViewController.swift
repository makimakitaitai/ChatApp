//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by 萬木大志 on 2020/03/15.
//  Copyright © 2020 makimaki. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {

    let userIDTextField = UITextField()
    let nicknameTextField = UITextField()
    let passwordTextField = UITextField()
    var emailTextField = UITextField()
    let scrollView = UIScrollView()
    
    let maxLength: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = self.view.frame
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize(width:self.view.frame.width, height:1000)
        self.view.addSubview(scrollView)
        
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
        titleLabel.text = "ユーザ登録"
        titleLabel.font = titleLabel.font.withSize(40.0)
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 200)
        self.view.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
        self.view.addSubview(titleLabel)
        scrollView.addSubview(titleLabel)
        
        userIDTextField.frame = CGRect(x: 30, y: 300, width: UIScreen.main.bounds.size.width-60, height: 38)
        userIDTextField.placeholder = "アカウントID(20文字まで)"
        userIDTextField.keyboardType = .default
        userIDTextField.autocapitalizationType = .none
        userIDTextField.borderStyle = .roundedRect
        userIDTextField.returnKeyType = .done
        userIDTextField.clearButtonMode = .always
        userIDTextField.tag = 1
        
        self.userIDTextField.delegate = self
        self.view.addSubview(userIDTextField)
        scrollView.addSubview(userIDTextField)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textLength20(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: userIDTextField)
        
        nicknameTextField.frame = CGRect(x: 30, y: 350, width: UIScreen.main.bounds.size.width-60, height: 38)
        nicknameTextField.placeholder = "ニックネーム(20文字まで)"
        nicknameTextField.keyboardType = .default
        nicknameTextField.borderStyle = .roundedRect
        nicknameTextField.returnKeyType = .done
        nicknameTextField.clearButtonMode = .always
        nicknameTextField.tag = 1
        
        NotificationCenter.default.addObserver(self, selector: #selector(textLength20(notification:)),
        name: UITextField.textDidChangeNotification,
        object: nicknameTextField)
        
        self.nicknameTextField.delegate = self
        self.view.addSubview(nicknameTextField)
        scrollView.addSubview(nicknameTextField)
        
        passwordTextField.frame = CGRect(x: 30, y: 400, width: UIScreen.main.bounds.size.width-60, height: 38)
        passwordTextField.placeholder = "パスワード(8文字以上)"
        passwordTextField.keyboardType = .alphabet
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.returnKeyType = .done
        passwordTextField.clearButtonMode = .always
        passwordTextField.tag = 2
        
        self.passwordTextField.delegate = self
        self.view.addSubview(passwordTextField)
        scrollView.addSubview(passwordTextField)
        
        emailTextField.frame = CGRect(x: 30, y: 450, width: UIScreen.main.bounds.size.width-60, height: 38)
        emailTextField.placeholder = "メールアドレス"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.borderStyle = .roundedRect
        emailTextField.returnKeyType = .done
        emailTextField.clearButtonMode = .always
        emailTextField.tag = 3
        
        self.emailTextField.delegate = self
        self.view.addSubview(emailTextField)
        scrollView.addSubview(emailTextField)
        
        let authButton = UIButton(frame: CGRect(x: 175,y: 500,width: 200,height: 100))
        authButton.setTitle("OK", for: UIControl.State.normal)
        authButton.sizeToFit()
        authButton.addTarget(self, action: #selector(authButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(authButton)
        scrollView.addSubview(authButton)
        

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

    emailTextField = textField
       return true
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(RegisterViewController.handleKeyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(RegisterViewController.handleKeyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func handleKeyboardWillShowNotification(_ notification: Notification) {


        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let myBoundSize: CGSize = UIScreen.main.bounds.size

        let txtLimit = emailTextField.frame.origin.y + emailTextField.frame.height + 100.0
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height

         print("テキストフィールドの下辺：(\(txtLimit))")
         print("キーボードの上辺：(\(kbdLimit))")


        if txtLimit >= kbdLimit {
            scrollView.contentOffset.y = txtLimit - kbdLimit
        }
    }
    
    @objc func handleKeyboardWillHideNotification(_ notification: Notification) {
        scrollView.contentOffset.y = 0
    }
    
    // キーボード以外をタッチすることでキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (userIDTextField.isFirstResponder) {
            userIDTextField.resignFirstResponder()
        } else if (nicknameTextField.isFirstResponder) {
            nicknameTextField.resignFirstResponder()
        } else if (passwordTextField.isFirstResponder) {
            passwordTextField.resignFirstResponder()
        } else if (emailTextField.isFirstResponder) {
            emailTextField.resignFirstResponder()
        }
    }
    
    // リターンキーでキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userIDTextField.resignFirstResponder()
        nicknameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        return true
    }
    
    // 文字数制限
    @objc func textLength20(notification: NSNotification) {
        let textField = notification.object as! UITextField

        if let text = textField.text {
            if textField.markedTextRange == nil && text.count > maxLength {
                textField.text = text.prefix(maxLength).description
            }
        }
    }
    
    @objc func authButtonEvent(_ sender: UIButton) {
        print("to Confirm page")
        let confirmVC = RegisterConfirmViewController()
        
        confirmVC.userID = userIDTextField.text!
        confirmVC.nickname = nicknameTextField.text!
        confirmVC.password = passwordTextField.text!
        confirmVC.email = emailTextField.text!
        print(type(of: confirmVC.userID))
        print(type(of: confirmVC.nickname))
        print(type(of: confirmVC.password))
        print(type(of: confirmVC.email))
        self.navigationController?.pushViewController(confirmVC, animated: true)
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
