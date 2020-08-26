//
//  URLPreview.swift
//  UrlPreviewDemo
//
//  Created by Huong Do on 1/7/16.
//  Copyright © 2016 ichigo. All rights reserved.
//

import Foundation
import Kanna
import Alamofire

public extension URL {
    
    struct ValidationQueue {
        static var queue = OperationQueue()
    }
    
    func fetchPageInfo(_ completion: @escaping ((_ title: String?, _ description: String?, _ previewImage: String?) -> Void), failure: @escaping ((_ errorMessage: String) -> Void)) {
        
        let newUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36"
        
        ValidationQueue.queue.cancelAllOperations()
        
        request(self, method: .get, parameters: ["User-Agent": newUserAgent]).validate().responseData { response in
            
            if response.error != nil {
                DispatchQueue.main.async(execute: {
                    failure("Url receive no response")
                })
                return
            }
            
            if let data = response.data {
                if let doc = try? Kanna.HTML(html: data, encoding: String.Encoding.utf8) {
                    
                    let title = doc.title
                    
                    var description: String? = nil
                    
                    var previewImage: String? = nil
                    
                    if let nodes = doc.head?.xpath("//meta").enumerated() {
                        for node in nodes {
                            if node.element["property"]?.contains("description") == true ||
                                node.element["name"] == "description" {
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
        }
    }
}
