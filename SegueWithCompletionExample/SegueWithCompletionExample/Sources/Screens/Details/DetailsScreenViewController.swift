//
//  DetailsScreenViewController.swift
//  SegueWithCompletionExample
//
//  Created by Dmytro Hrebeniuk on 9/10/17.
//  Copyright © 2017 Dmytro. All rights reserved.
//

import UIKit

class DetailsScreenViewController: UIViewController {

	var modelObject: ModelObject?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        self.modelObject?.modelMethod()
    }


}
