import Foundation

struct Sol6 {
    var data6: FileReader6
    
    init() {
        data6 = FileReader6(filename: "input_p6.txt")
    }
    
    func solve6_1() {
        var differentCharsSum = 0
        for group in data6.dataContents {
            differentCharsSum += group.differentAnswers.count
        }
        print("Sum of yes answers is: \(differentCharsSum)")
    }
    // this shit has O(n^3), I'm ashamed but it works
    func solve6_2() {
        var sameAnswerCount = 0
        for group in data6.dataContents {
            nextChar:for char in group.differentAnswers {
                for person in group.groupAnswers {
                    if !person.getAnswers().contains(char) {
                        continue nextChar
                    }
                }
                sameAnswerCount += 1
            }
        }
        print("Number of SAME yes answers is: \(sameAnswerCount)")
    }
}
