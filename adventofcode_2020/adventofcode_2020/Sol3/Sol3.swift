import Foundation

struct Sol3 {
    var data3: FileReader3
    
    init() {
        data3 = FileReader3(filename: "input_p3.txt")
    }
    
    func solve3_1() {
        var numberOfTrees = 0
        let rowNumber = data3.dataContents.count
        let colNumber = 3 * rowNumber
        var colMarker = 0
        
        for i in 1..<rowNumber {
            var row = data3.dataContents[i]
            while row.count < colNumber {
                row += data3.dataContents[i]
            }

            colMarker += 3
            if row.unicodeScalars.map { $0.value }[colMarker] == "#".unicodeScalars.map { $0.value}.reduce(0, +) {
                numberOfTrees += 1
            }
        }
        
        print("Number of trees stumbled upon is: \(numberOfTrees)")
    }
    func solve3_2() {
        var numberOfTrees1:[Int] = [0, 0, 0, 0]
        var numberOfTrees2 = 0
        let colMarkers:[Int] = [1, 3, 5, 7]
        let rowNumber = data3.dataContents.count
        let colNumber = 7 * rowNumber
        let hash = "#".unicodeScalars.map { $0.value }.reduce(0, +)
        
        var positions2row = 0
        
        for i in 1..<rowNumber {
            var row = data3.dataContents[i]
            while row.count < colNumber {
                row += data3.dataContents[i]
            }
            
            var positions1row: IndexSet = IndexSet(colMarkers.map { $0 * i })
            
            let targets = row.unicodeScalars
                .map { $0.value }
                .enumerated()
                .filter { positions1row.contains($0.offset) }
                .map { $0.element }
                .map { (res) -> Int in
                    if res == hash {
                        return 1
                    }
                    return 0
                }
            numberOfTrees1 = zip(numberOfTrees1, targets).map { $0 + $1 }
            
            if i % 2 == 0 {
                positions2row += 1
                if row.unicodeScalars.map { $0.value }[positions2row] == hash {
                    numberOfTrees2 += 1
                }
            }
        }
        print(numberOfTrees1)
        print(numberOfTrees2)
        let totalResult = numberOfTrees1.reduce(1, *) * numberOfTrees2
        print("Total number of trees is: \(totalResult)")
    }
}
