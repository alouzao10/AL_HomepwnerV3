//
//  ItemStore.swift
//  Homepwner
//
//  Created by Alex Louzao on 3/11/17.
//  Copyright © 2017 ALcsc2310. All rights reserved.
//

import UIKit

class ItemStore{
    var allItems = [Item]()
    
    var valItem: [Item]{
        return allItems.filter{$0.valueInDollars >= 0}
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item){
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
    
}
