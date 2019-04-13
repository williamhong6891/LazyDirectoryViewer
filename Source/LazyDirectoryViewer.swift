//
//  LazyDirectoryViewer.swift
//  LazyDirectoryViewer
//
//  Created by Ho Lun Wan on 26/5/2017.
//
//

import UIKit

/**
List items within the desired directory
*/
open class LazyDirectoryViewer: UITableViewController {
	@IBOutlet internal var closeButton: UIBarButtonItem!
	@IBOutlet var navigationTitleLabel: UILabel?
	
	/**
	Directory to show
	*/
	public var directoryURL: URL? {
		didSet {
			itemURLs.removeAll()
			if let directoryURL = directoryURL {
				let pathStr = directoryURL.path
				let attr = self.navigationController?.navigationBar.titleTextAttributes
				navigationTitleLabel?.attributedText = NSAttributedString(string: pathStr, attributes: attr)
				
				do {
					let urls = try FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: [])
					itemURLs.append(contentsOf: urls)
				} catch {
					self.showError(error)
				}
			} else {
				navigationTitleLabel?.attributedText = nil
			}
		}
	}
	internal var itemURLs: [URL]	= []

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    open override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
		
	}
	open override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		if navigationController == nil || navigationController?.viewControllers.first == self {
			navigationItem.leftBarButtonItems = [ closeButton ]
		}
	}

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	
	
	
	
	/**
	Create this view controller
	*/
	open class func create() -> LazyDirectoryViewer {
		if let vc = UIStoryboard(name: "Viewer", bundle: Bundle(for: LazyDirectoryViewer.self)).instantiateViewController(withIdentifier: "LazyDirectoryViewer") as? LazyDirectoryViewer {
			return vc
		}
		
		return LazyDirectoryViewer(nibName: nil, bundle: nil)
	}
	
	
	
	
	
	// MARK: - Helper
	func showError(_ error: Error) -> Void {
		let vc = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
		vc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		self.present(vc, animated: true, completion: nil)
	}
	
	
	
	
	// MARK: - Touch
	@IBAction func onTouchCloseButton(_ sender: Any) {
		presentingViewController?.dismiss(animated: true, completion: nil)
	}
	@IBAction func onTouchTitleLabel(_ sender: Any) {
		UIPasteboard.general.string = directoryURL?.path
		
		let vc = UIAlertController(title: "Copied directory path", message: nil, preferredStyle: .alert)
		vc.addAction(UIAlertAction(title: "Confirm", style: .cancel, handler: nil))
		present(vc, animated: true, completion: nil)
	}
	
	
	
	
	
	// MARK: - Goto
	internal func gotoDirectoryListing(_ directoryURL: URL) -> Void {
		let vc = LazyDirectoryViewer.create()
		vc.directoryURL = directoryURL
		navigationController?.pushViewController(vc, animated: true)
	}
	
	
	
	
    // MARK: - Table view data source
    override open func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemURLs.count
    }

    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let itemURL = itemURLs[indexPath.row]

		if let cell = cell as? LazyDirectoryViewCell {
			cell.url = itemURL
		}

        return cell
    }
	
	
	
	
	// MARK: - UITableViewDelegate
	open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let itemURL = itemURLs[indexPath.row]
		if itemURL.hasDirectoryPath {
			gotoDirectoryListing(itemURL)
		}
	}
	open override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
		let itemURL = itemURLs[indexPath.row]
		let fm = FileManager.default
		
		do {
			let attr = try fm.attributesOfItem(atPath: itemURL.path)
			var str = ""
			for (key, value) in attr {
				str += "\(key.rawValue): \(value)\n"
			}
			let vc = UIAlertController(title: "", message: str, preferredStyle: .alert)
			vc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
			self.present(vc, animated: true, completion: nil)
		} catch {
			self.showError(error)
		}
	}


    // Override to support conditional editing of the table view.
    open override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    open override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			let fm = FileManager.default
			let itemURL = itemURLs[indexPath.row]
			do {
				try fm.removeItem(at: itemURL)
				itemURLs.remove(at: indexPath.row)
				
				// Delete the row from the data source
				tableView.deleteRows(at: [indexPath], with: .fade)
			} catch {
				self.showError(error)
			}
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
