//
//  MainVC.swift
//  DreamLister
//
//  Created by Bruno Vargas Versignassi de Carvalho on 14/04/17.
//  Copyright © 2017 Bruno Vargas Versignassi de Carvalho. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    //here is different
    var  controller:  NSFetchedResultsController<Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //generateTestData()
        attemptFetch()
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCellTableViewCell
        
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ItemCellTableViewCell, indexPath: NSIndexPath){
        
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections{
            let sectionsInfo = sections[section]
            return sectionsInfo.numberOfObjects
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    func attemptFetch (){
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor (key: "created", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)
        
        self.controller = controller
        do {
            //here are different
            try controller.performFetch()
            
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                //when create new item this nill item will appear with a fade animation
                self.tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case .delete:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
            
        case .update:
            if let indexPath = indexPath {
                
                let cell = self.tableView.cellForRow(at: indexPath) as! ItemCellTableViewCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
            
        case .move:
            
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
            
            if let indexPath = newIndexPath {
                self.tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    
    
    func generateTestData() {
        let item = Item(context: context)
        

        item.title = "Mac Book Pro"
        item.price = 800.0
        item.deatails = "Teste de detalhes"
        
        let item2 = Item(context:context)
        item2.title = "headphones"
        item2.price = 300.0
        item2.deatails = "Teste de detalhes, mais um item"
        
        let item3 = Item(context:context)
        item3.title = "tesla model S"
        item3.price = 8000.0
        item3.deatails = "Carro fodao"
        
        ad.saveContext()
        
    }
}
//shortcut

let ad = UIApplication.shared.delegate as! AppDelegate
let context = ad.persistentContainer.viewContext






