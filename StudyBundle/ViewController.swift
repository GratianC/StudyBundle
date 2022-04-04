//
//  ViewController.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/4.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        _ = autoSrollView
       _ = gifResolveButton
    }
    
    @objc
    private func gifResolveButtonClick() {
        GIFHandler.resolveGIFToLocal("meme1")
    }

    
    // MARK: LAZY
    lazy var autoSrollView: AutoScrollBackgroundView = {
        let autoSrollView = AutoScrollBackgroundView(frame: view.bounds)
        view.addSubview(autoSrollView)
        return autoSrollView
    }()
    
    lazy var gifResolveButton: UIButton = {
        let gifResolveButton = UIButton(frame: CGRect(x: 20, y: 20, width: 200, height: 50))
        gifResolveButton.setTitle("gifResolveButton", for: .normal)
        gifResolveButton.addTarget(self, action: #selector(gifResolveButtonClick), for: .touchUpInside)
        gifResolveButton.backgroundColor = .gray
        view.addSubview(gifResolveButton)
        return gifResolveButton
    }()
}

