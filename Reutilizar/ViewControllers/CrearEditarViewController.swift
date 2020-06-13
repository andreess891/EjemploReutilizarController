//
//  CrearEditarViewController.swift
//  Reutilizar
//
//  Created by Jonatan Londoño Taborda on 2/18/17.
//  Copyright © 2017 Jonatan Londoño Taborda. All rights reserved.
//

import UIKit

protocol CrearEditarViewControllerDelegate: class {
    func buttonAction(usuario: Usuario)
}

public enum Acccion {
    case Crear
    case Editar
}

class CrearEditarViewController: UIViewController, UITextFieldDelegate {
    
    var usuario: Usuario?
    var accionAEjecutar: Acccion!
    weak var delegate:CrearEditarViewControllerDelegate?
    var currentString = ""
    
    @IBOutlet weak var txtNombres: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var crearEditarButton: UIButton!
    @IBOutlet weak var txtPrecio: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtPrecio.delegate = self
        
        switch accionAEjecutar! {
        case .Crear:
            self.crearEditarButton.setTitle("Crear", for: UIControl.State.normal)
            self.enableButton(enable: false)
        case .Editar:
            self.enableButton(enable: true)
            self.crearEditarButton.setTitle("Editar", for: UIControl.State.normal)
            
            if usuario?.nombres == nil || (usuario?.nombres?.isEmpty)! {
                self.enableButton(enable: false)
            } else {
                self.txtNombres.text = usuario?.nombres!
            }
            
            if usuario?.apellidos == nil || (usuario?.apellidos?.isEmpty)! {
                self.enableButton(enable: false)
            } else {
                self.txtApellidos.text = usuario?.apellidos!
            }
        }
        
        txtNombres.addTarget(self, action: #selector(checkFields), for: .editingChanged)
        txtApellidos.addTarget(self, action: #selector(checkFields), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func enableButton(enable: Bool) {
        if enable {
            self.crearEditarButton.isUserInteractionEnabled = true
            self.crearEditarButton.backgroundColor = UIColor.green
        } else {
            self.crearEditarButton.isUserInteractionEnabled = false
            self.crearEditarButton.backgroundColor = UIColor.lightGray
        }
    }
    
    @objc func checkFields(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        guard
            let nomb = txtNombres.text, !nomb.isEmpty,
            let apell = txtApellidos.text, !apell.isEmpty
            else {
                enableButton(enable: false)
                return
            }
        
        enableButton(enable: true)
    }
    
    @IBAction func CrearEditarAction(_ sender: Any) {
        delegate?.buttonAction(usuario: Usuario.init(nombres: txtNombres.text!, apellidos: txtApellidos.text!))
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
            else {
                
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
            else {
                
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            currentString += string
            print(currentString)
            formatCurrency(string: currentString)
        default:
            let array = Array(string)
            var currentStringArray = Array(currentString)
            if array.count == 0 && currentStringArray.count != 0 {
                currentStringArray.removeLast()
                currentString = ""
                for character in currentStringArray {
                    currentString += String(character)
                }
                formatCurrency(string: currentString)
            }
        }
        return false
    }
    
    func formatCurrency(string: String) {
        print("format \(string)")
        if string.isEmpty {
            txtPrecio.text = string
        } else {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = NSLocale(localeIdentifier: "es_CO") as Locale?
            let numberFromField = (NSString(string: currentString).doubleValue)
            var textFormated = formatter.string(from: NSNumber(value: numberFromField))
            textFormated = textFormated?.replacingOccurrences(of: "$", with: "").trimmingCharacters(in: CharacterSet.whitespaces)
            txtPrecio.text = textFormated
        }
        print(txtPrecio.text!)
    }
}
