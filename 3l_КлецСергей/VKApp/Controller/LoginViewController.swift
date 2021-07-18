//
//  ViewController.swift
//  VKApp
//
//  Created by KKK on 31.03.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    let mySession = MySingletonSession.instance
    
    @IBOutlet weak var someView1: UIView!
    @IBOutlet weak var someView2: UIView!
    @IBOutlet weak var someView3: UIView!
 
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
 
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func loginUnwindAction(segue: UIStoryboardSegue) {}
    
    
    // Когда клавиатура появляется
     @objc func keyboardWasShown(notification: Notification) {
         
         // Получаем размер клавиатуры
         let info = notification.userInfo! as NSDictionary
         let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
         let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
         
         // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
         self.scrollView?.contentInset = contentInsets
         scrollView?.scrollIndicatorInsets = contentInsets
     }
     
     //Когда клавиатура исчезает
     @objc func keyboardWillBeHidden(notification: Notification) {
         // Устанавливаем отступ внизу UIScrollView, равный 0
         let contentInsets = UIEdgeInsets.zero
         scrollView?.contentInset = contentInsets
     }

    
    @objc func hideKeyboard() {
            self.scrollView?.endEditing(true)
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }


    
    override func viewDidLoad() {
            super.viewDidLoad()
         
            usernameLabel.text = "Логин"
            passwordLabel.text = "Пароль"
            loginButton.setTitle("Вход", for: [])
        
            // Жест нажатия
            let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            // Присваиваем его UIScrollVIew
            scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        layoutSubviews()
        animation9()
        
        }


    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //guard identifier == "goInsade" 
        checkUserInfo()
    }
    
    
    private func checkUserInfo()->Bool {
        guard
            let username = usernameTextField.text,
            let password = passwordTextField.text,
            username == "",
            password == ""
        else {
            loginpasswordError()
            return false
        }
        return true
    }
    
    
    private func loginpasswordError (with message: String = "Не верный логинн, пароль") {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okButton)
        present(alertController, animated: true)
        
    }
    
    
    //MARK:  layoutSubviews . . .
    func layoutSubviews() {
    
       someView1.layer.cornerRadius = someView1.frame.width / 2
       someView2.layer.cornerRadius = someView2.frame.width / 2
       someView3.layer.cornerRadius = someView3.frame.width / 2
   }

    func animation9(){
        let wdd = 1.0
        UIView.animate(
            withDuration: wdd,
            delay: 0.2,
            options: [.curveEaseInOut, .repeat]
        ) {
            self.someView1.alpha = 0.4
        }
            
            UIView.animate(
                withDuration: wdd,
                delay: 0.4,
                options: [.curveEaseInOut, .repeat]
            ) {self.someView2.alpha = 0.4
         }
        
            UIView.animate(
                withDuration: wdd,
                delay: 0.6,
                options: [.curveEaseInOut, .repeat]
            ) {
                self.someView3.alpha = 0.4
            }

        }
    
}

