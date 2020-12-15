import Foundation

struct Sol1 {
    var data1: FileReader1
    
    init() {
        data1 = FileReader1(filename: "input_p1.txt")
    }
    
    func solve1_1() {
        for i in 0..<data1.dataContents.count - 1 {
            for j in i..<data1.dataContents.count {
                if data1.dataContents[i] + data1.dataContents[j] == 2020 {
                    print("num1:\(data1.dataContents[i]), num2:\(data1.dataContents[j])")
                    print(String(data1.dataContents[i] * data1.dataContents[j]))
                }
            }
        }
    }
    func solve1_2() {
        for i in 0..<data1.dataContents.count - 2 {
            for j in i..<data1.dataContents.count - 1 {
                for k in j..<data1.dataContents.count {
                    if data1.dataContents[i] + data1.dataContents[j] + data1.dataContents[k] == 2020 {
                        print("num1:\(data1.dataContents[i]), num2:\(data1.dataContents[j]), num3:\(data1.dataContents[k])")
                        print(String(data1.dataContents[i] * data1.dataContents[j] * data1.dataContents[k]))
                    }
                }
                
            }
        }
    }
}



