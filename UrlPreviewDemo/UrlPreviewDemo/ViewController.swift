//
//  ViewController.swift
//  UrlPreviewDemo
//
//  Created by Huong Do on 1/7/16.
//  Copyright © 2016 ichigo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // make round corners because i'm bored
        previewImageView.layer.masksToBounds = true
        previewImageView.layer.cornerRadius = 5
    }

    @IBAction func checkPreview(_ sender: AnyObject) {
        urlTextField.resignFirstResponder()
        
        // refresh preview view
        previewImageView.image = nil
        titleLabel.text = ""
        descriptionLabel.text = ""
        
        if urlTextField.text!.isEmpty {
            print("Paste an URL first!")
        } else {
            if let url = URL(string: urlTextField.text!) {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                activityIndicator.startAnimating()
                
                url.fetchPageInfo({ (title, description, previewImage) -> Void in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    self.activityIndicator.stopAnimating()
                    
                    if let title = title {
                        self.titleLabel.text = title
                    }
                    
                    if let description = description {
                        self.descriptionLabel.text = description
                    }
                    
                    if let imageUrl = previewImage {
                        self.downloadImage(URL(string: imageUrl)!, imageView: self.previewImageView)
                    }
                }, failure: { (errorMessage) -> Void in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    print(errorMessage)
                })
            } else {
                print("Invalid URL!")
            }
        }
    }
    
    // helper for loading image
    func getDataFromUrl(_ url:URL, completion: @escaping ((_ data: Data?, _ response: URLResponse?, _ error: Error? ) -> Void)) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            completion(data, response, error)
        }).resume()
    }

    func downloadImage(_ url: URL, imageView: UIImageView){
        print("Download Started")
        print("lastPathComponent: " + url.lastPathComponent)
        getDataFromUrl(url) { (data, response, error)  in
            DispatchQueue.main.async(execute: {
                guard let data = data , error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                imageView.image = UIImage(data: data)
            })
        }
    }
}

