#
#  Be sure to run `pod spec lint CoordinateAxis.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "CoordinateAxis"
  s.version      = "1.0"
  s.summary      = "3D XYZ Coordinate Axises."
  s.description  = "3D XYZ Coordinate Axises. Can easily change size, color and name"
  s.homepage     = "https://github.com/sw0906/CoordinateAxis.git"
  s.screenshots  = "https://github.com/sw0906/CoordinateAxis/blob/master/threed1.png"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Shou Wei" => "sw0906@gmail.com" }
  s.source       = { :git => "https://github.com/sw0906/CoordinateAxis.git", :tag => "1.0" }
  s.source_files  = "CoordinateAxisLib/*"

end
