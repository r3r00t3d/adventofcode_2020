import Foundation

struct Sol5 {
    var data5: FileReader5
    
    init() {
        data5 = FileReader5(filename: "input_p5.txt")
    }
    
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
    
    func calcID(for id: inout [Int], row: String ) {
        let rownumString = String(row[..<row.index(row.startIndex, offsetBy: 7)])
        let colnumString = String(row[row.index(row.endIndex, offsetBy: -3)...])
        let binaryString = rownumString.replacingOccurrences(of: "F", with: "0").replacingOccurrences(of: "B", with: "1")
        let columnBinary = colnumString.replacingOccurrences(of: "L", with: "0").replacingOccurrences(of: "R", with: "1")
        if let rownum = Int(binaryString, radix: 2), let colnum = Int(columnBinary, radix: 2) {
            id.append(rownum * 8 + colnum)
        }
    }
    
    func solve5_1() {
        var ids:[Int] = []
        for row in data5.dataContents {
            calcID(for: &ids, row: row)
        }
        let highestID = ids.reduce(Int.min) { max($0, $1) }
        print("Highest ID is: \(highestID)")
    }
    
    func solve5_2() {
        var ids:[Int] = []
        for row in data5.dataContents {
            calcID(for: &ids, row: row)
        }
        quicksort(sort: &ids, low: 0, high: ids.count - 1)
        for i in 1..<ids.count {
            if ids[i] - ids[i - 1] == 2 {
                print("Your seat is: \(ids[i] - 1)")
            }
        }
    }
}
