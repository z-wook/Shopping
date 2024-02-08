//
//  PaymentViewController.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit
import WebKit

final class PaymentViewController: UIViewController {
    private var webView: WKWebView?
    private let getMessageScriptName = "receiveMessage"
    private let getPaymentCompleteScriptName = "paymentComplete"
    
    private lazy var testButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Call JS", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addAction(UIAction(handler: { [weak self] action in
            self?.callJavaScript()
        }), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        let controller = WKUserContentController()
        controller.add(self, name: getMessageScriptName)
        controller.add(self, name: getPaymentCompleteScriptName)
        
        let config = WKWebViewConfiguration()
        config.userContentController = controller
        
        webView = WKWebView(frame: .zero, configuration: config)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        loadWebView()
        setUserAgent()
    }
}

extension PaymentViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        if message.name == getMessageScriptName {
            print("\(message.body)")
        }
        
        if message.name == getPaymentCompleteScriptName {
            print("\(message.body)")
        }
    }
}

private extension PaymentViewController {
    func loadWebView() {
        guard let htmlPath = Bundle.main.path(forResource: "test", ofType: "html") else { return }
        let url = URL(fileURLWithPath: htmlPath)
        var request = URLRequest(url: url)
        request.addValue("customValue", forHTTPHeaderField: "Header-Name")
        webView?.load(request)
    }
    
    func setUserAgent() {
        webView?.customUserAgent = "ShoppingPJ/1.0.0/iOS/"
    }
    
    func setCookie() {
        guard let cookie = HTTPCookie(properties: [
            .domain: "google.co.kr",
            .path: "/",
            .name: "myCookie",
            .value: "value",
            .secure: "FALSE",
            .expires: NSDate(timeIntervalSinceNow: 3600)
        ]) else { return }
        webView?.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
    }
    
    func callJavaScript() {
        webView?.evaluateJavaScript("javascriptFunction();")
    }
}

private extension PaymentViewController {
    func setLayout() {
        view.addSubview(testButton)
        
        testButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(200)
        }
    }
}

#Preview {
    PaymentViewController()
}
