import Foundation

struct Sol4 {
    var data4: FileReader4
    var mandatoryFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    
    init() {
        data4 = FileReader4(filename: "input_p4.txt")
    }
    
    func solve4_1() {
        print("Initial password count is: \(data4.dataContents.count)")
    }
}
