Pod::Spec.new do |s|
  s.name             = "SDKTimer"
  s.version          = "0.1.0"
  s.summary          = "Timer framework"
 
  s.description      = <<-DESC
This is a study
                       DESC
 
  s.homepage         = "https://github.com/SpessotoVitor97/SDKTimer"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Vitor Spessoto" => "spessoto97@icloud.com" }
  s.source           = { :git => "https://github.com/SpessotoVitor97/SDKTimer.git", :tag => s.version.to_s }
 
  s.ios.deployment_target = "10.0"
  s.swift_versions = "5.0"
  s.source_files = "SDKTimer/OutputTimerView.swift"
  
end
