// -*- coding: utf-8 -*-
import SwiftUI
import WebKit
import UserNotifications

class WebViewHandler: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("收到脚本消息:", message.name, "内容:", message.body)
        if message.name == "alert", let text = message.body as? String {
            print("处理提示消息:", text)
            // 在主线程中显示系统提示
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "提示", message: text, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                
                // 获取当前的视图控制器
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootViewController = windowScene.windows.first?.rootViewController {
                    rootViewController.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        // 请求通知权限
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("通知权限已授权")
            } else {
                print("通知权限被拒绝:", error?.localizedDescription ?? "未知错误")
            }
        }
        
        // 创建 WebView 配置
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        // 添加脚本消息处理器
        let handler = WebViewHandler()
        userContentController.add(handler, name: "alert")
        configuration.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

struct ContentView: View {
    var body: some View {
        WebView()
            .edgesIgnoringSafeArea(.all)
    }
}
