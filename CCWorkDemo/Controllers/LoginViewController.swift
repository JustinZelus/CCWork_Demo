
import Foundation
import UIKit

class LoginViewController: UIViewController {
    fileprivate let accountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Acoount"
        label.textColor = .white
        return label
    }()
    
    fileprivate let pwLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        label.textColor = .white
        return label
    }()
    
    fileprivate let accountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.green
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.layer.borderColor = UIColor.green.cgColor
        textField.layer.borderWidth = 1
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Account here",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 54/255, green: 117/255, blue: 63/255, alpha: 1)])
        return textField
    }()
    
    fileprivate let pwTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.green
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.layer.borderColor = UIColor.green.cgColor
        textField.layer.borderWidth = 1
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Password here",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 54/255, green: 117/255, blue: 63/255, alpha: 1)])
        return textField
    }()
    
    fileprivate let loginButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(loginButtonEvent), for: .touchUpInside)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    
    @objc func loginButtonEvent(sender:UIButton!) {
        guard let account = accountTextField.text , account != "" else {return}
        guard let pw = pwTextField.text ,pw != "" else {return}
        
        let loginInfo = ["Account" : account , "Password": pw]

        //encrypt
        let encryptData = JZJZEncryption.Encrpt_3DES_CBC(encryptText: PConstans.mySecretText,key: PConstans.key,iv:PConstans.iv)
        //convert to base64
        let base64cryptString = encryptData.base64EncodedString(options: .lineLength64Characters)
        print("base64cryptString = \(base64cryptString)")
        
        let postData = try? JSONSerialization.data(withJSONObject: ["Secret":base64cryptString])
        let memberData = try? JSONSerialization.data(withJSONObject: loginInfo)

        //api flow
        LoginModule.GetToken(postData: postData, completion: { [weak self] success,result in
            if !success {
                
            } else {
                if let token = result {
                    print(token)
                    
                    LoginModule.MemberLogin(postData: memberData, token: token, completion: {success,result in
                        if !success {
                            DispatchQueue.main.async {
                                Tools.showAlertWith(vc: self!, title: "Oops", message: result!)
                            }
                            
                            
                        } else {
                            if let memberToken = result {
                                print(memberToken)
                                LoginModule.MemberData(memberToken: memberToken, completion: {success,result  in
                                    if !success {
                                        
                                    } else {
                                        let data = Tools.convertDictionary(target: result!)
                                       // print(member)
                                        DispatchQueue.main.async {
                                            guard let navigationVC = self?.navigationController else { return }
                                         
                                            let decoder = JSONDecoder()
                                            do {
                                                let jsonStr = Tools.jsonToString(json: data)
                                                let member = try decoder.decode(Member.self, from: Data(jsonStr!.utf8))
                                               
                                                navigationVC.popViewController(animated: false)
                                                let memberVC = MemberViewController()
                                                memberVC.data = member
                                                navigationVC.pushViewController(memberVC, animated: true)
                                            } catch {
                                                print(error.localizedDescription)
                                            }
                                          
                                        
                                        }
                                        
                                    }
                                })
                            }
                        }
                    })
                }
                
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        //account
        view.addSubview(accountLabel)
        accountLabel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 88).isActive = true
        accountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        accountLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        accountLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        view.addSubview(accountTextField)
        accountTextField.topAnchor.constraint(equalTo: accountLabel.topAnchor, constant: 0).isActive = true
        accountTextField.leadingAnchor.constraint(equalTo: accountLabel.trailingAnchor, constant: 8).isActive = true
        accountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        accountTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //pw
        view.addSubview(pwLabel)
        pwLabel.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: 88).isActive = true
        pwLabel.leadingAnchor.constraint(equalTo: accountLabel.leadingAnchor, constant: 0).isActive = true
        pwLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        pwLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        view.addSubview(pwTextField)
        pwTextField.topAnchor.constraint(equalTo: pwLabel.topAnchor, constant: 0).isActive = true
        pwTextField.leadingAnchor.constraint(equalTo: pwLabel.trailingAnchor, constant: 8).isActive = true
        pwTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        pwTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //btn
        view.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 44).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    
}
