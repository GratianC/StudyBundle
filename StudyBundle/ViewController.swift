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
        _ = gifFuncViewButton
    }
    
    @objc private func gifFuncViewButtonClick() {
        
        let gifFuncView = GIFFuncView(frame: view.bounds)
        view.addSubview(gifFuncView)
    }
    
    // MARK: LAZY
    lazy var autoSrollView: AutoScrollBackgroundView = {
        let autoSrollView = AutoScrollBackgroundView(frame: view.bounds)
        view.addSubview(autoSrollView)
        return autoSrollView
    }()
    
    lazy var gifFuncViewButton: UIButton = {
        let gifFuncViewButton = UIButton(frame: CGRect(x: 20, y: 20, width: 200, height: 50))
        gifFuncViewButton.setTitle("GIFFuncViewButton", for: .normal)
        gifFuncViewButton.backgroundColor = .orange
        gifFuncViewButton.addTarget(self, action: #selector(gifFuncViewButtonClick), for: .touchUpInside)
        view.addSubview(gifFuncViewButton)
        return gifFuncViewButton
    }()
   
}

 
