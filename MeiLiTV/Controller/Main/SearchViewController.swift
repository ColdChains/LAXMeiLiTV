//
//  SearchViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/5/19.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSearchResults(for searchController: UISearchController) {
//        if let str = searchController.searchBar.text {
//            roomListResultModel = RoomListResultModel()
//            if let data = tempModel.data {
//                for model in data {
//                    if let name = model.tag_name {
//                        if name.contains(str) {
//                            if roomListResultModel.data == nil {
//                                roomListResultModel.data = []
//                            }
//                            roomListResultModel.data?.append(model)
//                        }
//                    }
//                }
//            }
//        }
//        self.collectionView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
