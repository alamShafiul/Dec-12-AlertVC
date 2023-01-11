//
//  ViewController.swift
//  Dec-12-AlertVC
//
//  Created by Admin on 13/12/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var itemLists: [String] = ["Apple", "Ball", "Cat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func showAlertTapped(_ sender: Any) {
        showAlert()
    }
    
    func showAlert() {
        let AlertVC = UIAlertController(title: "Add item", message: "added new item", preferredStyle: .alert)
        
        present(AlertVC, animated: true)
        
        let closeAlertAction = UIAlertAction(title: "Close", style: .cancel) {
            [weak self] _ in
            guard let self = self else {
                return
            }
            self.dismiss(animated: true)
        }
        
        let addItem = UIAlertAction(title: "Add item", style: .default) {
            [weak self] _ in
            guard let self = self else {
                return
            }
            
            if let inputItem = AlertVC.textFields?[0].text {
                self.addNewItem(inputItem)
            }
        }
        AlertVC.addAction(addItem)
        
        AlertVC.addTextField() { item in
            item.placeholder = "enter your item here"
        }
    }
    
    func addNewItem(_ item: String) {
        itemLists.append(item)
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellOne", for: indexPath)
        
        cell.layer.cornerRadius = 4
        
        cell.textLabel?.text = itemLists[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) {
            [weak self] _,_,_ in
            guard let self = self else {
                return
            }
            self.performDelete(index: indexPath)
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeAction
    }
    func performDelete(index: IndexPath) {
        itemLists.remove(at: index.row)
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
