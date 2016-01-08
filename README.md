# URLPreview

An NSURL extension for showing preview info of webpages.

You may want to use it if you want to mimick Facebook app's behavior when you post a link on your status.

![Screenshot](https://raw.githubusercontent.com/itsmeichigo/URLPreview/master/ScreenShot.png)

## Requirements

This library depends on [Kanna](https://github.com/tid-kijyun/Kanna) - a brilliant library for parsing HTML/XML on Swift.
If you intend to use this, make sure to clone it to make [URLPreview](#) work.

(Cocoapod support will be added soon!)

## Usage

Pretty simple, all you need is a block:

```Swift
if let url = NSURL(string: urlTextField.text!) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    url.fetchPageInfo({ (title, description, previewImage) -> Void in
      UIApplication.sharedApplication().networkActivityIndicatorVisible = false
      // do whatever you want here
    }, failure: { (errorMessage) -> Void in
      UIApplication.sharedApplication().networkActivityIndicatorVisible = false
      print(errorMessage)
    })
} else {
  print("Invalid URL!")
}
```

## Contributing

Contributions for bug fixing or improvements are welcomed. Feel free to submit a pull request.

## Licence

URLPreview is available under the MIT license. See the LICENSE file for more info.
