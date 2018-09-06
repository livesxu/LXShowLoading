
Pod::Spec.new do |s|

  s.name         = "LXShowLoading"
  s.version      = "0.1.0"
  s.summary      = "LXShowLoading"
  s.homepage     = "https://github.com/livesxu/LXShowLoading.git"
  s.license      = "MIT"
  s.author       = { "livesxu" => "livesxu@163.com" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/livesxu/LXShowLoading.git", :tag => s.version }
  s.source_files  = "LXShowLoading"
  s.frameworks    = 'UIKit'
  s.requires_arc  = true

  s.dependency 'MBProgressHUD', '~> 1.1.0'

end