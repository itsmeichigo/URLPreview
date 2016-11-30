//
//  URLPreview.swift
//  UrlPreviewDemo
//
//  Created by Huong Do on 1/7/16.
//  Copyright © 2016 ichigo. All rights reserved.
//

import Foundation
import Kanna

public extension URL {
    
    struct ValidationQueue {
        static var queue = OperationQueue()
    }
    
    func fetchPageInfo(_ completion: @escaping ((_ title: String?, _ description: String?, _ previewImage: String?) -> Void), failure: @escaping ((_ errorMessage: String) -> Void)) {
        
        let request = NSMutableURLRequest(url: self)
        let newUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36"
        request.setValue(newUserAgent, forHTTPHeaderField: "User-Agent")
        ValidationQueue.queue.cancelAllOperations()
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async(execute: {
                    failure("Url receive no response")
                })
                return
            }
            
            if let urlResponse = response as? HTTPURLResponse {
                if urlResponse.statusCode >= 200 && urlResponse.statusCode < 400 {
                    if let data = data {
                        
                        if let doc = Kanna.HTML(html: data, encoding: String.Encoding.utf8) {
                            let title = doc.title
                            var description: String? = nil
                            var previewImage: String? = nil
                            print("title: \(title)")
                            if let nodes = doc.head?.xpath("//meta").enumerated() {
                                for node in nodes {
                                    if node.element["property"]?.contains("description") == true ||
                                        node.element["name"] == "description" {
                                        print("description: \(node.element["content"])")
                                        description = node.element["content"]
                                    }
                                    
                                    if node.element["property"]?.contains("image") == true &&
                                        node.element["content"]?.contains("http") == true {
                                        previewImage = node.element["content"]
                                    }
                                }
                            }
                            
                            DispatchQueue.main.async(execute: {
                                completion(title, description, previewImage)
                            })
                        }
                        
                    }
                } else {
                    DispatchQueue.main.async(execute: {
                        failure("Url received \(urlResponse.statusCode) response")
                    })
                    return
                }
            }
        }).resume()
    }
}
