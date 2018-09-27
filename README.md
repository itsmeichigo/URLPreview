# URLPreview

An NSURL extension for showing preview info of webpages.

You may want to use it if you want to mimick Facebook app's behavior when you post a link on your status.

![Screenshot](https://raw.githubusercontent.com/itsmeichigo/URLPreview/master/ScreenShot.png)

## Requirements

- Swift 4.2 & xCode 10
- This library depends on [Kanna](https://github.com/tid-kijyun/Kanna)

## Usage

Pretty simple, all you need is a block:

```Swift
if let url = NSURL(string: urlTextField.text!) {
    url.fetchPageInfo({ (title, description, previewImage) -> Void in
      // do whatever you want here
    }, failure: { (errorMessage) -> Void in
      print(errorMessage)
    })
} else {
  print("Invalid URL!")
}
```

## Contributing

Contributions for bug fixing or improvements are welcome. Feel free to submit a pull request.

## Licence

URLPreview is available under the MIT license. See the LICENSE file for more info.
