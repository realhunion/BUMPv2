//
//  LaunchTVC+Fetcher.swift
//  BUMP
//
//  Created by Hunain Ali on 1/10/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import UIKit


extension LaunchTVC : AllCirclesFetcherDelegate {
    
    //MARK: - Delegate Methods
    
    
    func allCirclesFetched(launchCircleArray: [LaunchCircle]) {
        
        self.tableView.backgroundView = nil
        if refreshControl?.isRefreshing == true {
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
            }
        }
        
        self.circleArray = launchCircleArray
        tableView.reloadData()
        
        //push data up to categoryVC if on top
        for vc in self.navigationController?.viewControllers ?? [] {
            if let categoryVC = vc as? CategoryTVC {
                categoryVC.allCirclesFetched(launchCircleArray: launchCircleArray)
            }
        }
        
    }
    
    
    //MARK: - Internal Methods
    
    
    func getMyCircles() -> [LaunchCircle] {
        var array = self.circleArray.filter({$0.amMember()})
        array = self.sortArray(array: array)
        return array
    }
    
    //
    
    func getCategoryArray() -> [String] {
        var categoryArray : [String] = []
        for circle in self.circleArray {
            if !categoryArray.contains(where: {$0 == circle.category}) {
                categoryArray.append(circle.category)
            }
        }
        categoryArray.sort { (c1, c2) -> Bool in
            return c1 < c2
        }
        return categoryArray
    }

    func getCategoryCircleArray(category : String) -> [LaunchCircle] {
        let filteredCategoryArray = self.circleArray.filter({$0.category == category})
        return filteredCategoryArray
    }


    
    
}
