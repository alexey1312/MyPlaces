//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Admin on 22/08/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {

    var places: Results<Place>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)

    }

    //MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0: places.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell


        let place = places[indexPath.row]

        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)



        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2 //Сделать границы изображения круглыми
        cell.imageOfPlace.clipsToBounds = true //Обрезать изображения по границе

        return cell
    }
    
    
    //MARK: Table view delegate
    
    //Добавление свайпа с права на лево для удаления ячеек
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let place = places[indexPath.row]
            let action = UIContextualAction(style: .destructive, title: "Delete") {_,_,_ in
                
                StorageManager.deleteObject(place)
                tableView.deleteRows(at: [indexPath], with: .automatic)
        }
            let deleteAction = UISwipeActionsConfiguration.init(actions: [action])
            
            return deleteAction
    }

        //Добавление свайпа с лева на право для релактирования ячеек
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let place = places[indexPath.row]
//        let action = UIContextualAction(style: .normal, title: "Delete") {_,_,_ in
//
//            StorageManager.deleteObject(place)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//    }
//        let deleteAction = UISwipeActionsConfiguration.init(actions: [action])
//
//        return deleteAction
//}


    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        
        newPlaceVC.saveNewPlace()
        tableView.reloadData()
    }
    
    
}
