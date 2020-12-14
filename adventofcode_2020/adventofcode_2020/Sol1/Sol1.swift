import Foundation

struct Sol1 {
    var data1: FileReader1
    
    init() {
        data1 = FileReader1(filename: "input_p1.txt")
    }
    
    func solve() {
        for i in 0..<data1.dataContents.count - 1 {
            for j in i..<data1.dataContents.count {
                if data1.dataContents[i] + data1.dataContents[j] == 2020 {
                    print(String(data1.dataContents[i] * data1.dataContents[j]))
                }
            }
        }
    }
}



