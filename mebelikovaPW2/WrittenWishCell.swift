//
//  WrittenWishCell.swift
//  mebelikovaPW2
//
//  Created by Мария Беликова on 09.11.2023.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 10
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
        
        static let shadowOpacity: Float = 0.2
        static let shadowRadius: CGFloat = 10
        static let shadowOffset: CGSize = CGSize(width: 3, height: 3)
        static let shadowColor: CGColor = UIColor.black.cgColor
    }
    
    // MARK: - Fields
    static let reuseId: String = "WrittenWishCell"
    
    private let wishLabel: UILabel = UILabel()
    var onCellTapped: ((String) -> Void)?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure View
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        
        wrap.layer.shadowOpacity = Constants.shadowOpacity
        wrap.layer.shadowRadius = Constants.shadowRadius
        wrap.layer.shadowOffset = Constants.shadowOffset
        wrap.layer.shadowColor = Constants.shadowColor
        
        wrap.addSubview(wishLabel)
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        
        wishLabel.pin(to: wrap, Constants.wishLabelOffset)
        addTapGestureRecognizer()
    }
    
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    // MARK: - Configure Tapping On Cell
    private func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func cellTapped() {
        onCellTapped?(wishLabel.text ?? "")
    }
}
