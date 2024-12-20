import Foundation

func calculateTotalDistance(leftList: [Int], rightList: [Int]) -> Int {
    // Sort both lists to pair smallest with smallest
    let leftSorted = leftList.sorted()
    let rightSorted = rightList.sorted()

    // Zip and sum the absolute differences
    return zip(leftSorted, rightSorted).reduce(0) { sum, pair in
        sum + abs(pair.0 - pair.1)
    }
}

// Parse the input data into two lists
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

let result = calculateTotalDistance(leftList: leftNumbers, rightList: rightNumbers)
print("Total distance: \(result)")
