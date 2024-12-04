import Foundation

func isSafeSequence(_ levels: [Int]) -> Bool {
    // Check if sequence is strictly increasing or decreasing with differences 1-3
    guard levels.count > 1 else {
        return true
    }

    let isIncreasing = levels[1] > levels[0]

    for i in 0..<levels.count - 1 {
        let diff = abs(levels[i] - levels[i + 1])
        if diff < 1 || diff > 3 {
            return false
        }
        if isIncreasing && levels[i] >= levels[i + 1] {
            return false
        }
        if !isIncreasing && levels[i] <= levels[i + 1] {
            return false
        }
    }

    return true
}

func isSafeWithDampener(_ levels: [Int]) -> Bool {
    // First check if safe without removing any number
    if isSafeSequence(levels) {
        return true
    }

    // Try removing each number one at a time
    for i in 0..<levels.count {
        var newLevels = levels
        newLevels.remove(at: i)
        if isSafeSequence(newLevels) {
            return true
        }
    }

    return false
}

// Count safe reports
var safeCount = 0

// Get the current file's directory
let currentFilePath = #file
let currentDirectory = URL(fileURLWithPath: currentFilePath).deletingLastPathComponent().path

// Construct path to inputs.txt in the same directory
let inputPath = currentDirectory + "/inputs.txt"

if let fileContents = try? String(contentsOfFile: inputPath, encoding: .utf8) {
    let lines = fileContents.components(separatedBy: .newlines)

    for line in lines {
        let trimmed = line.trimmingCharacters(in: .whitespaces)
        if !trimmed.isEmpty {
            let levels = trimmed.split(separator: " ").compactMap { Int($0) }
            if isSafeWithDampener(levels) {
                safeCount += 1
            }
        }
    }
}

print("Number of safe reports with Problem Dampener: \(safeCount)")
