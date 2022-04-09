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
        _ = displayTableView
    }
    
    private func gifFuncViewButtonClick() {
        
        let gifFuncView = GIFFuncView(frame: view.bounds)
        let positionX = view.frame.size.width
        let positionY = view.frame.size.height
        let animation = Quick.creatBasicAnimation("position", CGPoint(x: positionX + positionX/2, y: positionY/2), CGPoint(x: positionX/2, y: positionY/2), nil, 0.5, .forwards, false)
        gifFuncView.layer.add(animation, forKey: nil)
        view.addSubview(gifFuncView)
    }
    
    private func caBsicAnimationViewButtonClick() {
            
        let caBasicAnimationDisplayView = CABasicAnimationDisplayView(frame: view.bounds)
        let animation = Quick.creatBasicAnimation("opacity", UIColor.systemCyan.cgColor, 1, nil, 4, .forwards, false)
        caBasicAnimationDisplayView.layer.add(animation, forKey: nil)
        view.addSubview(caBasicAnimationDisplayView)
    }
    
    private func caKeyframeAnimationViewButonClick() {
        
        let caKeyframeAnimationDisplayView = CAKeyframeAnimationDisplayView(frame: view.bounds)
        let animation = Quick.creatBasicAnimation("transform.translation.x", view.frame.size.width, 0, nil, 0.5, .forwards, false)
        caKeyframeAnimationDisplayView.layer.add(animation, forKey: nil)
        view.addSubview(caKeyframeAnimationDisplayView)
    }
    
    // MARK: LAZY
    lazy var autoSrollView: AutoScrollBackgroundView = {
        let autoSrollView = AutoScrollBackgroundView(frame: view.bounds)
        view.addSubview(autoSrollView)
        return autoSrollView
    }()
    
    lazy var displayTableView: UITableView = {
        let displayTableView = UITableView.init(frame: view.bounds, style: UITableView.Style.grouped)
        displayTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DisplayTableViewCell")
        displayTableView.delegate = self
        displayTableView.dataSource = self
        displayTableView.layer.contents = UIColor.white.cgColor
        displayTableView.layer.opacity = 0.5
        view.addSubview(displayTableView)
        return displayTableView
    }()
    
    lazy var funcArray: [String] = {
        let funcArray = ["GIFFuncView", "CABasicAnimationDisplayView", "CAKeyframeAnimationDisplayView"]
        return funcArray
    }()
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funcArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = funcArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayTableViewCell")
        cell!.textLabel!.text = title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch(indexPath.row) {
        case 0:
            gifFuncViewButtonClick()
        case 1:
            caBsicAnimationViewButtonClick()
        case 2:
            caKeyframeAnimationViewButonClick()
        default:
            break
        }
    }
    
}

 
