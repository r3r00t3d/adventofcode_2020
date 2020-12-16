import Foundation

struct Sol2 {
    var data2: FileReader2
    
    init() {
        data2 = FileReader2(filename: "input_p2.txt")
    }
    
    func solve2_1() {
        var validPasswords = 0
        data2.dataContents.forEach { line in
            let groups = line.split(separator: " ")
            let range = groups[0].split(separator: "-")
            let startIndex = Int(range[0])!
            let endIndex = Int(range[1])!
            let searchChar = groups[1][..<groups[1].index(groups[1].startIndex, offsetBy: 1)].unicodeScalars.map { $0.value }.reduce(0, +)
            let countOccurences = groups[2].unicodeScalars.map { $0.value }.filter { $0 == searchChar }.count
            if  startIndex...endIndex ~= countOccurences {
                validPasswords += 1
            }
        }
        print("Number of valid passwords for 2_1 is: \(validPasswords)")
    }
    func solve2_2() {
        var validPasswords = 0
        data2.dataContents.forEach { line in
            let groups = line.split(separator: " ")
            let range = groups[0].split(separator: "-")
            let firstPosition = Int(range[0])!
            let secondPosition = Int(range[1])!
            let searchChar = groups[1][..<groups[1].index(groups[1].startIndex, offsetBy: 1)].unicodeScalars.map { $0.value }.reduce(0, +)
            let targetString = groups[2].unicodeScalars.map { $0.value }
            if (targetString[firstPosition - 1] == searchChar) != (targetString[secondPosition - 1] == searchChar) {
                validPasswords += 1
            }
        }
        print("Number of valid passwords for 2_2 is: \(validPasswords)")
    }
}
