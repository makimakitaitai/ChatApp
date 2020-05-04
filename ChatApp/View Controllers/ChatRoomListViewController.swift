//
//  ChatRoomListViewController.swift
//  ChatApp
//
//  Created by 萬木大志 on 2020/05/02.
//  Copyright © 2020 makimaki. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

final internal class ChatRoomListViewController: UITableViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    let cells = ["Basic Example", "Advanced Example", "Autocomplete Example", "Embedded Example", "Settings", "Source Code", "Contributors", "Chat Room"]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MessageKit"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
    
    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell.textLabel?.text = cells[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = cells[indexPath.row]
        switch cell {
        case "Basic Example":
            navigationController?.pushViewController(BasicExampleViewController(), animated: true)
        case "Advanced Example":
            navigationController?.pushViewController(AdvancedExampleViewController(), animated: true)
        case "Autocomplete Example":
            navigationController?.pushViewController(AutocompleteExampleViewController(), animated: true)
        case "Embedded Example":
            navigationController?.pushViewController(MessageContainerController(), animated: true)
        case "Settings":
            navigationController?.pushViewController(SettingsViewController(), animated: true)
        case "Source Code":
            guard let url = URL(string: "https://github.com/MessageKit/MessageKit") else { return }
            openURL(url)
        case "Contributors":
            guard let url = URL(string: "https://github.com/orgs/MessageKit/teams/contributors/members") else { return }
            openURL(url)
        case "Chat Room":
            navigationController?.pushViewController(ChatRoomViewController(), animated: true)
        default:
            assertionFailure("You need to impliment the action for this cell: \(cell)")
            return
        }
    }
    
    func openURL(_ url: URL) {
        let webViewController = SFSafariViewController(url: url)
        if #available(iOS 10.0, *) {
            webViewController.preferredControlTintColor = .primaryColor
        }
        present(webViewController, animated: true, completion: nil)
    }
}
