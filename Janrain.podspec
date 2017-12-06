#
# Janrain podspec
#

Pod::Spec.new do |s|
  s.name          = "Janrain"
  s.version       = "5.0.4"
  s.summary       = "Janrain iOS Mobile Libraries"
  s.homepage      = "https://github.com/klam-networkten/jump.ios"
  s.license       = { :type => 'BSD', :file => 'LICENSE' }
  s.author        = "Janrain"
  s.source        = { :git => "https://github.com/klam-networkten/jump.ios", :branch => "tenplay_iOS_Lib_5.0.4" }
  s.platform      = :ios, '8.0'
  s.source_files  = "Janrain/**/*.{h,m}"
  s.exclude_files = "Janrain/JRCapture/**/*"
  s.resource_bundles = {
    "images" => "Janrain/JREngage/Resources/images*/**/*.png"
  }
  s.resources     = ["Janrain/JREngage/Resources/*.lproj/*", "Janrain/JREngage/Resources/xibs/**/*", "Janrain/JREngage/**/*.js"]
  s.requires_arc  = true
  s.pod_target_xcconfig = { "HEADER_SEARCH_PATHS" => "$(PODS_TARGET_SRCROOT)/AppAuth/Source" }
  s.dependency 'AppAuth'
end
