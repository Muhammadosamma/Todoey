//
//  ViewController.swift
//  Todoey
//
//  Created by muhammad osama on 12/26/18.
//  Copyright © 2018 mosama. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let item1 = Item()
        item1.title = "Find Mike"
        item1.done = true
        itemArray.append(item1)
        
        let item2 = Item()
        item2.title = "Buy Eggos"
        itemArray.append(item2)
        
        let item3 = Item()
        item3.done = true
        item3.title = "Destory Demogorgon"
        itemArray.append(item3)
        
//        let data = self.defaults.data(forKey: "TodoListArray")
//
//        if let items = try? JSONDecoder().decode([Item].self, from: data!)  {
//
//            itemArray = items
//
//        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       
        
        tableView.reloadData()
        
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            
            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            do {
                
                let data = try JSONEncoder().encode(self.itemArray)
            
                self.defaults.set(data, forKey: "TodoListArray")
            
            }catch {
                
                print("error")
            
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    

}

