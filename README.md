# URLPreview

An NSURL extension for showing preview info of webpages.

You may want to use it if you want to mimick Facebook app's behavior when you post a link on your status.

![Screenshot](https://raw.githubusercontent.com/itsmeichigo/URLPreview/master/ScreenShot.png)

## Requirements

This library depends on [Kanna](https://github.com/tid-kijyun/Kanna) - a brilliant library for parsing HTML/XML on Swift.

## Installation

#### Using Cocoapod

Just add the following to your `podfile`
> pod 'URLPreview'

#### Manual install

- Drag and drop folder `Source` to your project.
- Copy the source from [Kanna](https://github.com/tid-kijyun/Kanna) to your project too.


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
