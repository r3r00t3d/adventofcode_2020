//
//  Graph.swift
//  adventofcode_2020
//
//  Created by Tomislav Andros on 28.12.2020..
//

import Foundation

class Graph<T: Equatable> {
    var nodes: [Node<T>]
    var edges: [Edge<T>]
    var totalBags: Int = 0
    var totalPathCount: Int = 0
    
    init(nodes: [Node<T>], edges: [Edge<T>]) {
        self.nodes = nodes
        self.edges = edges
    }
    
    func insertNode(_ value: T) {
        let newNode = Node(value)
        for node in nodes {
            if node.value == newNode.value {
                return
            }
        }
        nodes.append(newNode)
    }
    
    func insertEdge(_ value: Int, nodeFromValue: T, nodeToValue: T) {
        var nodeFromFound: Node<T>? = nil
        var nodeToFound: Node<T>? = nil
        
        // check if node already exists
        for node in self.nodes {
            if node.value == nodeFromValue {
                nodeFromFound = node
            }
            
            if node.value == nodeToValue {
                nodeToFound = node
            }
        }
        
        if nodeFromFound == nil {
            nodeFromFound = Node(nodeFromValue)
            nodes.append(nodeFromFound!)
        }
        if nodeToFound == nil {
            nodeToFound = Node(nodeToValue)
            nodes.append(nodeToFound!)
        }
        
        let newEdge = Edge<T>(value, nodeFrom: nodeFromFound, nodeTo: nodeToFound)
        
        nodeFromFound?.edges.append(newEdge)
        nodeToFound?.edges.append(newEdge)
        edges.append(newEdge)
    }
    
    func getEdgeList() -> [[Any]] {
        var edgeList:[[Any]] = []
        for edgeObj in edges {
            let edge = [edgeObj.value!, edgeObj.nodeFrom!.value!, edgeObj.nodeTo!.value!] as [Any]
            edgeList.append(edge)
        }
        return edgeList
    }
    
    func printEdgeList(){
        print("Total number of edges: \(edges.count)")
        for edgeObj in edges {
            print("\(edgeObj.nodeFrom!.value!) -> \(edgeObj.value!) -> \(edgeObj.nodeTo!.value!)")
        }
    }
    
    func printNodeList() {
        var i = 0
        for node in nodes {
            print("Node \(i): \(node.value!); number of edges: \(node.edges.count)")
            i += 1
            for edgeObj in node.edges {
                print("  +\(edgeObj.nodeFrom!.value!) -> \(edgeObj.value!) -> \(edgeObj.nodeTo!.value!)")
            }
        }
    }
    
    // function that searches for the specific node
    func dfs(_ startNode: Node<T>, searchValue: T) -> Bool {
        var visited = [startNode.value!]
        
        visited = dfsHelper(startNode, visited: visited)
        
        return visited.contains(searchValue)
        
    }
    
    func dfsHelper(_ current: Node<T>, visited: [T]) -> [T] {
        
        var result = visited
        
        for edgeObj in current.edges {
            if !result.contains((edgeObj.nodeTo!.value)!) {
                result.append((edgeObj.nodeTo!.value)!)
                
                result = dfsHelper(edgeObj.nodeTo!, visited: result)
            }
        }
        return result
        
    }
    
    func dfs_7_2(_ startNode: Node<T>) {
        // var visited: [Node<T>] = []
        let initCount = 1
        dfsHelper7_2(startNode, currentBoxSize: initCount)
    }
    
    func dfsHelper7_2(_ current: Node<T>, currentBoxSize: Int) {
        
        for edgeObj in current.edges {
            if current == edgeObj.nodeFrom! {
                let destVertex = edgeObj.nodeTo
                if let safeDestVertex = destVertex {
                    let newBags = currentBoxSize * edgeObj.value!
                    self.totalBags += newBags
                    dfsHelper7_2(safeDestVertex, currentBoxSize: newBags)
                }
            }
        }
    }
    
    func dfs_10_2(_ startNode: Node<T>) {
        // var visited: [Node<T>] = []
        dfsHelper10_2(startNode)
    }
    
    func dfsHelper10_2(_ current: Node<T>) {
        if current.visited {
            return
        }
        var testFrom = 0
        for edgeObj in current.edges {
            if current == edgeObj.nodeFrom! {
                testFrom += 1
            }
        }
        
        //if leaf
        if testFrom == 0 {
            current.noPaths = 1
            print("\(current.value!) has \(current.noPaths) path")
            current.visited = true
            return
        }
        for edgeObj in current.edges {
            if current == edgeObj.nodeFrom! {
                if !edgeObj.nodeTo!.visited {
                    dfsHelper10_2(edgeObj.nodeTo!)
                }
                current.noPaths += edgeObj.nodeTo!.noPaths
            }
        }
        print("\(current.value!) has \(current.noPaths) paths")
        current.visited = true
        return
    }
}
