#
# Be sure to run `pod lib lint ZUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZWXUtils'
  s.version          = '1.1.3'
  s.summary          = '一个工具类 ZWXUtils.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/zhwx600/ZWXUtils'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhwx600' => 'zhwx600@qq.com' }
  s.source           = { :git => 'https://github.com/zhwx600/ZWXUtils.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'


#----------------常用库------------------
#   alert 效果弹窗
#   s.dependency 'BAAlert'

#   标签 排版
#   s.dependency 'TTGTagCollectionView'

#   最全的日期选择器
#   s.dependency 'PGDatePicker'

#   通用web页面控制器
#   s.dependency 'AXWebViewController'
   s.dependency 'MBProgressHUD'
   s.dependency 'AFNetworking', '>= 4.0.1'

#   推送界面展示 库
#   s.dependency 'GLNotificationBar'

#   MJ 上拉下拉刷新加载 扩展类等
#   s.dependency 'MJExtension'
#   s.dependency 'MJRefresh'

#   autolayout 代码 控制
#   s.dependency 'Masonry'
#   s.dependency 'MSWeakTimer'

#   可以很容易地解决弹起键盘遮盖输入框的问题
#   s.dependency 'IQKeyboardManager'

#   可以很容易实现 类似网易新闻首页 菜单栏
#   s.dependency 'MXParallaxHeader'
#   s.dependency 'MXSegmentedPager'
#   s.dependency 'MXPagerView'

#   全屏手势返回 导航栏控制器
#   s.dependency 'FDFullscreenPopGesture'

#   支持左中右 抽屉效果
#   s.dependency 'MMDrawerController'

#   keychain 管理
#   s.dependency 'KeychainItemWrapper'

#---------------------------------------


  s.source_files = 'ZUtils/Classes/ZUtilsLib.h'

  s.subspec 'Category' do |ss|
      ss.source_files = 'ZUtils/Classes/Category/ZCategoryHeader.h'
      ss.public_header_files = 'ZUtils/Classes/Category/ZCategoryHeader.h'
      ss.frameworks = 'Security'

      ss.subspec 'Foundation' do |sss|

            sss.subspec 'NSArray' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSArray/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSArray/**/*.h'
            end
            sss.subspec 'NSData' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSData/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSData/**/*.h'
            end
            sss.subspec 'NSDate' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSDate/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSDate/**/*.h'
            end
            sss.subspec 'NSDictionary' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSDictionary/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSDictionary/**/*.h'
            end
            sss.subspec 'NSFileManager' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSFileManager/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSFileManager/**/*.h'
            end
            sss.subspec 'NSNumber' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSNumber/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSNumber/**/*.h'
            end
            sss.subspec 'NSObject' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSObject/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSObject/**/*.h'
            end
            sss.subspec 'NSRunLoop' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSRunLoop/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSRunLoop/**/*.h'
            end
            sss.subspec 'NSString' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSString/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSString/**/*.h'
            s4.dependency 'ZWXUtils/Category/Foundation/NSData'
            end
            sss.subspec 'NSTimer' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSTimer/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSTimer/**/*.h'
            end
            sss.subspec 'NSUrl' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSUrl/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSUrl/**/*.h'
            end
            sss.subspec 'NSURLRequest' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSURLRequest/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSURLRequest/**/*.h'
            end
            sss.subspec 'NSUserDefault' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/Foundation/NSUserDefault/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/Foundation/NSUserDefault/**/*.h'
            end
        
      end

      ss.subspec 'UIKit' do |sss|

            sss.subspec 'UIAlertController' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIAlertController/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIAlertController/**/*.h'
            end
            sss.subspec 'UIApplication' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIApplication/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIApplication/**/*.h'
            end
            sss.subspec 'UIBarButtonItem' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIBarButtonItem/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIBarButtonItem/**/*.h'
            end
            sss.subspec 'UIButton' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIButton/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIButton/**/*.h'
            end
            sss.subspec 'UIColor' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIColor/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIColor/**/*.h'
            end
            sss.subspec 'UIControl' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIControl/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIControl/**/*.h'
            end
            sss.subspec 'UIDevice' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIDevice/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIDevice/**/*.h'
            end
            sss.subspec 'UIImage' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIImage/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIImage/**/*.h'
            end
            sss.subspec 'UIImageView' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIImageView/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIImageView/**/*.h'
            end
            sss.subspec 'UILabel' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UILabel/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UILabel/**/*.h'
            end
            sss.subspec 'UINavigationBar' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UINavigationBar/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UINavigationBar/**/*.h'
            end
            sss.subspec 'UINavigationController' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UINavigationController/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UINavigationController/**/*.h'
            end
            sss.subspec 'UINavigationItem' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UINavigationItem/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UINavigationItem/**/*.h'
            end
            sss.subspec 'UIResponder' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIResponder/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIResponder/**/*.h'
            end
            sss.subspec 'UIScreen' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIScreen/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIScreen/**/*.h'
            end
            sss.subspec 'UIScrollow' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIScrollow/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIScrollow/**/*.h'
            end
            sss.subspec 'UISearchBar' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UISearchBar/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UISearchBar/**/*.h'
            end
            sss.subspec 'UITextField' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UITextField/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UITextField/**/*.h'
            end
            sss.subspec 'UITextView' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UITextView/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UITextView/**/*.h'
            end
            sss.subspec 'UIView' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIView/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIView/**/*.h'
            end
            sss.subspec 'UIViewController' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIViewController/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIViewController/**/*.h'
            end
            sss.subspec 'WKWebView' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/WKWebView/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/WKWebView/**/*.h'
            end
            sss.subspec 'UIWindow' do |s4|
            s4.source_files = 'ZUtils/Classes/Category/UIKit/UIWindow/**/*'
            s4.public_header_files = 'ZUtils/Classes/Category/UIKit/UIWindow/**/*.h'
            end
      end
    
    end

    s.subspec 'CustomView' do |ss|
        ss.source_files = 'ZUtils/Classes/CustomView/*'
        ss.public_header_files = 'ZUtils/Classes/CustomView/*.h'
    end

    s.subspec 'Utils' do |ss|
        ss.source_files = 'ZUtils/Classes/Utils/*'
        ss.public_header_files = 'ZUtils/Classes/Utils/*.h'

        ss.subspec 'HttpClient' do |s3|
            s3.source_files = 'ZUtils/Classes/Utils/HttpClient/**/*'
            s3.public_header_files = 'ZUtils/Classes/Utils/HttpClient/**/*.h'

            s3.dependency 'AFNetworking'
            s3.dependency 'ZWXUtils/CustomView'
            s3.dependency 'ZWXUtils/Category/Foundation/NSData'
            s3.dependency 'ZWXUtils/Category/Foundation/NSDictionary'

        end

    end

  
  # s.resource_bundles = {
  #   'ZUtils' => ['ZUtils/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit', 'Security'
  # s.dependency 'AFNetworking', '~> 2.3'
end
