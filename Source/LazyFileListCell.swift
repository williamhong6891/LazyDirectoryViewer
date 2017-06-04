//
//  LazyFileListCell.swift
//  LazyDirectoryViewer
//
//  Created by Ho Lun Wan on 26/5/2017.
//
//

import UIKit

open class LazyFileListCell: UITableViewCell {
	@IBOutlet internal var iconImageView: UIImageView?
	@IBOutlet internal var titleLabel: UILabel?
	
	var url: URL? {
		didSet {
			updateUIForURL()
		}
	}

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
	override open func prepareForReuse() {
		super.prepareForReuse()
		
		titleLabel?.text = nil
		iconImageView?.image = nil
	}

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	
	
	
	
	
	// MARK: - Helper
	func updateUIForURL() -> Void {
		titleLabel?.text = url?.lastPathComponent
		
		let bundle = ViewerUtility.resourceBundle
		if url?.hasDirectoryPath ?? false {
			iconImageView?.image = UIImage(named: "ic_folder_36pt", in: bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
		} else {
			iconImageView?.image = UIImage(named: "ic_insert_drive_file_36pt", in: bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
		}
	}
}
