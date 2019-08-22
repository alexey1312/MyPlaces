//
//  NewPlaceTableViewController.swift
//  MyPlaces
//
//  Created by Admin on 22/08/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
    }

    //MARK: Table view delegate
    //Скрытие клавиатуры
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            //Работа с аллертами
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera",
                                       style: .default) {_ in
            self.chooseImagePicker(sourse: .camera)
            }
            
            let photo = UIAlertAction(title: "Photo",
                                       style: .default) {_ in
            self.chooseImagePicker(sourse: .photoLibrary)
            }
            
            let cencel = UIAlertAction(title: "Cencel",
                                       style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cencel)
            
            present(actionSheet, animated: true)

        } else {
            view.endEditing(true)
        }
    }
    
    
}

//MARK: Text field delegate
extension NewPlaceTableViewController: UITextFieldDelegate{
    
    //Скрываем клавиатуры по нажатию на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: Work with image

extension NewPlaceTableViewController {
    
    func chooseImagePicker(sourse: UIImagePickerController.SourceType) {
         
        if UIImagePickerController.isSourceTypeAvailable(sourse) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            present(imagePicker, animated: true)
        }
        
    }
}


