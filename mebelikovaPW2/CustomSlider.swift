//
//  CustomSlider.swift
//  mebelikovaPW2
//
//  Created by Мария Беликова on 28.09.2023.
//

import UIKit

final class CustomSlider: UIView {
    // - MARK: Constants
    enum Constants {
        static let titleTop: CGFloat = 15
        static let titleLeading: CGFloat = 15
        
        static let sliderBottom: CGFloat = -10
        static let sliderLeading: CGFloat = 20
    }
    
    // - MARK: Fields
    var valueChanged: ((Double) -> Void)?
    var slider = UISlider()
    var titleView = UILabel()
    
    // - MARK: Init
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    // - MARK: Configure UI
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLeading),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLeading),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderBottom),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeading)
        ])
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
