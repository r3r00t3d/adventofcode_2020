//
//  Sol7.swift
//  adventofcode_2020
//
//  Created by Tomislav Andros on 27.12.2020..
//

import Foundation

struct Sol8 {
    var data8: FileReader8
    
    
    init() {
        data8 = FileReader8(filename: "input_p8.txt")
    }
    
    func solve8_1() {
        // instruction pointer
        var ip: Int = 0
        var acc: Int = 0
        
        var mutableCommands = data8.commands
        
        next: while true {
            if mutableCommands[ip].visited {
                break next
            }
            switch mutableCommands[ip].command {
            case .acc:
                mutableCommands[ip].visited = true
                acc += mutableCommands[ip].argumentSize!
                ip += 1
            case .jmp:
                mutableCommands[ip].visited = true
                ip += mutableCommands[ip].argumentSize!
            default:
                mutableCommands[ip].visited = true
                ip += 1
            }
        }
        print("Size of the accumulator size on next loop cycle is:\(acc)")
    }
    
    func solve8_2() {
        var acc: Int = 0
        outer: for switchCommand in 0..<data8.commands.count {
            var mutableCommands = data8.commands
            var ip: Int = 0
            acc = 0
            
            if mutableCommands[switchCommand].command == .jmp {
                mutableCommands[switchCommand].command = .nop
            } else if mutableCommands[switchCommand].command == .nop && mutableCommands[switchCommand].argumentSize != 0 {
                mutableCommands[switchCommand].command = .jmp
            }
            
            next: while true {
                if ip == mutableCommands.count - 1 {
                    break outer
                }
                if mutableCommands[ip].visited {
                    break next
                }
                switch mutableCommands[ip].command {
                case .acc:
                    mutableCommands[ip].visited = true
                    acc += data8.commands[ip].argumentSize!
                    ip += 1
                case .jmp:
                    mutableCommands[ip].visited = true
                    ip += data8.commands[ip].argumentSize!
                default:
                    mutableCommands[ip].visited = true
                    ip += 1
                }
            }
        }
        print("Size of the accumulator with fix is:\(acc)")
    }
}
