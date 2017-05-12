//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Bruno Vargas Versignassi de Carvalho on 17/04/17.
//  Copyright © 2017 Bruno Vargas Versignassi de Carvalho. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailField: CustomTextField!
    
    @IBOutlet weak var thumbImage: UIImageView!
    
    var stores = [Store]()
    var itemToEdit : Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem{
        
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        }
        storePicker.dataSource = self
        storePicker.delegate = self
        
        //createStores()
        getStores()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //UIPickerViewDelegate
    }
    
    
    func createStores() {
        let store = Store(context: context)
        store.name = "Americanas"
        
        let store2 = Store(context: context)
        store2.name = "Submarino"
        
        let store3 = Store(context: context)
        store3.name = "Extra"
        
        let store4 = Store(context: context)
        store4.name = "Ricardo Eletro"
        
        ad.saveContext()
    }
    
    func getStores () {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do{
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
        
            // handle the error 
            print("deu ruim mano")
        }
        
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        var item: Item!
        let picture = Image(context: context)
         picture.image = thumbImage.image
        
        
        
        
        if itemToEdit == nil{
            item = Item(context: context)
        } else {
            item = itemToEdit
            
        }
        
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = priceField.text  {
            item.price = (price as NSString).doubleValue
        }
        
        if let detail = detailField.text {
            item.deatails = detail
        }
        item.toImage = picture
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    func loadItemData()  {
        if let item = itemToEdit{
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailField.text = item.deatails
            
            thumbImage.image = item.toImage?.image as? UIImage
            
            
            if let store = item.toStore {
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent:0,animated: false)
                        break
                    }
                    index = index + 1
                } while (index < stores.count)
            }
        }
        
    }
    @IBAction func addImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
}
