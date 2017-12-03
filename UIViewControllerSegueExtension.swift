//
//  UIViewControllerSegueExtension.swift
//  SegueWithCompletion
//
//  Created by Dmytro Hrebeniuk on 9/5/17.
//  Copyright © 2017 Dmytro Hrebeniuk. All rights reserved.
//


import UIKit

private typealias SegueHandler = (UIViewController) -> ()

private var kAssociatedSwizzleState = false
private var kAssociatedSegueData = "associatedSegueData"

fileprivate class SegueHandlerData {
	fileprivate let segueIdentifier: String
	fileprivate let isSegueWithNavigationController: Bool
	fileprivate let segueHandler: SegueHandler?
	
	init (segueIdentifier: String,  isSegueWithNavigationController: Bool = false, segueHandler: SegueHandler? = nil) {
		self.segueIdentifier = segueIdentifier
		self.isSegueWithNavigationController = isSegueWithNavigationController
		self.segueHandler = segueHandler
	}
}

public extension UIViewController {
	
	private static var isPrepareForSegueSwizzled: Bool {
		get {
			return objc_getAssociatedObject(self, &kAssociatedSwizzleState) as? Bool ?? false
		}
		set {
			objc_setAssociatedObject(self,
			                         &kAssociatedSwizzleState,
			                         newValue,
			                         objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
		}
	}
	
	private var performingSegueData: SegueHandlerData? {
		get {
			return objc_getAssociatedObject(self, &kAssociatedSegueData) as? SegueHandlerData
		}
		set {
			objc_setAssociatedObject(self,
			                         &kAssociatedSegueData,
			                         newValue,
			                         objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
		}
	}
	
	public func perform<T>(segue identifier: String, prepare prepareHandler: ((T) -> ())? = nil) {
		self.swizzleFrepareForSegueIfNeeded()
		
		self.performingSegueData = SegueHandlerData(segueIdentifier: identifier) {
			(viewController: UIViewController) in
			(viewController as? T).map { prepareHandler?($0) }
		}
		
		self.performSegue(withIdentifier: identifier, sender: self)
	}
	
	public func performWithNavigationController<T>(segue identifier: String, prepare prepareHandler: ((T) -> ())? = nil) {
		self.swizzleFrepareForSegueIfNeeded()
		
		self.performingSegueData = SegueHandlerData(segueIdentifier: identifier, isSegueWithNavigationController: true) {
			(viewController: UIViewController) in
			(viewController as? T).map { prepareHandler?($0) }
		}
		
		self.performSegue(withIdentifier: identifier, sender: self)
	}
	
	private func swizzleFrepareForSegueIfNeeded() {
		if !UIViewController.isPrepareForSegueSwizzled {
			let originalSelector = #selector(UIViewController.prepare(for:sender:))
			let swizzledSelector = #selector(UIViewController.swizzledPrepare(for:sender:))
			
			let originalMethod = class_getInstanceMethod(self.classForCoder, originalSelector)
			let swizzledMethod = class_getInstanceMethod(self.classForCoder, swizzledSelector)
			
			originalMethod.map() { originalMethod in
				swizzledMethod.map() { swizzledMethod in
					method_exchangeImplementations(originalMethod, swizzledMethod)
				}
			}
			
			UIViewController.isPrepareForSegueSwizzled = true
		}
	}
	
	@objc private func swizzledPrepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let performingSegueData = self.performingSegueData {
			if performingSegueData.segueIdentifier == segue.identifier {
				
				let isSegueWithNavigationController = self.performingSegueData?.isSegueWithNavigationController ?? false
				
				if isSegueWithNavigationController {
					_ = (segue.destination as? UINavigationController).map() { navigationController in
						navigationController.topViewController.map() { destinationViewController in
							performingSegueData.segueHandler?(destinationViewController)
						}
					}
				}
				else {
					performingSegueData.segueHandler?(segue.destination)
				}
				
				self.performingSegueData = nil
			}
		}
		else {
			self.swizzledPrepare(for: segue, sender: self)
		}
	}
}
