//
//  MessageListViewController.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 09/02/25.
//

import Foundation
import UIKit
import SwiftUI

final class MessageListViewController : UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    var reuseIdentifier = "MessageListControllerCells"
    private lazy var tableView : UITableView = {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .none
    tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
        
    }()
    
    
    func setUpViews () {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}
extension MessageListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return MessageItem.differentKindOfMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:reuseIdentifier , for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration { // basically we use the uikit tableview but the swiftui view as a cell
            let message = MessageItem.differentKindOfMessages[indexPath.row]
            
            switch message.messageType {
                
            case .text:
             BubbleTextView(message: message)
            
            case .image , .video:
                BubbleImageView(message : message)
            
            case .audio:
                BubbleAudioMessageView(message: message)
            }
                
        }
        cell.backgroundColor = UIColor.systemGray6
        cell.selectionStyle = .none
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

#Preview {
    MessageListView()
}
