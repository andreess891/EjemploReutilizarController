//
//  CrearContainerViewController.swift
//  Reutilizar
//
//  Created by Jonatan Londoño Taborda on 2/18/17.
//  Copyright © 2017 Jonatan Londoño Taborda. All rights reserved.
//

import UIKit

class CrearContainerViewController: UIViewController, CrearEditarViewControllerDelegate{
    
    @IBOutlet weak var childView: UIView!

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
            vc.accionAEjecutar = Acccion.Crear
        }
    }
    
    func buttonAction(usuario: Usuario) {
        print("Se crea el objeto: \(usuario.nombres!) \(usuario.apellidos!)")
        _ = self.navigationController?.popViewController(animated: true)
    }
}
