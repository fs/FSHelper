Pod::Spec.new do |s|
  s.name         = 'FSHelpers-ObjectiveC'
  s.version      = '1.1'
  s.summary      = 'Extensions for iOS'
  s.homepage     = 'https://github.com/fs/FSHelper/Objective-C'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Vladimir Goncharov' => 'vladimir1631@yandex.ru' }
  s.platform     = :ios, '5.0'
  s.source       = { :git => 'https://github.com/fs/FSHelper.git', :tag => s.version.to_s }
  s.ios.source_files = 'Objective-C/Helpers/*.{h,m}'
  s.frameworks 	 = 'Foundation', 'UIKit', 'QuartzCore', 'MapKit', 'Accelerate', 'ImageIO'
  s.requires_arc = true
end
