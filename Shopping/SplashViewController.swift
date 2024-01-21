//
//  SplashViewController.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Lottie
import SnapKit
import UIKit

class SplashViewController: UIViewController {
    private var lottieAnimationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lottieAnimationView?.play()
    }
}

private extension SplashViewController {
    func configure() {
        lottieAnimationView = LottieAnimationView(name: "SplashLottie")
        guard let lottieAnimationView else { return }
        view.addSubview(lottieAnimationView)
        
        lottieAnimationView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(-40)
            $0.trailing.bottom.equalToSuperview().offset(40)
        }
    }
}
