//
//  SSWebViewController.swift
//  SpeedySwift
//
//  Created by Quinn on 2021/2/17.
//

import UIKit
import WebKit
open class SSWebViewController: SSViewController {
    
    open var linkUrl: String?
    public let scriptMessageName = "your script"
    
    open var webView : WKWebView?
    open var progressView : UIProgressView?
    
    open var parameters:[String: Any]?
    
    deinit {
        webView?.configuration.userContentController.removeScriptMessageHandler(forName: scriptMessageName)
        removeObservers()
        clearWKWebView()
        SS.log("[\(#file)]")
    }
    
    public init(urlString: String, parameters: [String: Any]? = nil) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        self.linkUrl = urlString
        self.parameters = parameters
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.fakeNav.isHidden = false
        self.fakeNav.titleLabel.text = self.title
        buildWebView()
        buildProgressView()
        addObserverForProgressAndTitle()
        
        loadPage()
    }
    
    // 加载网页
    open func loadPage() {
        if let url = URL(string: linkUrl ?? "") {
            let request = URLRequest(url: url)
            webView?.load(request)
        } else {
            showAlert(title: "链接已失效", message: nil)
        }
    }
    
    private func buildWebView() {
        
        let preference = WKPreferences.init()
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 10
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = true;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = true;
        
        //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
        let weakScriptMessageDelegate = WeakWebViewScriptMessageDelegate.init(scriptDelegate: self)
        
        //这个类主要用来做native与JavaScript的交互管理
        let wkUController = WKUserContentController.init()
        //注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
        wkUController.add(weakScriptMessageDelegate, name: scriptMessageName)
        
        /*
         
         */
        
        //创建网页配置对象
        let webViewConfig = WKWebViewConfiguration.init()
        
        webViewConfig.processPool = WKProcessPool.init()
        webViewConfig.preferences = preference;
        webViewConfig.userContentController = wkUController;
        //        webViewConfig.userContentController.addUserScript(script)
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        webViewConfig.allowsInlineMediaPlayback = true;
        //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
        //        webViewConfig.requiresUserActionForMediaPlayback = true;
        //设置是否允许画中画技术 在特定设备上有效
        webViewConfig.allowsPictureInPictureMediaPlayback = true;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        webViewConfig.applicationNameForUserAgent = "Speedy";
        // 是否支持记忆读取
        webViewConfig.suppressesIncrementalRendering = true;
        
        self.webView = WKWebView.init(frame: self.view.bounds, configuration: webViewConfig)
        self.webView?.uiDelegate = self // UI代理
        self.webView?.navigationDelegate = self  // 导航代理
        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        self.webView?.allowsBackForwardNavigationGestures = true;
        
        //        let y = self.isHideNavigationBar == true ? statusBarHeight :  statusBarAndNavigationBarHeight
        //        self.webView?.scrollView.contentInset = UIEdgeInsetsMake(y, 0, tabBarBottomHeight, 0)
        self.view.addSubview(self.webView!)
        
        self.webView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(SS.statusBarHeight)
        })
        
        webView?.evaluateJavaScript("navigator.userAgent") { [weak self](result, error) in
            if let ua = result as? String {
                self?.webView?.customUserAgent = ua + " speedy/\(SS.versionS)"
            }
        }
    }
    
    // MARK: - 构建进度条
    private func buildProgressView() {
        
        progressView = UIProgressView.init(frame: CGRect.init(x: 0, y: SS.statusBarHeight, width: SS.w, height: 3))
        progressView?.progressTintColor = UIColor.hex("#26A1DE")
        progressView?.trackTintColor = UIColor.clear
        self.view.addSubview(progressView!)
    }
    
    // MARK: - 添加进度和标题的观察者
    private func addObserverForProgressAndTitle() {
        //添加监测网页加载进度的观察者
        webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        //添加监测网页标题的观察者
        webView?.addObserver(self, forKeyPath: "title", options: .new, context: nil)
    }
    
    // MARK: -  移除观察者
    private func removeObservers() {
        webView?.removeObserver(self, forKeyPath:"estimatedProgress")
        webView?.removeObserver(self, forKeyPath:"title")
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            self.progressView?.progress = Float(webView?.estimatedProgress ?? 0.0)
            if self.progressView?.progress == 1{
                self.progressView?.isHidden = true
            }else{
                self.progressView?.isHidden = false
            }
        }
        else if keyPath == "title" {
            if let webTitle = webView?.title, !webTitle.isEmpty {
                self.title = webTitle
                self.navigationItem.title = webTitle
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

extension SSWebViewController :  WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    // MARK: - WKScriptMessageHandler
    //被自定义的WKScriptMessageHandler在回调方法里通过代理回调回来，绕了一圈就是为了解决内存不释放的问题
    //通过接收JS传出消息的name进行捕捉的回调方法
    open func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "Speedy" {
            if let _ = message.body as? Dictionary<String, Any>{
                /// TODO
            }
        }
    }
    
    // MARK: - WKNavigationDelegate
    
    /*
     WKNavigationDelegate主要处理一些跳转、加载处理操作，WKUIDelegate主要处理JS脚本，确认框，警告框等
     */
    // 页面开始加载
    open func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    // 页面加载失败时调用
    open func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        self.progressView?.setProgress(0.0, animated: false)
        
        let userInfo = (error as NSError).userInfo
        if let urlStr = userInfo["NSErrorFailingURLStringKey"] as? String, urlStr.contains("//itunes.apple.com/") {
            return
        }
        

    }
    
    // 当内容开始返回时调用，已开始加载页面，可以在这一步向view中添加一个过渡动画
    open func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    // 页面已全部加载，可以在这一步把过渡动画去掉
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let webTitle = webView.title, !webTitle.isEmpty {
            self.title = webTitle
        }
    }
    
    //提交发生错误时调用
    open func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.progressView?.setProgress(0.0, animated: false)
    }
    
    // 接收到服务器跳转请求即服务重定向时之后调用
    open func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
       
        // 在这里添加您的逻辑代码
        let url = navigationAction.request.url
        let urlString = url?.absoluteString ?? ""
        if urlString.contains("//itunes.apple.com/"),let url = url{
            SS.jump(url: url)
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    // 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
    open func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        decisionHandler(.allow);
    }
    
    //进程被终止时调用
    open func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        SS.log("webViewWebContentProcessDidTerminate")
        webView.reload()
    }
    
    
    // MARK: - WKUIDelegate
    /**
     *  web界面中有弹出警告框时调用
     *
     *  @param webView           实现该代理的webview
     *  @param message           警告框中的内容
     *  @param completionHandler 警告框消失调用
     */
    open func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        showAlert(title: nil, message: message)
    }
    
    // 确认框
    //JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
    open func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        //  js 里面的alert实现，如果不实现，网页的alert函数无效
        showAlert(title: nil, message: message)

        
    }
    
    // 输入框
    //JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
    open func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        // 客户端不处理程序
        completionHandler("Client Not handler");
    }
    
    private func clearWKWebView() {
        let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
        let dateFrom = NSDate.init(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: dateFrom as Date) {
            
        }
    }
}

// MARK: - 解决WKWebView内存不释放的问题
open class WeakWebViewScriptMessageDelegate: NSObject, WKScriptMessageHandler {
    
    //WKScriptMessageHandler 这个协议类专门用来处理JavaScript调用原生OC的方法
    open weak var scriptDelegate : AnyObject?
    
    deinit {
        SS.log()
    }
    
    public init(scriptDelegate : AnyObject) {
        super.init()
        self.scriptDelegate = scriptDelegate
    }
    
    
    // MARK: - WKScriptMessageHandler
    //遵循WKScriptMessageHandler协议，必须实现如下方法，然后把方法向外传递
    //通过接收JS传出消息的name进行捕捉的回调方法
    open func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if let delegate = self.scriptDelegate, delegate.responds(to: #selector(userContentController(_:didReceive:)))  {
            delegate.userContentController(userContentController, didReceive: message)
        }
    }
}

