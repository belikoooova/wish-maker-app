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
        static let stackBottom: CGFloat = 20
        static let stackHorizontal: CGFloat = 20
        
        static let titleTop: CGFloat = 20
        static let titleText: String = "WishMaker"
        static let titleFontSize: CGFloat = 32
        
        static let descriptionTop: CGFloat = 20
        static let descriptionHorizontal: CGFloat = 20
        static let descriptionText: String = "This app will bring your joy and will fulfill three of your wishes!"
        static let descriptionFontSize: CGFloat = 16
        
        static let switchBottom: CGFloat = 10
        static let switchTitleText: String = "Sliders"
        static let switchTitleBottom: CGFloat = 5
        
        static let randomButtonText: String = "Get random color"
        static let randomButtonBottom: CGFloat = 10
        static let randomButtonWidth: CGFloat = 170
        static let randomButtonHeight: CGFloat = 40
        
        static let colorPickerText: String = "Select color"
        static let colorPickerBottom: CGFloat = 10
        static let colorPickerWidth: CGFloat = 170
        static let colorPickerHeight: CGFloat = 40
        
        static let addWishButtonText: String = "Add more wishes"
        static let addWishButtonBottom: CGFloat = 10
        static let addWishButtonSide: CGFloat = 20
        static let addWishButtonHeight: CGFloat = 45
        
        static let scheduleWishButtonText: String = "Schedule wish granting"
        static let scheduleWishButtonBottom: CGFloat = 20
        static let scheduleWishButtonSide: CGFloat = 20
        static let scheduleWishButtonHeight: CGFloat = 45
        
        static let buttonRadius: CGFloat = 10
        static let buttonColor: UIColor = .white
        
        static let numberOfLines = 0
        
        static let rectangle: CGFloat = 0
    }
    
    // - MARK: Fields
    private var myTitle = UILabel()
    private let stack = UIStackView()
    private let titleSwitchView = UILabel()
    private let sliderSwitch = UISwitch(frame:CGRect(x: Constants.rectangle, y: Constants.rectangle, width: Constants.rectangle, height: Constants.rectangle))
    let randomColorButton = UIButton(type: .system)
    let colorPickerButton = UIButton(type: .system)
    private let addWishButton: UIButton = UIButton(type: .system)
    private let scheduleWishesButton: UIButton = UIButton(type: .system)
    private var accentColor: UIColor = .black
    
    // - MARK: Main
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // - MARK: ConfigureUI
    private func configureUI() {
        view.backgroundColor = accentColor
        configureTitle()
        configureDescription()
        configureScheduleWishButton()
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
                self?.changeAccentColorAndShow(newColor: UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: Constants.alpha))
            }
        }
    }
    
    // - MARK: Configure Sliders Switch
    private func configureSwitch() {
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
        randomColorButton.backgroundColor = Constants.buttonColor
        randomColorButton.setTitle(Constants.randomButtonText, for: .normal)
        randomColorButton.setTitleColor(accentColor, for: .normal)
        randomColorButton.addTarget(self, action: #selector(randomButtonTouched(_:)), for: .touchUpInside)
        
        view.addSubview(randomColorButton)
        randomColorButton.setWidth(Constants.randomButtonWidth)
        randomColorButton.setHeight(Constants.randomButtonHeight)
        randomColorButton.pinCenterX(to: view)
        randomColorButton.pinBottom(to: titleSwitchView.topAnchor, Constants.randomButtonBottom)
        randomColorButton.layer.cornerRadius = Constants.buttonRadius
    }
    
    @objc
    private func randomButtonTouched(_ sender:UIButton!) {
        changeAccentColorAndShow(newColor: UIColor.getRandomColor())
    }
    
    // - MARK: Configure Color Picker
    private func configureColorPickerButton() {
        colorPickerButton.translatesAutoresizingMaskIntoConstraints = false
        colorPickerButton.backgroundColor = Constants.buttonColor
        colorPickerButton.setTitle(Constants.colorPickerText, for: .normal)
        colorPickerButton.setTitleColor(accentColor, for: .normal)
        view.addSubview(colorPickerButton)
        colorPickerButton.pinBottom(to: randomColorButton.topAnchor, Constants.colorPickerBottom)
        colorPickerButton.setWidth(Constants.colorPickerWidth)
        colorPickerButton.setHeight(Constants.colorPickerHeight)
        colorPickerButton.pinCenterX(to: view)
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
        changeAccentColorAndShow(newColor: viewController.selectedColor)
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
    }
    
    // - MARK: Configure Add Wish
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.translatesAutoresizingMaskIntoConstraints = false;
        addWishButton.setHeight(Constants.addWishButtonHeight)
        addWishButton.pinBottom(to: scheduleWishesButton.topAnchor, Constants.addWishButtonBottom)
        addWishButton.pinHorizontal(to: view, Constants.addWishButtonSide)
        
        addWishButton.backgroundColor = Constants.buttonColor
        addWishButton.setTitleColor(accentColor, for: .normal)
        addWishButton.setTitle(Constants.addWishButtonText, for: .normal)
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action:  #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    // - MARK: Configure Schedule Wish
    private func configureScheduleWishButton() {
        view.addSubview(scheduleWishesButton)
        scheduleWishesButton.translatesAutoresizingMaskIntoConstraints = false;
        scheduleWishesButton.setHeight(Constants.scheduleWishButtonHeight)
        scheduleWishesButton.pinBottom(to: view, Constants.scheduleWishButtonBottom)
        scheduleWishesButton.pinHorizontal(to: view, Constants.scheduleWishButtonSide)
        
        scheduleWishesButton.backgroundColor = Constants.buttonColor
        scheduleWishesButton.setTitleColor(accentColor, for: .normal)
        scheduleWishesButton.setTitle(Constants.scheduleWishButtonText, for: .normal)
        scheduleWishesButton.layer.cornerRadius = Constants.buttonRadius
        scheduleWishesButton.addTarget(self, action:  #selector(scheduleWishButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func scheduleWishButtonPressed() {
        let vc = WishCalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // - MARK: Change Accent Color
    private func changeAccentColorAndShow(newColor: UIColor) {
        accentColor = newColor
        view.backgroundColor = accentColor
        for button in [randomColorButton, addWishButton, scheduleWishesButton, colorPickerButton] {
            button.setTitleColor(accentColor, for: .normal)
        }
    }
}
