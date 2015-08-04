Pod::Spec.new do |s|
  s.name         = 'FSHelpers+Swift'
  s.version      = '1.1'
  s.summary      = 'Helpers and extensions for iOS'
  s.homepage     = 'https://github.com/fs/FSHelper/tree/master/Swift'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Sergey Nikolaev' => 'kruperfone@gmail.com' }
  s.platform     = :ios, '8.0'
  s.source       = { :git => 'https://github.com/fs/FSHelper.git', :tag => s.version.to_s }
  s.ios.source_files = 'Swift/Helpers/FSHelpers.swift'
  s.frameworks 	 = 'Foundation', 'UIKit', 'QuartzCore'
  s.requires_arc = true

  s.subspec 'FSExtensions' do |ss|
    ss.source_files = 'Swift/Helpers/FSExtensions/*.{swift}'
  end

end
