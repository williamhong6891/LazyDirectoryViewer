//
//  Utility+File.swift
//  Trails
//
//  Created by Ho Lun Wan on 19/9/2017.
//  Copyright © 2017 Ho Lun Wan. All rights reserved.
//

import Foundation

/////////////////////////////////////////////////////////////////
//	File read/write
/////////////////////////////////////////////////////////////////
class Utility {
	/**
		Write data to certain path with name and extension
	*/
	class func writeData(_ data: Data, toDirectory url: URL, withName name: String, extension ext: String) throws -> Void {
		let finalURL = url.appendingPathComponent(name).appendingPathExtension(ext)
		let fm = FileManager.default
		
		// Create file first
		try fm.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
		fm.createFile(atPath: finalURL.path, contents: nil, attributes: nil)
		
		// Write data
		let handle = try FileHandle(forWritingTo: finalURL)
		handle.write(data)
		handle.closeFile()
	}
}
