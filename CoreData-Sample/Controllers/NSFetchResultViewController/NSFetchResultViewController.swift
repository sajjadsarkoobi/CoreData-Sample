//
//  NSFetchResultViewController.swift
//  CoreData-Sample
//
//  Created by Sajjad Sarkoobi on 1/27/22.
//

import UIKit
import CoreData

class NSFetchResultViewController: UIViewController {

    //IBOutlets:
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButtonAction(_ sender: UIButton) {
        insertNewName()
    }
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //Sajjad: Replaycing array with core data
   // var nameList: [String] = [ "Sajjad", "John", "Ali", "Neda"]
    
    var fetchResultController: NSFetchedResultsController<NameList>!
    
    let viewContext = NSFetchNameListManager.shared.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        loadSavedData()
        //reloadTableView()
    }
    
    func configView() {
        title = "NSFetchResultViewController"
        addButton.layer.cornerRadius = 5
        tableView.delegate = self
        tableView.dataSource = self
        registerNibs()
    }
    
    func insertNewName() {
        guard let name = textField.text, !name.isEmpty else {
            return
        }
//        nameList.append(name)
//
//        tableView.beginUpdates()
//        tableView.insertRows(at: [IndexPath(row: nameList.count - 1, section: 0)], with: .fade)
//        tableView.endUpdates()
        
        NSFetchNameListManager.shared.addName(name: name)
    }
    
    func loadSavedData() {
        if fetchResultController == nil {
            let request = NSFetchRequest<NameList>(entityName: "NameList")
            let sort = NSSortDescriptor(key: "name", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20
            
            fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
        }
        
        do {
            try fetchResultController.performFetch()
            reloadTableView()
        } catch {
            print("Error in fetching data from NSFetchedResultsController")
        }
    }
}

extension NSFetchResultViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .right)
        case .move:
            break
        case .update:
            break
        @unknown default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}


extension NSFetchResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func registerNibs() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return nameList.count
        if let sectionInfo = fetchResultController.sections?[section] {
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        //config.text = nameList[indexPath.row]
        let text = fetchResultController.object(at: indexPath)
        config.text = text.name
        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //nameList.remove(at: indexPath.row)
            
            let nameObj = fetchResultController.object(at: indexPath)
            NSFetchNameListManager.shared.deleteName(nameList: nameObj)
            
          //  tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
