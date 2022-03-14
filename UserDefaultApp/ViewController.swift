//
//  ViewController.swift
//  UserDefaultApp
//
//  Created by igor mekkers on 14.03.2022.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var myView: UIImageView!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func SaveButtonPressed(_ sender: Any) {
        
//        let text = myTextField.text
//
//        UserDefaults.standard.set(text, forKey: "text")
        
//        if let image = UIImage(named: "fishOne") {
//        let imageName = saveImage(image: image)
//            UserDefaults.standard.set(imageName, forKey: "image")
//        }
        let beer = Beer(name: "Hainiken", price: 2)
        UserDefaults.standard.set(encodable: beer, forKey: "beer")
        
    }
    
    @IBAction func loadButtonPressed(_ sender: Any) {
//        guard let imageName = UserDefaults.standard.value(forKey: "image")
//        as? String else { return }
//        myLabel.text = text
//        if let image = loadImage(fileName: imageName) {
//            myView.image = image
//        }
        guard let beer = UserDefaults.standard.value(Beer.self, forKey: "beer") else { return }
        myLabel.text = beer.name
    }
    
    func saveImage(image: UIImage) -> String? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileName = UUID().uuidString
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return nil }
        
        //Check if file exists, remove it if so
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let error {
                print("Could't remove file at path", error)
            }
        }
        do {
            try data.write(to: fileURL)
            return fileName
        } catch let error {
            print("Error saving file with error", error)
            return nil
        }
    }
    func loadImage(fileName: String) -> UIImage? {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imageUrl = documentDirectory.appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }

}
extension ViewController: UITextViewDelegate {
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
