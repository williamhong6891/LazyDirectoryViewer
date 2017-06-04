//
//  ViewerUtility.swift
//  LazyDirectoryViewer
//
//  Created by Ho Lun Wan on 4/6/2017.
//
//

import UIKit

internal class ViewerUtility: NSObject {
	static let resourceBundle: Bundle? = {
		let currentBundle = Bundle(for: ViewerUtility.self)
		if let path = currentBundle.path(forResource: "Resource", ofType: "bundle") {
			return Bundle(path: path)
		}
		
		return nil
	}()
}
