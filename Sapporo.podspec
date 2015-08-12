Pod::Spec.new do |s|
  s.name         = "Sapporo"
  s.version      = "0.1.5.1"
  s.summary      = "cellmodel-driven collectionview manager"
  s.homepage     = "https://github.com/nghialv/Sapporo"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Le Van Nghia" => "nghialv2607@gmail.com" }
  s.social_media_url   = "https://twitter.com/nghialv2607"

  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/nghialv/Sapporo.git", :tag => "0.1.5.1" }
  s.source_files  = "Sapporo/*"
  s.requires_arc = true
end
