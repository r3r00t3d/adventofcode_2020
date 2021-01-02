import Foundation


struct FileReader9 {
    var numbers: [Int] = []
    
    init(filename: String) {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let fileURL = URL(fileURLWithPath: filename, relativeTo: documentsURL)
        
        let savedData = try? Data(contentsOf: fileURL)
        String(data: savedData!, encoding: .utf8)?
            .split(separator: "\n")
            .forEach{ (number) in
                numbers.append(Int(number)!)
            }
    }
}




