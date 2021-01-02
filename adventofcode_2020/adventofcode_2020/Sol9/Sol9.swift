import Foundation

struct Sol9 {
    var data9: FileReader9
    var sum25:[Int] = []
    
    
    init() {
        data9 = FileReader9(filename: "input_p9.txt")
    }
    
    func quicksort(sort array:inout [Int], low: Int, high: Int) {
        
        if low < high {
            // set pivot
            let pivot = array[high]
            // track new pivot loc
            var i = low
            
            //partition
            for j in low..<high {
                if array[j] <= pivot {
                    (array[i], array[j]) = (array[j], array[i])
                    i += 1
                }
            }
            //put pivot in its place
            (array[i], array[high]) = (array[high], array[i])
            quicksort(sort: &array, low: low, high: i - 1)
            quicksort(sort: &array, low: i + 1, high: high)
        }
    }
    
    mutating func solve9_1() {
        var violationNo: Int?
        
        
        next: for i in 25..<data9.numbers.count {
            sum25 = []
            violationNo = data9.numbers[i]
            for j in i-25...i-2 {
                for k in i-24...i-1 {
                    sum25.append(data9.numbers[j] + data9.numbers[k])
                }
            }
            if !sum25.contains(data9.numbers[i]) {
                break next
            }
        }
        print("Answer is: \(violationNo!)")
    }
    
    // we'll solve this using dynamic programming
    func solve9_2() {
        let sum = 21806024
        var counter = 0
        var totalNoSweeps = 0
        var resultingArray:[Int] = []
        
        var DP = Array<[Bool]>(repeating: Array<Bool>(repeating: false, count: sum + 1), count: data9.numbers.count + 1)
        print ("Created array DP with \(DP[0].count) columns")
        
        DP[0] = DP[0].map { _ in false }
        for i in 0...data9.numbers.count {
            DP[i][0] = true
        }
        
        print ("Initialized first row and column")
        
        totalNoSweeps = (data9.numbers.count * sum)
        print("Total number of sweeps: \(totalNoSweeps)")
        
        outer: for i in 1...data9.numbers.count {
            for j in 1...sum {
                if counter % 1000000 == 0 {
                    print("Sweeps at: \(Float(counter)/Float(totalNoSweeps)*100)%")
                }
                // trivial case if
                if data9.numbers[i - 1] > j {
                    DP[i][j] = DP[i - 1][j]
                }
                
                if data9.numbers[i - 1] <= j {
                    DP[i][j] = DP[i - 1][j] || DP [i - 1][j - data9.numbers[i - 1]]
                }
                if j == sum && DP[i][j] == true {
                    var tempSum = 0
                    var tempCounter = 0
                    while true {
                        let currentData = i - 1 - tempCounter
                        if currentData < 0 {
                            continue outer
                        }
                        tempSum += data9.numbers[currentData]
                        if tempSum == sum {
                            resultingArray.append(data9.numbers[currentData])
                            break outer
                        }
                        if tempSum > sum {
                            continue outer
                        }
                        resultingArray.append(data9.numbers[currentData])
                        tempCounter += 1
                    }
                }
                counter += 1
            }
        }
        print(resultingArray)
        print("Sum of all elements in array is:\(resultingArray.reduce(0, +))")
        quicksort(sort: &resultingArray, low: 0, high: resultingArray.count - 1)
        let finalSum = resultingArray.removeFirst() + resultingArray.removeLast()
        print("The solution is: \(finalSum)")
        
    }
    
    func solve9_2_2() {
        let sum = 21806024
        var resultingArray:[Int] = []
        
        outer: for window in 2...data9.numbers.count - 1 {
            for i in window...data9.numbers.count - 1 {
                let test = data9.numbers[i - window..<i]
                if test.reduce(0, +) == sum {
                    resultingArray = Array(test)
                    break outer
                }
            }
        }
        print(resultingArray)
        print("Sum of all elements in array is:\(resultingArray.reduce(0, +))")
        quicksort(sort: &resultingArray, low: 0, high: resultingArray.count - 1)
        let finalSum = resultingArray.removeFirst() + resultingArray.removeLast()
        print("The solution is: \(finalSum)")
    }
}
