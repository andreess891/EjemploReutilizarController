//
//  EditarContainerViewController.swift
//  Reutilizar
//
//  Created by Jonatan Londoño Taborda on 2/18/17.
//  Copyright © 2017 Jonatan Londoño Taborda. All rights reserved.
//

import UIKit

class EditarContainerViewController: UIViewController, CrearEditarViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "CrearEditarSegue" {
            let vc = segue.destination as! CrearEditarViewController
            vc.delegate = self
            vc.usuario = Usuario.init(nombres: "Jonatan Andres", apellidos: "Londoño Taborda")
            vc.accionAEjecutar = Acccion.Editar
        }
    }
    
    func buttonAction(usuario: Usuario) {
        print("Se edita el objeto: \(usuario.nombres!) \(usuario.apellidos!)")
        _ = self.navigationController?.popViewController(animated: true)
    }
}
