//
//  StoreListController.swift
//  StoreList
//
//  Created by Andrei Bezlepkin on 3.08.23.
//
import SwiftUI
import Foundation
import UIKit

//var storelist: [String] = ["1","2","3","4","5","6"]

class StoreListController: UINavigationController, UITableViewDelegate, UITableViewDataSource {
    
    let screenSize = UIScreen.main.bounds.size
    var model = Model()
    
    private lazy var titleLAbel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Shopping list"
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.systemBlue.cgColor
        label.layer.borderWidth = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var backImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "food basket")
        image.clipsToBounds = true
        image.backgroundColor = UIColor.clear
        return image
    }()
    
    private lazy var listTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.layer.cornerRadius = 12
        table.layer.borderColor = UIColor.systemBlue.cgColor
        table.layer.borderWidth = 2
        table.separatorColor = .systemBlue
        table.separatorInset = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        listTableView.delegate = self
        listTableView.dataSource = self
        configUI()
    }
    
    private func configUI() {
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -3).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(titleLAbel)
        titleLAbel.translatesAutoresizingMaskIntoConstraints = false
        //        titleLAbel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        titleLAbel.centerYAnchor.constraint(equalTo: addButton.centerYAnchor).isActive = true
        titleLAbel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLAbel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleLAbel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        view.addSubview(backImage)
        backImage.translatesAutoresizingMaskIntoConstraints = false
        backImage.layer.cornerRadius = 12
        backImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
        backImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 6).isActive = true
        backImage.trailingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.trailingAnchor, constant: -6).isActive = true
        backImage.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -screenSize.height/2.5).isActive = true
        //        backImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 0).isActive = true
        listTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6).isActive = true
        listTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -6).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
        
    }
    
    
    @objc func addButtonTapped() {
        TextPicker().showPicker(in: self) { [weak self] text in
            self?.model.addItem(title: text)
            self?.listTableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = UIListContentConfiguration.cell()
        
        configuration.text = model.items[indexPath.row].title
        configuration.secondaryText = model.items[indexPath.row].date.formatted(date: .complete, time: .shortened)
        
        cell.accessoryType = model.items[indexPath.row].isCompleted ? .checkmark : .none
        cell.contentConfiguration = configuration
        cell.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Rename") { _, _, completion in
            TextPicker().showPicker(in: self) { [weak self] text in
                self?.model.renameItem(atIndex: indexPath.row, newTitle: text)
                self?.listTableView.reloadRows(at: [indexPath], with: .automatic)
                completion(true)
            }
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            self.model.deleteItem(atIndex: indexPath.row)
            self.listTableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.toggleItems(atIndex: indexPath.row)
        listTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        StoreListController().showNavigationPreview()
    }
}
