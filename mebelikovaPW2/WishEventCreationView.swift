//
//  WishEventCreationView.swift
//  mebelikovaPW2
//
//  Created by Мария Беликова on 28.01.2024.
//

import UIKit

final class WishEventCreationView: UIViewController {
    // MARK: Constants
    enum Constants {
        static let windowTitleLabelTop: CGFloat = 26
        static let windowTitleLabelText: String = "New Event"
        static let windowTitleLabelFontSize: CGFloat = 32
        static let windowTitleLabelTextColor: UIColor = .white
        
        static let titleTextFieldPlaceholder: String = "  Title"
        
        static let titleTextFieldLabelTop: CGFloat = 50
        static let titleTextFieldLabelText: String = "Title"
        
        static let descriptionTextFieldPlaceholder: String = "  Description"
        
        static let descriptionTextFieldLabelText: String = "Description"
        
        static let startDatePickerLabelText: String = "Start Date"
        
        static let endDatePickerLabelText: String = "End Date"
        
        static let textFieldLabelTop: CGFloat = 10
        static let textFieldLabelLeft: CGFloat = 10
        static let textFieldLabelFontSize: CGFloat = 20
        static let textFieldLabelTextColor: UIColor = .white
        
        static let textFieldRadius: CGFloat = 10
        static let textFieldTextColor: UIColor = .black
        static let textFieldBackgroundColor: UIColor = .white
        static let textFieldOffsetH: CGFloat = 10
        static let textFieldHeight: CGFloat = 30
        static let textFieldTop: CGFloat = 5
        
        static let saveButtonText: String = "Save"
        static let saveButtonBottom: CGFloat = 10
        static let saveButtonSide: CGFloat = 10
        static let saveButtonHeight: CGFloat = 45
        static let saveButtonRadius: CGFloat = 10
        static let saveButtonColor: UIColor = .white
        
        static let shadowOpacity: Float = 0.2
        static let shadowRadius: CGFloat = 5
        static let shadowOffset: CGSize = CGSize(width: 3, height: 3)
        static let shadowColor: CGColor = UIColor.black.cgColor
    }
    
    // MARK: - Fields
    private let windowTitleLabel = UILabel()
    private let titleTextFieldLabel = UILabel()
    private let titleTextField = UITextField()
    private let descriptionTextFieldLabel = UILabel()
    private let descriptionTextField = UITextField()
    private let startDatePickerLabel = UILabel()
    private let startDatePicker = UIDatePicker()
    private let endDatePickerLabel = UILabel()
    private let endDatePicker = UIDatePicker()
    private let saveButton = UIButton()
    private let titlePickerView = UIPickerView()
    private var titleOptions: [String] = []
    
