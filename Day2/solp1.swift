import Foundation

func isSafeReport(_ levels: [Int]) -> Bool {
    // Return false if sequence is too short
    guard levels.count >= 2 else {
        return false
    }

    // Check if there are any duplicate adjacent numbers
    for i in 0..<levels.count - 1 {
        if levels[i] == levels[i + 1] {
            return false
        }
    }

    // Check if sequence is increasing or decreasing
    let isIncreasing = levels[0] < levels[1]

    // Check all adjacent pairs
    for i in 0..<levels.count - 1 {
        let diff = abs(levels[i] - levels[i + 1])

        // Difference must be between 1 and 3
        if diff < 1 || diff > 3 {
            return false
        }

        // Check if direction remains consistent
        if isIncreasing && levels[i] >= levels[i + 1] {
            return false
        }
        if !isIncreasing && levels[i] <= levels[i + 1] {
            return false
        }
    }

    return true
}

// Parse input and count safe reports
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
            if isSafeReport(levels) {
                safeCount += 1
            }
        }
    }
}

print("Number of safe reports: \(safeCount)")
