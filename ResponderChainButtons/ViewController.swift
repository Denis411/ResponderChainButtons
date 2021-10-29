//
//  ViewController.swift
//  ResponderChainButtons
//
//  Created by Programmer on 10/29/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
//    array must be in order you wand to assign a responder
    @IBOutlet var textFields: [UITextField]!
    override func viewDidLoad() {
        super.viewDidLoad()
        setToolBar()
        textFields.forEach { $0.delegate = self }
    }
// MARK: - TextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = .yellow
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .blue
    }
 // MARK: - Main functionality
    func setToolBar() {
        let toolBarWidth = UIScreen.main.bounds.width
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: toolBarWidth,
                                              height: 50))
        let upImage = UIImage(systemName: "chevron.up")
        let itemUp = UIBarButtonItem(image: upImage, style: .done, target: self, action: #selector(goUp))
        let downImage = UIImage(systemName: "chevron.down")
        let itemDown = UIBarButtonItem(image: downImage, style: .done, target: self, action: #selector(goDown))
        let flexableSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([ itemUp, itemDown, flexableSpace], animated: true)
        toolBar.sizeToFit()
        textFields.forEach { $0.inputAccessoryView = toolBar }
    }
    @objc func goUp() {
        guard let array = textFields else { return }
        let firstResponder =  findFirsResponder(array: array)
        guard let firstResponder = firstResponder else { return }
        guard firstResponder != 0 else { return }
        let previusReponder = array[firstResponder - 1]
        previusReponder.becomeFirstResponder()
    }
    @objc func goDown() {
        guard let array = textFields else { return }
        let firstResponder =  findFirsResponder(array: array)
        guard let firstResponder = firstResponder else { return }
        guard firstResponder < (array.count - 1) else { return }
        let nextReponder = array[firstResponder + 1]
        nextReponder.becomeFirstResponder()
    }
    func findFirsResponder(array: [UITextField]) -> Int? {
        for element in 0..<array.count {
            if array[element].isFirstResponder {
                return element
            } else {
                continue
            }
        }
        print("First responder was not found in the array \n \(array.debugDescription)")
        return nil
    }
}
