//
//  GroupsAllTableViewController.swift
//  VKApp
//
//  Created by KKK on 06.04.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController, UISearchBarDelegate {
    
    
 
//    var allGroups: [groupModel] = [
//        groupModel(name: "Машины", image: UIImage(named: "car")!),
//        groupModel(name: "Отпуск", image: UIImage(named: "otpusk")!),
//        groupModel(name: "Работа", image: UIImage(named: "work")!),
//        groupModel(name: "UFO", image: UIImage(named: "ufo")!),
//    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searcheBar.delegate = self
        
        let nib = UINib(nibName: "GroupsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupsTableViewCell")

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if !isSearchBarEmpty {
            return filteredGroups.count
        }
            return allGroups.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsTableViewCell", for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }

//        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupsCell
// //       cell.textLabel?.text = allGroups[indexPath.item].name
// //       cell.imageView?.image = allGroups[indexPath.item].image
        
        var res = allGroups

        if !isSearchBarEmpty {
            res = filteredGroups
        }
        
//        cell.configate(imageUrl: res[indexPath.item].image, name: res[indexPath.item].name)
        cell.configate(imageUrl: "net", name: res[indexPath.item].name)

        
        return cell
    }

    // MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addGroup", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Search
    var filteredGroups: [groupModel] = []
    
    @IBOutlet weak var searcheBar: UISearchBar!
    
    var isSearchBarEmpty: Bool {
      return searcheBar.text?.isEmpty ?? true
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredGroups = searchText.isEmpty ? allGroups: allGroups.filter { (item: groupModel) -> Bool in
            return item.name.lowercased().contains(searchText.lowercased())
        }
        
//        filteredGroups = searchText.isEmpty ? allGroups: allGroups.filter { (item: groupModel) -> Bool in
//            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
        tableView.reloadData()
    }
    
}
