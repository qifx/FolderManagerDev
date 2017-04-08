//
//  ViewController.swift
//  FolderManagerDev
//
//  Created by qifx on 08/04/2017.
//  Copyright © 2017 Manfred. All rights reserved.
//

import UIKit
import FolderManager

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var tableView: UITableView!
    
    
    var folderManager: FolderManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        folderManager = FolderManager(rootURL: URL.init(fileURLWithPath: docPath))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createDir(_ sender: Any) {
        let ac = UIAlertController(title: "Create a directory on here", message: nil, preferredStyle: .alert)
        ac.addTextField { (tf: UITextField) in
            
        }
        ac.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action: UIAlertAction) in
            
        }))
    }
    
    @IBAction func goUp(_ sender: Any) {
        if folderManager.goToParent() {
            tableView.reloadData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return folderManager.getChilds().0.count
        } else {
            return folderManager.getChilds().1.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let url = indexPath.section == 0 ? (folderManager.getChilds().0)[indexPath.row] : (folderManager.getChilds().1)[indexPath.row]
        cell?.textLabel?.text = url.path
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let url = (folderManager.getChilds().0)[indexPath.row]
            folderManager.goToChild(url: url)
        } else {
            print((folderManager.getChilds().1)[indexPath.row].path)
        }
    }
}

