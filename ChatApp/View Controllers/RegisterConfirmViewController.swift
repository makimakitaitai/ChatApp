//
//  RwgisterConfirmViewController.swift
//  ChatApp
//
//  Created by 萬木大志 on 2020/03/19.
//  Copyright © 2020 makimaki. All rights reserved.
//

import UIKit
import Firebase

class RegisterConfirmViewController: UIViewController {
    
    var userID = ""
    var nickname = ""
    var email = ""
    var password = ""
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI関連
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 300,height: 50))
        titleLabel.text = "登録内容確認"
        titleLabel.font = titleLabel.font.withSize(40.0)
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 200)
        self.view.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
        self.view.addSubview(titleLabel)
        
        let uLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
        uLabel.text = "アカウントID: "
        uLabel.font = titleLabel.font.withSize(20.0)
        uLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        uLabel.textAlignment = NSTextAlignment.center
        uLabel.layer.position = CGPoint(x: 100,y: 300)
        self.view.addSubview(uLabel)
        
        let userIDLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
        userIDLabel.text = userID
        userIDLabel.font = titleLabel.font.withSize(20.0)
        userIDLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        userIDLabel.textAlignment = NSTextAlignment.center
        userIDLabel.layer.position = CGPoint(x: 291,y: 300)
        self.view.addSubview(userIDLabel)
        
        let nLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
        nLabel.text = "ニックネーム: "
        nLabel.font = titleLabel.font.withSize(20.0)
        nLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        nLabel.textAlignment = NSTextAlignment.center
        nLabel.layer.position = CGPoint(x: 100,y: 350)
        self.view.addSubview(nLabel)
        
        let nicknameLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
        nicknameLabel.text = nickname
        nicknameLabel.font = titleLabel.font.withSize(20.0)
        nicknameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        nicknameLabel.textAlignment = NSTextAlignment.left
        nicknameLabel.layer.position = CGPoint(x: 291,y: 350)
        self.view.addSubview(nicknameLabel)
        
        let pLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
        pLabel.text = "パスワード: "
        pLabel.font = titleLabel.font.withSize(20.0)
        pLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        pLabel.textAlignment = NSTextAlignment.center
        pLabel.layer.position = CGPoint(x: 110,y: 400)
        self.view.addSubview(pLabel)
        
        let passwordLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
        passwordLabel.text = password
        passwordLabel.font = titleLabel.font.withSize(20.0)
        passwordLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        passwordLabel.textAlignment = NSTextAlignment.left
        passwordLabel.layer.position = CGPoint(x: 291,y: 400)
        self.view.addSubview(passwordLabel)
        
        let eLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
        eLabel.text = "メールアドレス: "
        eLabel.font = titleLabel.font.withSize(20.0)
        eLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        eLabel.textAlignment = NSTextAlignment.center
        eLabel.layer.position = CGPoint(x: 91,y: 450)
        self.view.addSubview(eLabel)
        
        let emailLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
        emailLabel.text = email
        emailLabel.font = titleLabel.font.withSize(20.0)
        emailLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        emailLabel.textAlignment = NSTextAlignment.left
        emailLabel.layer.position = CGPoint(x: 291,y: 450)
        self.view.addSubview(emailLabel)
        
        let authButton = UIButton(frame: CGRect(x: 175,y: 500,width: 200,height: 100))
        authButton.setTitle("登録", for: UIControl.State.normal)
        authButton.sizeToFit()
        authButton.addTarget(self, action: #selector(authButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(authButton)
        
        // Firestore関連
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func authButtonEvent(_ sender: UIButton) {
        // var ref: DocumentReference? = nil
        db.collection("users").document(userID).setData([
            "nickname": nickname,
            "password": password,
            "email": email
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        print("to Login Page")
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
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
