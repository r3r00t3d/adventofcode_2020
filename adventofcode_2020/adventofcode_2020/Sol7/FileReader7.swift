//
//  FileReader7.swift
//  adventofcode_2020
//
//  Created by Tomislav Andros on 27.12.2020..
//

import Foundation

struct FileReader7 {
    var bags: Graph<String>?
    
    func printBagGraph() {
        if let safeBags = bags {
            let edgeList = safeBags.getEdgeList()
            for edge in edgeList {
                print("\(edge[1]) -> \(edge[0]) -> \(edge[2])")
            }
        }
    }
    
    init(filename: String) {
        bags = Graph<String>(nodes:[], edges: [])
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = URL(fileURLWithPath: filename, relativeTo: documentsURL)
        
        let savedData = try? Data(contentsOf: fileURL)
        String(data: savedData!, encoding: .utf8)?
            .split(separator: "\n")
            .forEach { (sentence) in
                let branch = sentence.components(separatedBy: "contain")
                //branch[0] contains one node, branch[1] potential nodes that are connected via edges with branch[0]
                if let range0 = branch[0].range(of: #"^.+?(?=[ \t]bags)"#, options: .regularExpression) {
                    let nodeFrom = String(branch[0][range0])
                    bags!.insertNode(nodeFrom)
                    if branch[1] != "no other bags." {
                        let vertices = branch[1].split(separator: ",")
                        for vertex in vertices {
                            if let range1 = vertex.range(of: #".+?(?=[ \t]bag.?)"#, options: .regularExpression) {
                                if let edge_value = vertex[range1].range(of: #"[0-9]+"#, options: .regularExpression), let vert_range = vertex[range1].range(of: #"(?<=\d[\W]).+"#, options: .regularExpression) {
                                    let nodeTo = String(vertex[range1][vert_range])
                                    let edgeValue = Int(vertex[range1][edge_value])!
                                    bags!.insertEdge(edgeValue, nodeFromValue: nodeFrom, nodeToValue: nodeTo)
                                }
                            }
                        }
                    }
                }
                
            }
    }
}
