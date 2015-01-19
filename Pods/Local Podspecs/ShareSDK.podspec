Pod::Spec.new do |s|
  s.name         = "ShareSDK"
  s.version      = "2.9.1"
  s.summary      = "ShareSDK分享平台"
  s.homepage     = "https://mob.com"
  s.license      = "MIT"
  s.authors      = { "xushao" => "xushao1990@126.com" }
  s.requires_arc = false
  s.frameworks   ='Foundation','SystemConfiguration','QuartzCore','CoreTelephony','Security','CoreGraphics','UIKit'
  s.libraries    = 'icucore', 'z.1.2.5','stdc++','sqlite3'
  s.platform     = :ios, '5.0'

  s.subspec 'ShareSDK' do |share|
  share.frameworks = 'ShareSDK'
  share.source_files = 'ShareSDK.framework/Headers/*.h'
  share.preserve_paths = 'ShareSDK.framework/*'
  share.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '"$(SRCROOT)/LocalPods/SDKS/ShareSDK/"' }
  end

  s.subspec 'Connection' do |con|
  con.frameworks = 'QQConnection','SinaWeiboConnection','WeChatConnection'
  con.source_files = 'Connection/*.framework/Headers/*.h'
  con.preserve_paths = 'Connection/*.framework/*'
  con.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '"$(SRCROOT)/LocalPods/SDKS/ShareSDK/Connection/"' }
  end
  
  s.subspec 'Core' do |cor|
  cor.frameworks = 'AGCommon','ShareSDKCoreService'
  cor.source_files = 'Core/AGCommon.framework/Headers/*.h','Core/ShareSDKCoreService.framework/Headers/*.h'
  cor.resources = 'Core/Resource.bundle','Core/en.lproj','Core/zh-Hans.lproj'
  cor.preserve_paths = 'Core/*'  
  cor.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '"$(SRCROOT)/LocalPods/SDKS/ShareSDK/Core/"' }
  end
  
  s.subspec 'Extend' do |ext|
  ext.framework = 'TencentOpenAPI'
  ext.source_files = 'Extend/*/*.framework/Headers/*.h','Extend/*/*.h'
  ext.resources = 'Extend/*/*.bundle'
  ext.preserve_paths = 'Extend/*/*.framework/*','Extend/SinaWeiboSDK/libSinaWeiboSDK.a'
  ext.libraries = "SinaWeiboSDK", "WeChatSDK"
  ext.xcconfig = {'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/LocalPods/SDKS/ShareSDK/Extend/SinaWeiboSDK/"  "$(SRCROOT)/LocalPods/SDKS/ShareSDK/Extend/WeChatSDK/" ','FRAMEWORK_SEARCH_PATHS' => '"$(SRCROOT)/LocalPods/SDKS/ShareSDK/Extend/QQConnectSDK"'}
  end
  
end