//
//  MainViewController.swift
//  LazyDirectoryViewer
//
//  Created by Ho Lun Wan on 4/6/2017.
//
//

import UIKit

class MainViewController: UITableViewController {
	internal let appDir				= "app"
	internal let documentDir		= "doc"
	internal let libraryDir			= "lib"
	internal let appSupportDir		= "appSup"
	internal let cacheDir			= "cache"
	internal let tmpDir				= "tmp"
	
	@IBOutlet var pathTextField: UITextField?
	
	internal var definedDirectories: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

		definedDirectories = [
			appDir,
			documentDir,
			libraryDir,
			appSupportDir,
			cacheDir,
			tmpDir,
		]
		tableView.backgroundView = UIView(frame: CGRect.zero)

		// Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	

	
	// MARK: - Helper
	func resignAllPossibleFirstResponders() -> Void {
		pathTextField?.resignFirstResponder()
	}
	
	
	
	
	// MARK: - Touch
	@IBAction func onTouchShowButton(_ sender: Any) {
		let url = URL(fileURLWithPath: pathTextField?.text ?? "")
		gotoViewer(forURL: url)
	}
	@IBAction func onTouchBackground(_ sender: Any) {
		resignAllPossibleFirstResponders()
	}
	
	
	
	
	// MARK: - Goto
	func gotoViewer(forURL url: URL?) -> Void {
		let vc = LazyDirectoryViewer.create()
		vc.directoryURL = url
		
		let nav = UINavigationController(rootViewController: vc)
		present(nav, animated: true, completion: nil)
	}
	
	
	

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return definedDirectories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let type = definedDirectories[indexPath.row]

		if type == appDir {
			cell.textLabel?.text = "Application Root"
		} else if type == documentDir {
			cell.textLabel?.text = "Document"
		} else if type == libraryDir {
			cell.textLabel?.text = "Library"
		} else if type == appSupportDir {
			cell.textLabel?.text = "Application Support"
		} else if type == cacheDir {
			cell.textLabel?.text = "Caches"
		} else if type == tmpDir {
			cell.textLabel?.text = "Temporary Directory"
		}

        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let type = definedDirectories[indexPath.row]
		
		if type == appDir {
			pathTextField?.text = NSHomeDirectory()
		} else if type == documentDir {
			let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
			pathTextField?.text = urls.first?.path
		} else if type == libraryDir {
			let urls = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
			pathTextField?.text = urls.first?.path
		} else if type == appSupportDir {
			let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
			pathTextField?.text = urls.first?.path
		} else if type == cacheDir {
			let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
			pathTextField?.text = urls.first?.path
		} else if type == tmpDir {
			pathTextField?.text = NSTemporaryDirectory()
		}
		
		resignAllPossibleFirstResponders()
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