    var onSave: ((WishEventModel) -> Void)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WishMakerViewController.accentColor
        titleOptions = WishStoringViewController.wishArray
        configureUI()
    }
    
    private func configureUI() {
        configureWindowTitle()
        
        configureTitleTextField()
        configureTextField(textField: titleTextField, placeholder: Constants.titleTextFieldPlaceholder, pin: titleTextFieldLabel)
        
        configureTextFieldLabel(label: descriptionTextFieldLabel, title: Constants.descriptionTextFieldLabelText, pin: titleTextField, shift: Constants.textFieldLabelTop)
        configureTextField(textField: descriptionTextField, placeholder: Constants.descriptionTextFieldPlaceholder, pin: descriptionTextFieldLabel)
        
        configureTextFieldLabel(label: startDatePickerLabel, title: Constants.startDatePickerLabelText, pin: descriptionTextField, shift: Constants.textFieldLabelTop)
        configureStartDatePicker()
        
        configureTextFieldLabel(label: endDatePickerLabel, title: Constants.endDatePickerLabelText, pin: startDatePicker, shift: Constants.textFieldLabelTop)
        configureEndDatePicker()
        
        configureSaveButton()
    }
    
    // - MARK: Configure Window Title
    private func configureWindowTitle() {
        windowTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        windowTitleLabel.text = Constants.windowTitleLabelText
        windowTitleLabel.font = UIFont.boldSystemFont(ofSize: Constants.windowTitleLabelFontSize)
        windowTitleLabel.textColor = Constants.windowTitleLabelTextColor
        addShadow(element: windowTitleLabel)
        
        view.addSubview(windowTitleLabel)
        windowTitleLabel.pinCenterX(to: view)
        windowTitleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.windowTitleLabelTop)
    }
    
    // - Configure Title TextField
    private func configureTitleTextField() {
        configureTextFieldLabel(label: titleTextFieldLabel, title: Constants.titleTextFieldLabelText, pin: windowTitleLabel, shift: Constants.titleTextFieldLabelTop)
        
        let toolbar = UIToolbar()
        view.addSubview(toolbar)
        toolbar.sizeToFit()
        toolbar.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        
        let selectButton = UIBarButtonItem(title: "Choose...", style: .plain, target: self, action: #selector(selectTitle))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissTitlePicker))
        
        toolbar.setItems([selectButton, flexSpace, doneButton], animated: true)
        
        titleTextField.inputAccessoryView = toolbar
        
        titlePickerView.delegate = self
        titlePickerView.dataSource = self
    }
    
    @objc private func selectTitle() {
        titleTextField.resignFirstResponder()
        titleTextField.inputView = titlePickerView
        titlePickerView.reloadAllComponents()
        titleTextField.becomeFirstResponder()
    }
    
    @objc private func dismissTitlePicker() {
        titleTextField.inputView = nil
        titleTextField.resignFirstResponder()
    }
    
    // - MARK: Configure TextField Label
    private func configureTextFieldLabel(label: UILabel, title: String, pin: UIView, shift: CGFloat) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = UIFont.systemFont(ofSize: Constants.textFieldLabelFontSize)
        label.textColor = Constants.textFieldLabelTextColor
        addShadow(element: label)
        
        view.addSubview(label)
        label.pinLeft(to: view, Constants.textFieldLabelLeft)
        label.pinTop(to: pin.bottomAnchor, shift)
    }
    
    // - MARK: Configure TextField
    private func configureTextField(textField: UITextField, placeholder: String, pin: UIView) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.layer.cornerRadius = Constants.textFieldRadius
        textField.textColor = Constants.textFieldTextColor
        textField.backgroundColor = Constants.textFieldBackgroundColor
        addShadow(element: textField)
        
        view.addSubview(textField)
        textField.pinCenterX(to: view)
        textField.setWidth(view.frame.width - 2 * Constants.textFieldOffsetH)
        textField.setHeight(Constants.textFieldHeight)
        textField.pinTop(to: pin.bottomAnchor, Constants.textFieldTop)
    }
    
    // - MARK: Configure Start Date Picker
    private func configureStartDatePicker() {
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            startDatePicker.preferredDatePickerStyle = .automatic
        } else {
            // Fallback on earlier versions
        }
        view.addSubview(startDatePicker)
        
        startDatePicker.pinCenterX(to: view)
        startDatePicker.pinTop(to: startDatePickerLabel.bottomAnchor, Constants.textFieldTop)
    }
    
    // - MARK: Configure End Date Picker
    private func configureEndDatePicker() {
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            endDatePicker.preferredDatePickerStyle = .automatic
        } else {
            // Fallback on earlier versions
        }
        view.addSubview(endDatePicker)
        
        endDatePicker.pinCenterX(to: view)
        endDatePicker.pinTop(to: endDatePickerLabel.bottomAnchor, Constants.textFieldTop)
    }
    
    //- MARK: Configure Save Button
    private func configureSaveButton() {
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false;
        saveButton.setHeight(Constants.saveButtonHeight)
        saveButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.saveButtonBottom)
        saveButton.pinHorizontal(to: view, Constants.saveButtonSide)
        
        saveButton.backgroundColor = Constants.saveButtonColor
        saveButton.setTitleColor(WishMakerViewController.accentColor, for: .normal)
        saveButton.setTitle(Constants.saveButtonText, for: .normal)
        saveButton.layer.cornerRadius = Constants.saveButtonRadius
        addShadow(element: saveButton)
        saveButton.addTarget(self, action:  #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func saveButtonPressed() {
        let event = WishEventModel(
            title: titleTextField.text ?? "",
            description: descriptionTextField.text ?? "",
            startDate: startDatePicker.date,
            endDate: endDatePicker.date
        )
        onSave?(event)
        dismiss(animated: true)
    }
    
    private func addShadow(element: UIView) {
        element.layer.shadowOpacity = Constants.shadowOpacity
        element.layer.shadowRadius = Constants.shadowRadius
        element.layer.shadowOffset = Constants.shadowOffset
        element.layer.shadowColor = Constants.shadowColor
    }
}

// - MARK: UIPicker Extension
extension WishEventCreationView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titleOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titleOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        titleTextField.text = titleOptions[row]
    }
}
