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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func checkPreview(sender: AnyObject) {
        urlTextField.resignFirstResponder()
        if urlTextField.text!.isEmpty {
            print("Paste an URL first!")
        } else {
            if let url = NSURL(string: urlTextField.text!) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                url.fetchPageInfo({ (title, description, previewImage) -> Void in
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    if let title = title {
                        self.titleLabel.text = title
                    }
                    
                    if let description = description {
                        self.descriptionLabel.text = description
                    }
                    
                    if let imageUrl = previewImage {
                        self.downloadImage(NSURL(string: imageUrl)!, imageView: self.previewImageView)
                    }
                }, failure: { (errorMessage) -> Void in
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    print(errorMessage)
                })
            } else {
                print("Invalid URL!")
            }
        }
    }
    
    // helper for loading image
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }

    func downloadImage(url: NSURL, imageView: UIImageView){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                imageView.image = UIImage(data: data)
            }
        }
    }
}

