//
//  MessageListViewController.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 09/02/25.
//

import Foundation
import UIKit
import SwiftUI
import Combine

final class MessageListViewController : UIViewController{
    
    init(_ viewModel : ChatRoomScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .clear
        view.backgroundColor = .clear
        setUpViews()
        reloadUI()
    }
    
    deinit {
        cancellable.forEach{$0.cancel()}
        cancellable.removeAll()
    }
    private let viewModel : ChatRoomScreenViewModel
    private var cancellable = Set<AnyCancellable>()
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
        view.addSubview(backGroundImage)
        view.addSubview(tableView)
      
        
        NSLayoutConstraint.activate([
            backGroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backGroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backGroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backGroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    private var backGroundImage : UIImageView = {
        var backgroundImage = UIImageView(image: .chatbackground)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = true
        return backgroundImage
    }()
    private func reloadUI () {
        
        let delay = 200
        
        viewModel.$messages.debounce(for: .milliseconds(delay), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &cancellable)
    }
}
extension MessageListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:reuseIdentifier , for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration { // basically we use the uikit tableview but the swiftui view as a cell
            let message = viewModel.messages[indexPath.row]
            
            switch message.messageType {
                
            case .text:
                BubbleTextView(message: message)
                
            case .image , .video:
                BubbleImageView(message : message)
                
            case .audio:
                BubbleAudioMessageView(message: message)
            case .admin(type: let messageType):
                switch messageType {
                case .channelCreation:
                    ChannelCreationTextView()
                    if viewModel.channel.isGroupChat {
                        AdminMessageTextView(channel: viewModel.channel)
                    }
                default :
                    Text("Unknown   ")
                }
                
            }
        }
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

#Preview {
    MessageListView(ChatRoomScreenViewModel(channel: .sampleChannelItem))
        .ignoresSafeArea()
}
