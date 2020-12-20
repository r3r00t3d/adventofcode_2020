import Foundation

struct Sol4 {
    var data4: FileReader4
    
    init() {
        data4 = FileReader4(filename: "input_p4.txt")
    }
    
    func solve4_1() {
        print("Initial password count is: \(data4.dataContents.count)")
    }
    
    func solve4_2() {
        var validPassports = 0
        var validPassportsArray: [Passport] = []
        next: for passport in data4.dataContents {
            if !(1920...2002 ~= passport.byr!) {
                // print("Wrong byr: \(passport.byr!)")
                continue next
            }
            if !(2010...2020 ~= passport.iyr!) {
                // print("Wrong iyr: \(passport.iyr!)")
                continue next
            }
            if !(2020...2030 ~= passport.eyr!) {
                // print("Wrong eyr: \(passport.eyr!)")
                continue next
            }
            if passport.hgtUnit == "in" && !(59...76 ~= passport.hgt!) {
                // print("Wrong height in inches: \(passport.hgt!)")
                continue next
            }
            if passport.hgtUnit == "cm" && !(150...193 ~= passport.hgt!) {
                // print("Wrong height in cm: \(passport.hgt!)")
                continue next
            }
            
            if let _ = passport.hcl!.range(of: #"^#[0-9a-f]{6}$"#, options: .regularExpression) {
                // print("OK haircolor: \(passport.hcl!)")
                
            } else {
                // print("Bad haircolor: \(passport.hcl!)")
                continue next
            }
            
            if let _ = passport.pid!.range(of: #"^[0-9]{9}$"#, options: .regularExpression) {
                // print("OK PID: \(passport.pid!)")
                
            } else {
                // print("Bad PID: \(passport.pid!)")
                continue next
            }

            validPassports += 1
            validPassportsArray.append(passport)
        }
        print("Number of valid passwords is: \(validPassports)")
    }
}
