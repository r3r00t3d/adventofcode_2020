import Foundation

enum CommandLabel: String, CaseIterable {
    case acc = "acc"
    case jmp = "jmp"
    case nop = "nop"
    
    static func withLabel(_ label: String) -> CommandLabel? {
        return self.allCases.first { "\($0)" == label }
    }
}

struct AssemblyCommand {
    var command: CommandLabel?
    var argumentSize: Int?
    var visited: Bool = false
}


struct FileReader8 {
    var commands: [AssemblyCommand] = []
    
    func printAssemblyFile() {
        for i in 0..<commands.count {
            if let safeArgument = commands[i].argumentSize {
                print("\(commands[i].command!) \(safeArgument)")
            } else {
                print("\(commands[i].command!)")
            }
            
        }
    }
    
    init(filename: String) {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let fileURL = URL(fileURLWithPath: filename, relativeTo: documentsURL)
        
        let savedData = try? Data(contentsOf: fileURL)
        String(data: savedData!, encoding: .utf8)?
            .split(separator: "\n")
            .forEach{ (command) in
                var assemblyCommand = AssemblyCommand()
                let commandElement = command.split(separator: " ")
                let test = String(commandElement[0])
                if let safeCommandLabel = CommandLabel(rawValue: test) {
                    assemblyCommand.command = safeCommandLabel
                }
                
                assemblyCommand.argumentSize = Int(commandElement[1])
                commands.append(assemblyCommand)
            }
        // self.printAssemblyFile()
    }
}




