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
			print("New directory path: \(directoryURL?.path ?? "")")

			itemURLs.removeAll()
			if let directoryURL = directoryURL {
				do {
					let urls = try FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: [])
					itemURLs.append(contentsOf: urls)
				} catch let err {
					print("  Error: \(err)")
				}
				
			}
			navigationTitleLabel?.text = directoryURL?.path
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
	open override func didMove(toParentViewController parent: UIViewController?) {
		super.didMove(toParentViewController: parent)
		
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
