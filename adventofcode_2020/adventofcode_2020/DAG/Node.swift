//
//  BagsNode.swift
//  adventofcode_2020
//
//  Created by Tomislav Andros on 27.12.2020..
//

import Foundation

class Node<T: Equatable>: Equatable {
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value == rhs.value
    }
    
    var value: T?
    var edges: [Edge<T>]
    var visited: Bool = false
    
    init(_ value: T?) {
        self.value = value
        self.edges = []
    }
}
