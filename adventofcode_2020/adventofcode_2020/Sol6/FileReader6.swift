import Foundation

struct Person {
    let answers:String
    init(_ answers: String) {
        self.answers = answers
    }
    
    func getAnswers() -> String {
        return answers
    }
}

struct Group {
    var groupAnswers: [Person] = []
    var differentAnswers = ""
    var sameAnswersCount = 0
    
    func printAllAnswers() {
        for person in groupAnswers {
            print(person.getAnswers())
        }
    }
}

struct FileReader6 {
    var dataContents: [Group] = []
    
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
            .forEach{ groupAnswers in
                var group = Group()
                groupAnswers
                    .split(separator: "\n")
                    .forEach { (row) in
                        group.groupAnswers.append(Person(String(row)))
                        next: for char in row {
                            if !group.differentAnswers.contains(char) {
                                group.differentAnswers = "\(group.differentAnswers)\(char)"
                            }
                        }
                        
                    }
                dataContents.append(group)
            }
    }
}



