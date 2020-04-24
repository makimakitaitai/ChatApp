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
    let useridLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 300,height: 25))
    let nicknameLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 300,height: 25))
    let passwordLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 300,height: 25))
    let emailLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 300,height: 25))
    
    let maxLength: Int = 20
    var db: Firestore!
    
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
        titleLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 100)
        self.view.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
        self.view.addSubview(titleLabel)
        scrollView.addSubview(titleLabel)
        
        userIDTextField.frame = CGRect(x: 30, y: 150, width: UIScreen.main.bounds.size.width-60, height: 38)
        userIDTextField.placeholder = "アカウントID(英数字かつ20文字以下)"
        userIDTextField.keyboardType = .alphabet
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
        
        nicknameTextField.frame = CGRect(x: 30, y: 200, width: UIScreen.main.bounds.size.width-60, height: 38)
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
        
        passwordTextField.frame = CGRect(x: 30, y: 250, width: UIScreen.main.bounds.size.width-60, height: 38)
        passwordTextField.placeholder = "パスワード(8文字以上)"
        passwordTextField.keyboardType = .alphabet
        //passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.returnKeyType = .done
        passwordTextField.clearButtonMode = .always
        passwordTextField.tag = 2
        
        self.passwordTextField.delegate = self
        self.view.addSubview(passwordTextField)
        scrollView.addSubview(passwordTextField)
        
        emailTextField.frame = CGRect(x: 30, y: 300, width: UIScreen.main.bounds.size.width-60, height: 38)
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
        
        // Firestore関連
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
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
        var errcount = 0
        print("to Confirm page")
        let confirmVC = RegisterConfirmViewController()
        let minimumLength: Int = 8
        
        if let userid = userIDTextField.text {
            if userid.count == 0 {
                useridLabel.text = "アカウントIDが未入力です"
                errcount += 1
            } else if userid.pregMatche(pattern: "[^A-Z0-9a-z]+") {
                useridLabel.text = "アカウントIDに不当な文字あります"
                errcount += 1
            } else {
                useridLabel.text = ""
            }
            useridLabel.font = passwordLabel.font.withSize(20.0)
            useridLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            useridLabel.textAlignment = NSTextAlignment.center
            useridLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 375)
            self.view.addSubview(useridLabel)
            scrollView.addSubview(useridLabel)
        }
        
        if let nickname = nicknameTextField.text {
            if nickname.count == 0 {
                nicknameLabel.text = "ニックネームが未入力です"
                nicknameLabel.font = passwordLabel.font.withSize(20.0)
                nicknameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
                nicknameLabel.textAlignment = NSTextAlignment.center
                nicknameLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 405)
                self.view.addSubview(nicknameLabel)
                scrollView.addSubview(nicknameLabel)
                errcount += 1
            }
        }
        
        if let password = passwordTextField.text {
            if password.count < minimumLength {
                passwordLabel.text = "パスワードの長さが8文字未満です"
                errcount += 1
            } else if password.pregMatche(pattern: "[\\s]+") {
                passwordLabel.text = "パスワードに空白が含まれています"
                errcount += 1
            } else {
                passwordLabel.text = ""
            }
            passwordLabel.font = passwordLabel.font.withSize(20.0)
            passwordLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            passwordLabel.textAlignment = NSTextAlignment.center
            passwordLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 435)
            self.view.addSubview(passwordLabel)
            scrollView.addSubview(passwordLabel)
        }
        
        if let email = emailTextField.text {
            if email.count == 0 {
                emailLabel.text = "メールアドレスが未入力です"
                errcount += 1
            } else if !(email.pregMatche(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$")) {
                emailLabel.text = "メールアドレスを入力してください"
                errcount += 1
            } else {
                emailLabel.text = ""
            }
            emailLabel.font = passwordLabel.font.withSize(20.0)
            emailLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            emailLabel.textAlignment = NSTextAlignment.center
            emailLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 465)
            self.view.addSubview(emailLabel)
            scrollView.addSubview(emailLabel)
        }
        
        if errcount > 0 {
            errcount = 0
            return
        } else {
            let userid = userIDTextField.text!
            let docRef = db.collection("users").document(userid)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    self.useridLabel.text = "使用済みのアカウントIDです"
                    self.useridLabel.font = self.passwordLabel.font.withSize(20.0)
                    self.useridLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
                    self.useridLabel.textAlignment = NSTextAlignment.center
                    self.useridLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 375)
                    self.view.addSubview(self.useridLabel)
                    self.scrollView.addSubview(self.useridLabel)
                } else {
                    print("Document does not exist")
                    
                    confirmVC.userID = self.userIDTextField.text!
                    confirmVC.nickname = self.nicknameTextField.text!
                    confirmVC.password = self.passwordTextField.text!
                    confirmVC.email = self.emailTextField.text!
                    print(type(of: confirmVC.userID))
                    print(type(of: confirmVC.nickname))
                    print(type(of: confirmVC.password))
                    print(type(of: confirmVC.email))
                    self.navigationController?.pushViewController(confirmVC, animated: true)
                }
            }
        }
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
