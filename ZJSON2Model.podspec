#
#  Be sure to run `pod spec lint ZJSON2Model.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ZJSON2Model"
  s.version      = "0.0.4"
  s.summary      = ""

  s.description  = <<-DESC
                   A longer description of ZJSON2Model in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/ZhangZZZZ/ZJSON2Model"

  s.license      = "MIT"

  s.author       = {"ZhangZZZZ" => "nick18zhang@icloud.com"}

  s.source       = {:git => "https://github.com/ZhangZZZZ/ZJSON2Model.git", :tag => "0.0.4"}

  s.source_files  = "Classes", "Classes/*.{h,m}"
# s.exclude_files = "Classes/Exclude"

end
