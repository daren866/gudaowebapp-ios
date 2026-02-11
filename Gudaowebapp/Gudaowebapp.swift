// -*- coding: utf-8 -*-
import SwiftUI
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 创建窗口
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 创建主视图控制器
        let contentView = ContentView()
        let hostVC = UIHostingController(rootView: contentView)
        
        // 设置根视图控制器
        window?.rootViewController = hostVC
        window?.makeKeyAndVisible()
        
        // 隐藏状态栏
        UIApplication.shared.isStatusBarHidden = true
        
        return true
    }
}
