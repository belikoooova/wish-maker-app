//
//  WishEventCell.swift
//  mebelikovaPW2
//
//  Created by Мария Беликова on 27.01.2024.
//

import UIKit

final class WishEventCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapCornerRadius: CGFloat = 10
        static let wrapBorderWidth: CGFloat = 1
        static let wrapBorderColor: CGColor = UIColor.lightGray.cgColor
        static let wrapOffset: CGFloat = 5
        
        static let titleLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 16)
        static let titleLabelNumberOfLines = 0
        static let titleLabelOffset: CGFloat = 10
        
        static let descriptionLabelFont: UIFont = UIFont.systemFont(ofSize: 14)
        static let descriptionLabelNumberOfLines = 0
        static let descriptionLabelOffsetH: CGFloat = 10
        static let descriptionLabelOffsetV: CGFloat = 5
        
        static let dateLabelFont: UIFont = UIFont.systemFont(ofSize: 12)
        static let dateLabelOffsetH: CGFloat = 10
        static let dateLabelOffsetV: CGFloat = 0
        
        static let endDateLabelOffsetB: CGFloat = 10
        
        static let shadowOpacity: Float = 0.2
        static let shadowRadius: CGFloat = 5
        static let shadowOffset: CGSize = CGSize(width: 3, height: 3)
        static let shadowColor: CGColor = UIColor.black.cgColor
        
        static let dateStyle: DateFormatter.Style = .medium
    }
    
    // MARK: - Fields
    static let reuseId: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    private let dateFormatter: DateFormatter = DateFormatter()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        dateFormatter.dateStyle = Constants.dateStyle
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(dateFormatter.string(from: event.startDate))"
        endDateLabel.text = "End Date: \(dateFormatter.string(from: event.endDate))"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.backgroundColor = Constants.wrapColor
        wrapView.layer.cornerRadius = Constants.wrapCornerRadius
        wrapView.layer.borderWidth = Constants.wrapBorderWidth
        wrapView.layer.borderColor = Constants.wrapBorderColor
        
        wrapView.layer.shadowOpacity = Constants.shadowOpacity
        wrapView.layer.shadowRadius = Constants.shadowRadius
        wrapView.layer.shadowOffset = Constants.shadowOffset
        wrapView.layer.shadowColor = Constants.shadowColor
        
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        wrapView.pinHorizontal(to: self, Constants.wrapOffset)
        wrapView.pinVertical(to: self, Constants.wrapOffset)
    }
    
    private func configureTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.font = Constants.titleLabelFont
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.pinTop(to: wrapView, Constants.titleLabelOffset)
        titleLabel.pinHorizontal(to: wrapView, Constants.titleLabelOffset)
    }
    
    private func configureDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.font = Constants.descriptionLabelFont
        descriptionLabel.numberOfLines = Constants.descriptionLabelNumberOfLines
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.descriptionLabelOffsetV)
        descriptionLabel.pinHorizontal(to: wrapView, Constants.descriptionLabelOffsetH)
    }
    
    private func configureStartDateLabel() {
        wrapView.addSubview(startDateLabel)
        startDateLabel.font = Constants.dateLabelFont
        
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.pinHorizontal(to: wrapView, Constants.dateLabelOffsetH)
        startDateLabel.pinTop(to: descriptionLabel.bottomAnchor, Constants.descriptionLabelOffsetV)
    }
    
    private func configureEndDateLabel() {
        wrapView.addSubview(endDateLabel)
        endDateLabel.font = Constants.dateLabelFont
        
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.pinHorizontal(to: wrapView, Constants.dateLabelOffsetH)
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, Constants.descriptionLabelOffsetV)
        endDateLabel.pinBottom(to: wrapView, Constants.endDateLabelOffsetB)
    }
}
