//
//  ViewController.swift
//  1l_DmitrevSergey
//
//  Created by Sergey Dmitriev on 06.04.2021.
//

import UIKit

class ViewController: UIViewController {

    let fromLoginToTabBar = "fromLoginToTabBar"
    
    @IBOutlet weak var loginText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var loginScrollView: UIScrollView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
           
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataStorage.shared.firstInit()
        // Do any additional setup after loading the view.
    }

    @objc func keyboardWasShown(notification: Notification){
        
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        self.loginScrollView?.contentInset = contentInsets
        loginScrollView?.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        loginScrollView?.contentInset = contentInsets
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let login = self.loginText.text,
              let password = self.passwordText.text,
              login == "123",
              password == "123"
        else {
            let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
        Session.shared.userId = 0
        Session.shared.token = ""
        
        performSegue(withIdentifier: self.fromLoginToTabBar, sender: self)
    }
    
    
    @IBAction func getDataOverAPI(_ sender: Any) {
        guard Session.shared.token != "",
              Session.shared.userId != 0 else {
            return
        }
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.shared.userId)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let url = urlComponents.url
        let task = session.dataTask(with: url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            print(json!)
        }

        task.resume()
    }
    
    
    @IBAction func getPhoto(_ sender: Any) {
        guard Session.shared.token != "",
              Session.shared.userId != 0 else {
            return
        }
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: String(Session.shared.userId)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let url = urlComponents.url
        let task = session.dataTask(with: url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            print(json!)
        }

        task.resume()
    }
    
    @IBAction func getGroup(_ sender: Any) {
    
    //
        guard Session.shared.token != "",
              Session.shared.userId != 0 else {
            return
        }
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.shared.userId)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let url = urlComponents.url
        let task = session.dataTask(with: url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            print(json!)
        }

        task.resume()
        
    }
    
    
}

