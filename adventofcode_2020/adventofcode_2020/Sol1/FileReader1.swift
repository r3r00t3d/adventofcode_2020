import Foundation

struct FileReader1 {
    var dataContents: [Int] = []
    
    func printDataContents() {
        for i in 0..<dataContents.count {
            print(dataContents[i])
        }
    }
    
    init(filename: String) {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let fileURL = URL(fileURLWithPath: filename, relativeTo: documentsURL)
        // try! str.write(to: fileURL, atomically: true, encoding: .utf8)
        
        let savedData = try? Data(contentsOf: fileURL)
        String(data: savedData!, encoding: .utf8)?
            .split(separator: "\n")
            .forEach{line in
                self.dataContents.append(Int(String(line))!)
            }
    }
}

