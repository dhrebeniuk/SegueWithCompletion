//
//  ModalScreenViewController.swift
//  SegueWithCompletionExample
//
//  Created by Dmytro Hrebeniuk on 10/10/17.
//  Copyright © 2017 Dmytro. All rights reserved.
//

import UIKit

class ModalScreenViewController: UIViewController {

	var modelObject: ModelObject?

    override func viewDidLoad() {
        super.viewDidLoad()

		self.modelObject?.modelMethod()
    }

}
