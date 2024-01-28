//
//  WishCalendarViewController.swift
//  mebelikovaPW2
//
//  Created by Мария Беликова on 27.01.2024.
//

import UIKit

final class WishCalendarViewController: UIViewController {
    // - MARK: Constants
    enum Constants {
        static let contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static let collectionTop: CGFloat = 5
        static let numberOfCollectionCells = 10
        static let collectionCellOffsetH: CGFloat = 10
        static let collectionCellHeight: CGFloat = 110
        
        static let addButtonHeight: CGFloat = 45
        static let addButtonSide: CGFloat = 10
        static let addButtonColor: UIColor = .white
        static let addButtonText: String = "Add new event"
        static let addButtonCornerRadius: CGFloat = 10
        
        static let shadowOpacity: Float = 0.2
        static let shadowRadius: CGFloat = 5
        static let shadowOffset: CGSize = CGSize(width: 3, height: 3)
        static let shadowColor: CGColor = UIColor.black.cgColor
        
        static let eventsKey: String = "Events"
    }
    
    // MARK: - Fields
    private let addButton: UIButton = UIButton()
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private var events: [WishEventModel] = []
    private let defaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WishMakerViewController.accentColor
        configureAddButton()
        configureCollection()
        loadEvents()
    }
    
    private func loadEvents() {
        let decoder = JSONDecoder()
        if let savedEvents = UserDefaults.standard.object(forKey: Constants.eventsKey) as? Data,
           let loadedEvents = try? decoder.decode([WishEventModel].self, from: savedEvents) {
            events = loadedEvents
            return
        }
        events = []
    }
    
    // MARK: - Configure Add Button
    private func configureAddButton() {
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        addButton.setHeight(Constants.addButtonHeight)
        addButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        addButton.pinHorizontal(to: view, Constants.addButtonSide)
        
        addButton.backgroundColor = Constants.addButtonColor
        addButton.setTitleColor(WishMakerViewController.accentColor, for: .normal)
        addButton.setTitle(Constants.addButtonText, for: .normal)
        addButton.layer.cornerRadius = Constants.addButtonCornerRadius
        
        addButton.layer.shadowOpacity = Constants.shadowOpacity
        addButton.layer.shadowRadius = Constants.shadowRadius
        addButton.layer.shadowOffset = Constants.shadowOffset
        addButton.layer.shadowColor = Constants.shadowColor
        
        addButton.addTarget(self, action:  #selector(addButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func addButtonPressed() {
        let creationView = WishEventCreationView()
        creationView.onSave = { [weak self] newEvent in
            self?.addNewEvent(newEvent)
        }
        present(creationView, animated: true)
    }
    
    private func addNewEvent(_ event: WishEventModel) {
        events.append(event)
        collectionView.reloadData()
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(events) {
            UserDefaults.standard.set(encoded, forKey: Constants.eventsKey)
        }
    }
    
    // MARK: - Configure Collection
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = WishMakerViewController.accentColor
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        
        setLayoutForCollection()
        collectionView.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseId
        )
        defaults.array(forKey: Constants.eventsKey)
        
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: addButton.bottomAnchor, Constants.collectionTop)
    }
    
    private func setLayoutForCollection() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.invalidateLayout()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return events.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseId, for: indexPath)
        
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }
        
        let event = events[indexPath.row]
        wishEventCell.configure(with: event)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - Constants.collectionCellOffsetH, height: Constants.collectionCellHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
