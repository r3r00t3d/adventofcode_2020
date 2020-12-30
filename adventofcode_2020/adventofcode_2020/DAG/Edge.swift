//
//  Edge.swift
//  adventofcode_2020
//
//  Created by Tomislav Andros on 27.12.2020..
//

import Foundation

class Edge<T: Equatable> {
    var value: Int?
    var nodeFrom: Node<T>?
    var nodeTo: Node<T>?
    
    init(_ value: Int?, nodeFrom: Node<T>?, nodeTo: Node<T>?) {
        self.value = value
        self.nodeFrom = nodeFrom
        self.nodeTo = nodeTo
    }
}
