import Foundation

extension String {
    var isBlank: Bool {
        return allSatisfy { $0.isWhitespace }
    }
}

extension Optional where Wrapped == String {
    var isBlank: Bool {
        return self?.isBlank ?? true
    }
}

enum EyeColor: String, CaseIterable {
    case amb = "amb"
    case blu = "blu"
    case brn = "brn"
    case gry = "gry"
    case grn = "grn"
    case hzl = "hzl"
    case oth = "oth"
    
    static func withLabel(_ label: String) -> EyeColor? {
        return self.allCases.first { "\($0)" == label }
    }
}

struct Passport {
    var byr: Int?
    var iyr: Int?
    var eyr: Int?
    var hgt: Int?
    var hgtUnit: String?
    var hcl: String?
    var ecl: EyeColor?
    var pid: String?
    
    func printElems() -> String {
        return "byr: \(byr ?? 0), iyr: \(iyr ?? 0), eyr: \(eyr ?? 0), hgt: \(hgt ?? 0), hgtUnit: \(hgtUnit ?? ""), hcl: \(hcl ?? ""), ecl: \(ecl ?? EyeColor.oth), pid: \(pid ?? "")"
    }
    
    func hasNilField() -> Bool {
        return ([byr, iyr, eyr, hgt, hgtUnit, hcl, ecl, pid] as [Any?]).contains(where: { $0 == nil })
    }
    
    mutating func setProperty(prop: String, value: Any? ) {
        switch prop {
        case "byr":
            if let safeByr = value as? String {
                self.byr = Int(safeByr)
            }
            break
        case "iyr":
            if let safeIyr = value as? String {
                self.iyr = Int(safeIyr)
            }
            break
        case "eyr":
            if let safeEyr = value as? String {
                self.eyr = Int(safeEyr)
            }
            break
        case "hgt":
            if let safeStr = value as? String {
                let height = Int(safeStr.replacingOccurrences(of: #"[A-Za-z]+"#, with: "", options: .regularExpression))
                if let safeHeight = height {
                    self.hgt = safeHeight
                }
                
                let heightUnit = safeStr.replacingOccurrences(of: #"[0-9]+"#, with: "", options: .regularExpression)
                self.hgtUnit = heightUnit
            }
            break
        case "hcl":
            if let safeStr = value as? String {
                self.hcl = safeStr
            }
            break
        case "ecl":
            if let safeStr = value as? String {
                if let eclSafe = EyeColor(rawValue: safeStr) {
                    self.ecl = eclSafe
                } else {
//                    print("Wrong eyecolor: \(safeStr)")
                }
                
            }
            break
        case "pid":
            if let safeStr = value as? String {
                self.pid = safeStr
            }
            break
        default:
            break
        }
    }
}

struct FileReader4 {
    var dataContents: [Passport] = []
    
    func printDataContents() {
        for i in 0..<dataContents.count {
            print(dataContents[i])
        }
    }
    
    init(filename: String) {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let fileURL = URL(fileURLWithPath: filename, relativeTo: documentsURL)
        
        let savedData = try? Data(contentsOf: fileURL)
        String(data: savedData!, encoding: .utf8)?
            .components(separatedBy: "\n\n")
            .forEach{ passport in
                var tempPass = Passport()
                passport
                    .split(separator: "\n")
                    .forEach { (row) in
                        row
                            .split(separator: " ")
                            .forEach { (keyVal) in
                                let keyValArray = keyVal.split(separator: ":")
                                let key = keyValArray.map { String($0) }[0]
                                let value = keyValArray.map { String($0) }[1]
                                tempPass.setProperty(prop: key, value: value)
                            }
                        
                    }
                if !tempPass.hasNilField() {
                    dataContents.append(tempPass)
                }
            }
    }
}


