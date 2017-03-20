Pod::Spec.new do |s|
s.name         = "OJNetWorkTools"
s.version      = "1.0.1"
s.summary      = "网络请求工具"
s.description  = <<-DESC
网络请求工具,自用不解释。
DESC
s.homepage     = "https://github.com/kingwangboss"
s.license      = "MIT"
s.author             = { "OneJ" => "3942241@qq.com" }
s.platform     = :ios, '5.0'
s.source       = { :git => "https://github.com/kingwangboss/OJNetWorkTools.git", :tag => "1.0.1" }
s.source_files  = "OJNetWorkTools/**/*.{h,m}"
s.requires_arc = true
end
