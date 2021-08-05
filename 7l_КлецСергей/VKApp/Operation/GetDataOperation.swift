//
//  GetDataOperation.swift
//  VKApp
//
//  Created by KKK on 12.07.2021.
//

import Foundation

class GetDataOperation: AsyncOperation {
    
    // возвращаемые данные
    var data: Data?
    // парамерт
    var userID: String
    var methodPaths: makeComponentsUrl.MethodPaths
    
    init(methodPaths: makeComponentsUrl.MethodPaths, userID: String) {
        self.userID = userID
        self.methodPaths = methodPaths
        super.init()
    }
    
    func getData(methodPaths: makeComponentsUrl.MethodPaths, user_ID userID : String, complition: @escaping (Data?) -> () ) {

        let urlComponents: URLComponents = {
            
            let rr =  makeComponentsUrl()
             return   rr.makeComponents(for: methodPaths, user_id: userID)
        }()
        
        DispatchQueue.global().async  {
            if let url = urlComponents.url {
                print("url data = \(url)")
                let session = URLSession(configuration: URLSessionConfiguration.default)
                session.dataTask(with: url) { (data, response, error) in
//                    DispatchQueue.main.async  {
                        complition(data)
//                    }
                    self.data = data
                }
                .resume()
            }
      }
    
    }

    override func main() {
        getData(methodPaths: methodPaths, user_ID: userID) {[weak self] (gdata) in
            self?.data = gdata
            self?.state = .finished
            print("Get data - ok")
        }
    }
}
