import Foundation

func calculateSimilarityScore(leftList: [Int], rightList: [Int]) -> Int {
    // Convert right list to a frequency dictionary for O(1) lookups
    var rightFreq: [Int: Int] = [:]
    for num in rightList {
        rightFreq[num, default: 0] += 1
    }

    // Calculate similarity score
    var totalScore = 0
    for num in leftList {
        // Multiply each left number by its frequency in right list
        let frequency = rightFreq[num] ?? 0
        totalScore += num * frequency
    }

    return totalScore
}

// Parse the input data
var leftNumbers: [Int] = []
var rightNumbers: [Int] = []
// Get the current file's directory
let currentFilePath = #file
let currentDirectory = URL(fileURLWithPath: currentFilePath).deletingLastPathComponent().path

// Construct path to inputs.txt in the same directory
let inputPath = currentDirectory + "/inputs.txt"

if let fileContents = try? String(contentsOfFile: inputPath, encoding: .utf8) {
    let lines = fileContents.components(separatedBy: .newlines)
    for line in lines {
        if !line.isEmpty {
            let numbers = line.split(separator: " ").compactMap { Int($0) }
            if numbers.count == 2 {
                leftNumbers.append(numbers[0])
                rightNumbers.append(numbers[1])
            }
        }
    }
}

let result = calculateSimilarityScore(leftList: leftNumbers, rightList: rightNumbers)
print("Similarity score: \(result)")
