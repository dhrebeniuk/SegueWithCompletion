//
//  MainScreenViewController.swift
//  SegueWithCompletionExample
//
//  Created by Dmytro Hrebeniuk on 9/10/17.
//  Copyright © 2017 Dmytro. All rights reserved.
//

import UIKit
import SegueWithCompletion

private let DetailsScreenSegue = "DetailsScreenSegue"
private let ModalScreenSegue = "ModalScreenSegue"

class MainScreenViewController: UIViewController {

	var modelObject: ModelObject?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.modelObject = ModelObject()
    }

	// MARK: - IBActions
	
	@IBAction func openDetailsScreenAction(_ sender: Any) {
		
		self.perform(segue: DetailsScreenSegue) { [weak self] (detailsScreen: DetailsScreenViewController) in
			detailsScreen.modelObject = self?.modelObject
		}
	}
	
	@IBAction func openModalScreenAction(_ sender: Any) {

		self.performWithNavigationController(segue: ModalScreenSegue) { [weak self] (modalScreen: ModalScreenViewController) in
			modalScreen.modelObject = self?.modelObject
		}
	}
	
	// MARK: - Unwind segues
	
	@IBAction func dismiss(unwindSegue: UIStoryboardSegue) {
		
	}
}
