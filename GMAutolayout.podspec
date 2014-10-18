Pod::Spec.new do |s|
  s.name             = "GMAutolayout"
  s.version          = "0.1.0"
  s.summary          = "Category on UIView to ease your life with AutoLayout constraints"
  s.homepage         = "https://github.com/keradgames/GMAutolayout"
  s.license          = 'MIT'
  s.author           = { "Kerad Games" => "joan.romano@keradgames.com" }
  s.source           = { :git => "https://github.com/keradgames/GMAutolayout.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/keradgames'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'GMAutolayout' => ['Pod/Assets/*.png']
  }
end
