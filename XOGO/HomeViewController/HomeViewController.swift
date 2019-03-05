//
//  HomeViewController.swift
//  XOGO
//
//  Created by siddharth on 01/03/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var emailPassedFromLogin: String?
    
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
    }
    
}


extension HomeViewController: SlideMenuDelegate {
    
    func slideMenuItemSelectedAtIndex(_ index: Int32) {
        let topViewController : UIViewController = self.navigationController!.topViewController!
        print("View Controller is : \(topViewController) \n", terminator: "")
        switch(index){
        case 0:
            print("Home\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("HomeViewController")
            break
        case 1:
            print("Players\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("PlayersListViewController")
            break
        case 2:
            print("Account\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("AccountViewController")
            break
        case 3:
            print("Library\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("LibraryListViewController")
            break
        case 4:
            print("Playlists\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("PlaylistsListViewController")
            break
        case 5:
            print("Realtime\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("RealtimeViewController")
            break
        case 6:
            print("Upgrade\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("UpgradeViewController")
            break
        default:
            print("default\n", terminator: "")
        }
    }
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
        
        let topViewController : UIViewController = self.navigationController!.topViewController!
        
        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
            print("Same VC")
        } else {
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }
    
    func addSlideMenuButton(){
        let btnShowMenu = UIButton(type: UIButton.ButtonType.system)
        btnShowMenu.setImage(UIImage(named: "hanburger-menu"), for: UIControl.State())
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowMenu.addTarget(self, action: #selector(HomeViewController.onSlideMenuButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        self.navigationItem.leftBarButtonItem = customBarItem;
    }
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : MenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self
        menuVC.emailPassedFromLogin = emailPassedFromLogin
        self.view.addSubview(menuVC.view)
        self.addChild(menuVC)
        menuVC.view.layoutIfNeeded()
        
        
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "libraryCell", for: indexPath)
            cell.textLabel?.text = "Library cell"
            return cell
        }else if indexPath.row == 1 {
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
            cell.textLabel?.text = "Playlist cell"
            return cell
        }else {
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
            cell.textLabel?.text = "Player cell"
            return cell
        }
    }
    
    
}
