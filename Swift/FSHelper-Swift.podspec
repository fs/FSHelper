Pod::Spec.new do |s|
  s.name         = 'FSHelper-Swift'
  s.version      = '1.1'
  s.summary      = 'Helpers and extensions for iOS'
  s.homepage     = 'https://github.com/fs/FSHelper/Swift'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Sergey Nikolaev' => 'kruperfone@gmail.com' }
  s.platform     = :ios, '7.1'
  s.source       = { :git => 'https://github.com/fs/FSHelper.git', :tag => s.version.to_s }
  s.ios.source_files = 'Swift/Helpers/*.swift'
  s.frameworks 	 = 'Foundation', 'UIKit', 'QuartzCore'
  s.requires_arc = true
end
