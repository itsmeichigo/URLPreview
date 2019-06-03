Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.name         = "URLPreview"
  s.version      = "2.1.0"
  s.summary      = "An NSURL extension for showing preview info of webpages."

  s.description  = "You may want to use this if you want to mimick Facebook app's behavior when you post a link on your status."

  s.homepage     = "https://github.com/itsmeichigo/URLPreview"
  s.screenshots  = "https://raw.githubusercontent.com/itsmeichigo/URLPreview/master/ScreenShot.png"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.author             = { "Huong Do" => "huongdt29@gmail.com" }
  s.social_media_url   = "http://twitter.com/itsmeichigo"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  s.platform     = :ios, "8.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.source       = { :git => "https://github.com/itsmeichigo/URLPreview.git", :tag => s.version }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.source_files  = "Source"
  s.framework  = "UIKit"
  s.dependency 'Kanna', '~> 4.0.0'
  s.requires_arc = true

end
