//
//  VKLoginController.swift
//  VKApp
//
//  Created by KKK on 23.05.2021.
//

import UIKit
import WebKit

class VKLoginController: UIViewController {


  private let mySession = MySingletonSession.instance
    
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    @IBAction func logoutSegue(for unwindSegue: UIStoryboardSegue) {
        mySession.token = ""
        mySession.userID = ""
        
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            for record in records {
                if record.displayName.contains("vk") {
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: { [weak self] in
                        self?.webView.load(self!.request)
                    })
                }
            }
        }
        webView.load(request)
    }
    
    lazy var request = URLRequest(url: urlComponents.url!)

    private var urlComponents: URLComponents = {
    var url = URLComponents()
    url.scheme = "https"
    url.host = "oauth.vk.com"
    url.path = "/authorize"
    url.queryItems = [
        URLQueryItem(name: "client_id", value: "7861969"),
        URLQueryItem(name: "scope", value: "336918"),
        URLQueryItem(name: "display", value: "mobile"),
        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "v", value: "5.126"),
    ]
        return url
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let dataStore = WKWebsiteDataStore.default()
//        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
//            for record in records {
//                if record.displayName.contains("vk") {
//                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: { [weak self] in
//                        self?.webView.load(self!.request)
//                    })
//                }
//            }
//        }
        
        webView.load(request)
    }
}


extension VKLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else { decisionHandler(.allow); return }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        print(params)
        
        guard let token = params["access_token"],
            let userIdString = params["user_id"],
            let _ = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }
        
        mySession.token = token
        mySession.userID = userIdString
        
    
      // Получаем список - выводим
//        let NS = NetworkService()
//        NS.getListFriends()        
//        NS.getListGroups()
//        NS.getPhotos()
      // ------------------------
        
        
        performSegue(withIdentifier:"toFirstView", sender: self)

        decisionHandler(.cancel)
    }

}

