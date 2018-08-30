Pod::Spec.new do |s|
  s.name         = "Sapporo"
  s.version      = "3.0.0"
  s.summary      = "cellmodel-driven collectionview manager"
  s.homepage     = "https://github.com/nghialv/Sapporo"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Le Van Nghia" => "nghialv2607@gmail.com" }
  s.social_media_url   = "https://twitter.com/nghialv2607"
  
  s.swift_version = '4.1'
  s.platform     = :ios
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/nghialv/Sapporo.git", :tag => s.version.to_s }
  s.source_files  = "Sapporo/**/*.swift"
  s.requires_arc = true
end
