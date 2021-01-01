//
//  Sol7.swift
//  adventofcode_2020
//
//  Created by Tomislav Andros on 27.12.2020..
//

import Foundation

struct Sol7 {
    var data7: FileReader7
    
    init() {
        data7 = FileReader7(filename: "input_p7.txt")
    }
    
    func solve7_1() {
        var foundBags = 0
        // data7.bags?.printEdgeList()
        // data7.bags?.printNodeList()
        next: for node in data7.bags!.nodes {
            if node.value! == "shiny gold" {
                continue next
            }
            if data7.bags!.dfs(node, searchValue: "shiny gold") {
                foundBags += 1
            }
        }
        print("Number of bags that can carry shiny gold bag is: \(foundBags)")
    }
    
    func solve7_2() {
        var searchNode: Node<String>?
        next: for node in data7.bags!.nodes {
            if node.value! == "shiny gold" {
                searchNode = node
                break next
            }
        }
        if let shGoldNode = searchNode {
            data7.bags!.dfs_7_2(shGoldNode)
            print("Number of bags inside shiny gold bag is: \(data7.bags!.totalBags)")
        }
        
    }
}
