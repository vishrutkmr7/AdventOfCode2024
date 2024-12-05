import Foundation

struct Rule {
    let before: Int
    let after: Int
}

func parseInput(_ input: String) -> (rules: [Rule], updates: [[Int]]) {
    let parts = input.components(separatedBy: "\n\n")
    let ruleLines = parts[0].components(separatedBy: .newlines)
    let updateLines = parts[1].components(separatedBy: .newlines)

    let rules = ruleLines.compactMap { line -> Rule? in
        let numbers = line.split(separator: "|").compactMap { Int($0) }
        guard numbers.count == 2 else { return nil }
        return Rule(before: numbers[0], after: numbers[1])
    }

    let updates = updateLines.compactMap { line -> [Int]? in
        line.split(separator: ",").compactMap { Int($0) }
    }

    return (rules, updates)
}

func isValidSequence(update: [Int], rules: [Rule]) -> Bool {
    // Create a map of positions for quick lookup
    var positions: [Int: Int] = [:]
    for (index, page) in update.enumerated() {
        positions[page] = index
    }

    // Check each applicable rule
    for rule in rules {
        // Only check rules where both pages are in the update
        if let beforePos = positions[rule.before],
            let afterPos = positions[rule.after]
        {
            // If the rule is violated, return false
            if beforePos >= afterPos {
                return false
            }
        }
    }

    return true
}

func findMiddleNumber(_ sequence: [Int]) -> Int {
    return sequence[sequence.count / 2]
}

func solve(_ input: String) -> Int {
    let (rules, updates) = parseInput(input)

    let validUpdates = updates.filter { update in
        isValidSequence(update: update, rules: rules)
    }

    let middleSum = validUpdates.reduce(0) { sum, update in
        sum + findMiddleNumber(update)
    }

    return middleSum
}

let currentFilePath = #file
let currentDirectory = URL(fileURLWithPath: currentFilePath).deletingLastPathComponent().path
let inputPath = currentDirectory + "/inputs.txt"

if let fileContents = try? String(contentsOfFile: inputPath, encoding: .utf8) {
    let result = solve(fileContents)
    print("Sum of middle numbers from valid sequences: \(result)")
} else {
    print("Error reading file: \(inputPath)")
}
