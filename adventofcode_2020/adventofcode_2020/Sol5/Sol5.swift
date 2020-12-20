import Foundation

struct Sol5 {
    var data5: FileReader5
    
    init() {
        data5 = FileReader5(filename: "input_p5.txt")
    }
    
    func solve5_1() {
        var highestID = 0
        for num in data5.dataContents {
            
            let rownumString = String(num[..<num.index(num.startIndex, offsetBy: 7)])
            let colnumString = String(num[num.index(num.endIndex, offsetBy: -3)...])
            let binaryString = rownumString.replacingOccurrences(of: "F", with: "0").replacingOccurrences(of: "B", with: "1")
            let columnBinary = colnumString.replacingOccurrences(of: "L", with: "0").replacingOccurrences(of: "R", with: "1")
            if let rownum = Int(binaryString, radix: 2), let colnum = Int(columnBinary, radix: 2) {
                let currentID = rownum * 8 + colnum
                if currentID > highestID {
                    highestID = currentID
                }
            }
        }
        print("Highest ID is: \(highestID)")
    }
    
    func solve5_2() {
        
    }
}
