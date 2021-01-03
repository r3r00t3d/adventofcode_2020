import Foundation

struct Sol10 {
    var data10: FileReader10
    
    func quicksort(sort array:inout [Int], low: Int, high: Int) {
        
        if low < high {
            // set pivot
            let pivot = array[high]
            // track new pivot loc
            var i = low
            
            //partition
            for j in low..<high {
                if array[j] <= pivot {
                    (array[i], array[j]) = (array[j], array[i])
                    i += 1
                }
            }
            //put pivot in its place
            (array[i], array[high]) = (array[high], array[i])
            quicksort(sort: &array, low: low, high: i - 1)
            quicksort(sort: &array, low: i + 1, high: high)
        }
    }
    
    
    init() {
        data10 = FileReader10(filename: "input_p10.txt")
    }
    
    func solve10_1() {
        var adapters = data10.adapters
        var joltDiff = Array<Int>(repeating: 0, count: 3)
        
        quicksort(sort: &adapters, low: 0, high: adapters.count - 1)
        
        _ = adapters.reduce(0) { (curr, next) -> Int in
            switch(next - curr) {
            case 1:
                joltDiff[0] += 1
                return next
            case 2:
                joltDiff[1] += 1
                return next
            case 3:
                joltDiff[2] += 1
                return next
            default:
                return next
            }
        }
        // inbuilt adapter
        joltDiff[2] += 1
        
        print("The answer is: \(joltDiff[0] * joltDiff[2])")
        
    }
    
    func solve10_2() {
        var adapters = data10.adapters
        let dag = Graph<Int>(nodes:[], edges: [])
        
        quicksort(sort: &adapters, low: 0, high: adapters.count - 1)
        adapters.insert(0, at: 0)
        adapters.append(adapters.last! + 3)
        for i in 0..<adapters.count {
            var j = 1
            while (i + j < adapters.count) && (adapters[i+j] - adapters[i] <= 3) {
                dag.insertEdge(adapters[i+j] - adapters[i], nodeFromValue: adapters[i], nodeToValue: adapters[i+j])
                j += 1
            }
        }
        // dag.printNodeList()
        
        var searchNode: Node<Int>?
        next: for node in dag.nodes {
            if node.value! == 0 {
                searchNode = node
                break next
            }
        }
        dag.dfs_10_2(searchNode!)
        print("Resulting number of combos: \(searchNode!.noPaths)")
    }
}
