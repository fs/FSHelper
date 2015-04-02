Pod::Spec.new do |s|
  s.name         = 'FSHelper'
  s.version      = '1.0'
  s.summary      = 'Extensions for iOS'
  s.homepage     = 'https://github.com/fs/FSHelper'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Vladimir Goncharov' => 'vladimir1631@yandex.ru' }
  s.platform     = :ios, '5.0'
  s.source       = { :git => 'https://github.com/fs/FSHelper.git', :tag => s.version.to_s }
  s.ios.source_files = 'Objective-C/*.{h,m}'
  s.frameworks 	 = 'Foundation', 'UIKit', 'QuartzCore', 'MapKit', 'CommonCrypto', 'Accelerate', 'ImageIO'
  s.requires_arc = true
end
