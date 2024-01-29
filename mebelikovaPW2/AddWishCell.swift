//
//  AddWishCell.swift
//  mebelikovaPW2
//
//  Created by Мария Беликова on 09.11.2023.
//


import UIKit

final class AddWishCell: UITableViewCell, UITextViewDelegate {
    // MARK: - Constants
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 10
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
        
        static let addButtonText: String = "Add"
        static let addButtonRadius: CGFloat = 10
        static let addButtonOffsetH: CGFloat = 4
        static let addButtonOffsetW: CGFloat = 4
        static let addButtonViewWidth: CGFloat = 40
        
        static let addedTextRadius: CGFloat = 10
        static let addedTextOffsetH: CGFloat = 4
        static let addedTextOffsetW: CGFloat = 4
        static let addedTextPlacehoder: String = "Type your wish here..."
        
        static let shadowOpacity: Float = 0.2
        static let shadowRadius: CGFloat = 10
        static let shadowOffset: CGSize = CGSize(width: 3, height: 3)
        static let shadowColor: CGColor = UIColor.black.cgColor
    }
    
    // MARK: - Fields
    static let reuseId: String = "AddWishCell"
    private let addButton: UIButton = UIButton(type: .system)
    let addedText: UITextField = UITextField()
    var addWish: ((String) -> ())?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure view
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        contentView.addSubview(wrap)
        
        configureWrap(wrap: wrap)
        configureButton(wrap: wrap)
        configureTextView(wrap: wrap)
    }
    
    // MARK: Configure Wrap
    private func configureWrap(wrap: UIView) {
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        
        wrap.layer.shadowOpacity = Constants.shadowOpacity
        wrap.layer.shadowRadius = Constants.shadowRadius
        wrap.layer.shadowOffset = Constants.shadowOffset
        wrap.layer.shadowColor = Constants.shadowColor
    }
    
    // MARK: - Configure Button
    private func configureButton(wrap: UIView) {
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        wrap.addSubview(addButton)
        addButton.backgroundColor = WishMakerViewController.accentColor
        addButton.setTitleColor(.white, for: .normal)
        addButton.setTitle(Constants.addButtonText, for: .normal)
        addButton.layer.cornerRadius = Constants.addButtonRadius
        
        addButton.pinVertical(to: wrap, Constants.addButtonOffsetH)
        addButton.pinRight(to: wrap.trailingAnchor, Constants.addButtonOffsetW)
        addButton.setWidth(Constants.addButtonViewWidth)
        addButton.addTarget(self, action: #selector(addWishButtonTouched(_:)), for: .touchUpInside)
    }
    
    @objc
    private func addWishButtonTouched(_ sender:UIButton!) {
        if (addedText.hasText) {
            addWish?(addedText.text ?? "")
            addedText.text = ""
        }
    }
    
    // MARK: - Configure TextView
    private func configureTextView(wrap: UIView) {
        // addedText.backgroundColor = .lightGray
        addedText.textColor = .black
        addedText.layer.cornerRadius = Constants.addedTextRadius
        addedText.translatesAutoresizingMaskIntoConstraints = false
        addedText.placeholder = Constants.addedTextPlacehoder
        
        wrap.addSubview(addedText)
        addedText.pinRight(to: addButton.leadingAnchor, Constants.addedTextOffsetW)
        addedText.pinLeft(to: wrap.leadingAnchor, Constants.addedTextOffsetW)
        addedText.pinVertical(to: wrap, Constants.addedTextOffsetH)
    }
}
