//
//  UIViewControllerSegueExtension.swift
//  SegueWithCompletion
//
//  Created by Dmytro Hrebeniuk on 9/5/17.
//  Copyright © 2017 Dmytro Hrebeniuk. All rights reserved.
//


import UIKit

private var associatedSwizzleState = false
private var associatedSegueIdentifier: String?
private var associatedCompletionHandler: ((UIViewController) -> ())?

public extension UIViewController {

	private static var isPrepareForSegueSwizzled: Bool {
		get {
			return objc_getAssociatedObject(self, &associatedSwizzleState) as? Bool ?? false
		}
		set {
			objc_setAssociatedObject(self,
			                         &associatedSwizzleState,
			                         newValue,
			                         objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
		}
	}
	
	private var performingSegueIdentifier: String? {
		get {
			return objc_getAssociatedObject(self, &associatedSegueIdentifier) as? String
		}
		set {
			objc_setAssociatedObject(self,
			                         &associatedSegueIdentifier,
			                         newValue,
			                         objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
		}
	}
	
	private var performingSegueCompletionHandler: ((UIViewController) -> ())? {
		get {
			return objc_getAssociatedObject(self, &associatedCompletionHandler) as? ((UIViewController) -> ())
		}
		set {
			objc_setAssociatedObject(self,
			                         &associatedCompletionHandler,
			                         newValue,
			                         objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
		}
	}
	
	public func perform(segue identifier: String, prepare prepareHandler: ((UIViewController) -> ())? = nil) {
		
		if !UIViewController.isPrepareForSegueSwizzled {
			let originalSelector = #selector(UIViewController.prepare(for:sender:))
			let swizzledSelector = #selector(UIViewController.swizzledPrepare(for:sender:))
			
			let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector)
			let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector)
			
			method_exchangeImplementations(originalMethod, swizzledMethod)

			UIViewController.isPrepareForSegueSwizzled = true
		}
		
		self.performingSegueIdentifier = identifier
		self.performingSegueCompletionHandler = prepareHandler
		
		self.performSegue(withIdentifier: identifier, sender: self)
	}

	@objc private func swizzledPrepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let performingSegueIdentifier = self.performingSegueIdentifier,
		   segue.identifier == performingSegueIdentifier
		{
			self.performingSegueIdentifier = nil
			
			self.performingSegueCompletionHandler?(segue.destination)
			
			self.performingSegueCompletionHandler = nil
		}
		else {
			self.swizzledPrepare(for: segue, sender: self)
		}
	}

}
