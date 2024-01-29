//
//  WishStoringViewController.swift
//  mebelikovaPW2
//
//  Created by Мария Беликова on 08.11.2023.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let tableRadius: CGFloat = 10
        static let tableOffset: CGFloat = 20
        static let numberOfSections: Int = 2
        
        static let wishesKey: String = "WishArray"
        
        static let addWishSection: Int = 0
        static let writtenWishesSection: Int = 1
        
        static let countOfWrittenWishes: Int = 1
        static let defaultRowsColors: Int = 0
    }
    
    // MARK: - Fields
    private let table: UITableView = UITableView(frame: .zero)
    static var wishArray: [String] = []
    private let defaults = UserDefaults.standard
    private var editingWishIndex: Int?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WishMakerViewController.accentColor
        configureTable()
        loadWishes()
    }
    
    private func loadWishes() {
        if let savedWishes = defaults.object(forKey: Constants.wishesKey) as? [String] {
            WishStoringViewController.wishArray = savedWishes
        }
    }
    
    // MARK: - Configure Table
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = WishMakerViewController.accentColor
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableRadius
        
        table.pin(to: view, Constants.tableOffset)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        defaults.array(forKey: Constants.wishesKey)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Constants.writtenWishesSection:
            return WishStoringViewController.wishArray.count
        case Constants.addWishSection:
            return Constants.countOfWrittenWishes
        default:
            return Constants.defaultRowsColors
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Constants.writtenWishesSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            
            guard let wishCell = cell as? WrittenWishCell else {return cell}
            wishCell.configure(with: WishStoringViewController.wishArray[indexPath.row])
            wishCell.onCellTapped = { [weak self] text in
                self?.editingWishIndex = indexPath.row
                self?.table.reloadData()
            }
            
            return wishCell
        case Constants.addWishSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
            
            guard let wishAddCell = cell as? AddWishCell else {return cell}
            
            if let editingIndex = editingWishIndex {
                wishAddCell.addedText.text = WishStoringViewController.wishArray[editingIndex]
            }
            
            wishAddCell.addWish = { [weak self] value in
                if let editingIndex = self?.editingWishIndex {
                    WishStoringViewController.wishArray[editingIndex] = value
                    self?.editingWishIndex = nil
                } else {
                    WishStoringViewController.wishArray.append(value)
                }
                self?.table.reloadData()
                self?.defaults.set(WishStoringViewController.wishArray, forKey: Constants.wishesKey)
            }
            
            return wishAddCell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            WishStoringViewController.wishArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            table.reloadData()
            defaults.set(WishStoringViewController.wishArray, forKey: Constants.wishesKey)
        }
    }
}
