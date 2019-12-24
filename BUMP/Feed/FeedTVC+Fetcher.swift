//
//  FeedTVC+Fetcher.swift
//  BUMP
//
//  Created by Hunain Ali on 12/7/19.
//  Copyright © 2019 BUMP. All rights reserved.
//

import Foundation

extension FeedTVC : FeedFetcherDelegate {
    
    
    func feedChatUpdated(feedChat: FeedChat) {
        
        print("cvs \(feedChat.circleID)")
        
        self.tableView.performBatchUpdates({
            
            if let index = feedChatArray.firstIndex(where: {$0.chatID == feedChat.chatID}) {
                feedChatArray[index] = feedChat
                self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            }
            else {
                if let index = feedChatArray.firstIndex(where: {$0.getFirstMessage()!.timestamp.compare(feedChat.getFirstMessage()!.timestamp) == .orderedAscending}) {
                    feedChatArray.insert(feedChat, at: index)
                    self.tableView.insertRows(at: [IndexPath(item: index, section: 0)], with: .left)
                    } else {
                    feedChatArray.append(feedChat)
                    self.tableView.insertRows(at: [IndexPath(item: feedChatArray.count-1, section: 0)], with: .left)
                    }
            }
        })
    }
    
    func feedChatRemoved(chatID: String) {
        
        self.tableView.performBatchUpdates({
            if let index = feedChatArray.firstIndex(where: {$0.chatID == chatID}) {
                feedChatArray.remove(at: index)
                self.tableView.deleteRows(at: [IndexPath(item: index, section: 0)], with: .right)
            }
        })
    }
    
    
}
