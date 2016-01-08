//
//  URLPreview.swift
//  UrlPreviewDemo
//
//  Created by Huong Do on 1/7/16.
//  Copyright © 2016 ichigo. All rights reserved.
//

import Foundation
import Kanna

extension NSURL {
    
    struct ValidationQueue {
        static var queue = NSOperationQueue()
    }
    
    func fetchPageInfo(completion: ((title: String?, description: String?, previewImage: String?) -> Void), failure: ((errorMessage: String) -> Void)) {
        
        let request = NSMutableURLRequest(URL: self)
//        request.HTTPM 
        ValidationQueue.queue.cancelAllOperations()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: ValidationQueue.queue, completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            if error != nil {
                failure(errorMessage: "Url receive no response")
                return
            }
            
            if let urlResponse = response as? NSHTTPURLResponse {
                if urlResponse.statusCode >= 200 && urlResponse.statusCode < 400 {
                    if let data = data {
                        
                        if let doc = Kanna.HTML(html: data, encoding: NSUTF8StringEncoding) {
                            let title = doc.title
                            var description: String? = nil
                            var previewImage: String? = nil
                            print("title: \(title)")
                            if let nodes = doc.head?.xpath("//meta").enumerate() {
                                for node in nodes {
                                    if node.element["property"]?.containsString("description") == true ||
                                    node.element["name"] == "description" {
                                        print("description: \(node.element["content"])")
                                        description = node.element["content"]
                                    }
                                    
                                    if node.element["property"]?.containsString("image") == true {
                                        previewImage = node.element["content"]
                                    }
                                }
                            }
                            
                            completion(title: title, description: description, previewImage: previewImage)
                        }
                        
                    }
                } else {
                    failure(errorMessage: "Url received \(urlResponse.statusCode) response")
                    return
                }
            }
        })
    }
}
