//
//  WishMakerViewController.swift
//  mebelikovaPW2
//
//  Created by Мария Беликова on 28.09.2023.
//

import UIKit

class WishMakerViewController: UIViewController, UIColorPickerViewControllerDelegate {
    // - MARK: Constants
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let alpha: CGFloat = 1
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = 10
        static let stackHorizontal: CGFloat = 20
        
        static let titleTop: CGFloat = 20
        static let titleText: String = "WishMaker"
        static let titleFontSize: CGFloat = 32
        
        static let descriptionTop: CGFloat = 20
        static let descriptionHorizontal: CGFloat = 20
        static let descriptionText: String = "This app will bring your joy and will fulfill three of your wishes!\n\t- The first is to change the background color."
        static let descriptionFontSize: CGFloat = 16
        
        static let switchBottom: CGFloat = 20
        static let switchTitleText: String = "Sliders"
        static let switchTitleBottom: CGFloat = 5
        
        static let randomButtonText: String = "Get random color"
        static let randomButtonBottom: CGFloat = 10
        static let randomButtonWidth: CGFloat = 170
        static let randomButtonHeight: CGFloat = 45
        
        static let colorPickerText: String = "Select color"
        static let colorPickerBottom: CGFloat = 10
        static let colorPickerWidth: CGFloat = 170
        static let colorPickerHeight: CGFloat = 45
        
        static let addWishButtonText: String = "My wishes"
        static let addWishButtonBottom: CGFloat = 20
        static let addWishButtonSide: CGFloat = 20
        static let addWishButtonHeight: CGFloat = 45
        
        static let buttonRadius: CGFloat = 10
        
        static let numberOfLines = 0
        
        static let rectangle: CGFloat = 0
    }
    
    // - MARK: Fields
    private var myTitle = UILabel()
    private let stack = UIStackView()
    private let titleSwitchView = UILabel()
    let randomColorButton = UIButton(type: .system)
    private let addWishButton: UIButton = UIButton(type: .system)
    
    // - MARK: Main
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // - MARK: ConfigureUI
    private func configureUI() {
        view.backgroundColor = .black
        configureTitle()
        configureDescription()
        configureAddWishButton()
        configureSliders()
        configureSwitch()
        configureRandomButton()
        configureColorPickerButton()
    }
    
    // - MARK: Configure Title
    private func configureTitle() {
        myTitle.translatesAutoresizingMaskIntoConstraints = false
        myTitle.text = Constants.titleText
        myTitle.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        myTitle.textColor = .white
        
        view.addSubview(myTitle)
        myTitle.pinCenterX(to: view)
        myTitle.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
    }
    
    // - MARK: Configure Description
    private func configureDescription() {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text = Constants.descriptionText
        description.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        description.lineBreakMode = .byWordWrapping
        description.numberOfLines = Constants.numberOfLines
        description.textColor = .white
        view.addSubview(description)
        
        description.pinCenterX(to: view)
        description.pinHorizontal(to: view, Constants.descriptionHorizontal)
        description.pinTop(to: myTitle.bottomAnchor, Constants.descriptionTop)
    }
    
    // - MARK: Configure Sliders
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        stack.isHidden = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }
        
        stack.pinCenterX(to: view)
        stack.pinHorizontal(to: view, Constants.stackHorizontal)
        stack.pinBottom(to: addWishButton.topAnchor, Constants.stackBottom)
        
        for sliderColor in [sliderRed, sliderBlue, sliderGreen] {
            sliderColor.valueChanged = { [weak self] value in
                self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: Constants.alpha)
            }
        }
    }
    
    // - MARK: Configure Sliders Switch
    private func configureSwitch() {
        let sliderSwitch = UISwitch(frame:CGRect(x: Constants.rectangle, y: Constants.rectangle, width: Constants.rectangle, height: Constants.rectangle))
        sliderSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        view.addSubview(sliderSwitch)
        sliderSwitch.isOn = false
        sliderSwitch.translatesAutoresizingMaskIntoConstraints = false
        sliderSwitch.pinCenterX(to: view)
        sliderSwitch.pinBottom(to: stack.topAnchor, Constants.switchBottom)
        
        titleSwitchView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleSwitchView)
        titleSwitchView.textColor = .white
        titleSwitchView.text = Constants.switchTitleText
        titleSwitchView.pinCenterX(to: view)
        titleSwitchView.pinBottom(to: sliderSwitch.topAnchor, Constants.switchTitleBottom)
    }
    
    @objc
    private func switchValueChanged(_ sender:UISwitch!) {
        stack.isHidden = !sender.isOn
    }
    
    // - MARK: Configure Random Color
    private func configureRandomButton() {
        randomColorButton.translatesAutoresizingMaskIntoConstraints = false
        randomColorButton.backgroundColor = .white
        randomColorButton.setTitle(Constants.randomButtonText, for: .normal)
        randomColorButton.setTitleColor(.black, for: .normal)
        randomColorButton.addTarget(self, action: #selector(randomButtonTouched(_:)), for: .touchUpInside)
        
        view.addSubview(randomColorButton)
        randomColorButton.pinBottom(to: titleSwitchView.topAnchor, Constants.randomButtonBottom)
        randomColorButton.setWidth(Constants.randomButtonWidth)
        randomColorButton.setHeight(Constants.randomButtonHeight)
        randomColorButton.pinCenter(to: view)
        randomColorButton.layer.cornerRadius = Constants.buttonRadius
    }
    
    @objc
    private func randomButtonTouched(_ sender:UIButton!) {
        view.backgroundColor = UIColor.getRandomColor()
    }
    
    // - MARK: Configure Color Picker
    private func configureColorPickerButton() {
        let colorPickerButton = UIButton(type: .system)
        colorPickerButton.translatesAutoresizingMaskIntoConstraints = false
        colorPickerButton.backgroundColor = .white
        colorPickerButton.setTitle(Constants.colorPickerText, for: .normal)
        colorPickerButton.setTitleColor(.black, for: .normal)
        view.addSubview(colorPickerButton)
        colorPickerButton.pinBottom(to: randomColorButton.topAnchor, Constants.colorPickerBottom)
        colorPickerButton.setWidth(Constants.colorPickerWidth)
        colorPickerButton.setHeight(Constants.colorPickerHeight)
        colorPickerButton.pinCenter(to: view)
        colorPickerButton.layer.cornerRadius = Constants.buttonRadius
        if #available(iOS 14.0, *) {
            colorPickerButton.addTarget(self, action: #selector(colorPickerButtonTouched(_:)), for: .touchUpInside)
        } else {
            colorPickerButton.backgroundColor = .gray
        }
    }
    
    @available(iOS 14.0, *)
    @objc
    private func colorPickerButtonTouched(_ sender:UIButton!) {
        let colorPickerViewController = UIColorPickerViewController()
        colorPickerViewController.delegate = self
        present(colorPickerViewController, animated: true)
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        view.backgroundColor = viewController.selectedColor
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
    }
    
    // - MARK: Configure Add Wish
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.translatesAutoresizingMaskIntoConstraints = false;
        addWishButton.setHeight(Constants.addWishButtonHeight)
        addWishButton.pinBottom(to: view, Constants.addWishButtonBottom)
        addWishButton.pinHorizontal(to: view, Constants.addWishButtonSide)
        
        addWishButton.backgroundColor = .systemPink
        addWishButton.setTitleColor(.white, for: .normal)
        addWishButton.setTitle(Constants.addWishButtonText, for: .normal)
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action:  #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
}
