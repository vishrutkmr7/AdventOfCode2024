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
    var positions: [Int: Int] = [:]
    for (index, page) in update.enumerated() {
        positions[page] = index
    }

    for rule in rules {
        if let beforePos = positions[rule.before],
            let afterPos = positions[rule.after]
        {
            if beforePos >= afterPos {
                return false
            }
        }
    }
    return true
}

func buildGraph(_ pages: [Int], rules: [Rule]) -> [Int: Set<Int>] {
    var graph: [Int: Set<Int>] = [:]
    let pagesSet = Set(pages)

    // Initialize empty adjacency lists
    for page in pages {
        graph[page] = Set<Int>()
    }

    // Add edges for applicable rules
    for rule in rules {
        if pagesSet.contains(rule.before) && pagesSet.contains(rule.after) {
            graph[rule.before]?.insert(rule.after)
        }
    }

    return graph
}

func topologicalSort(_ pages: [Int], rules: [Rule]) -> [Int] {
    let graph = buildGraph(pages, rules: rules)
    var result: [Int] = []
    var visited = Set<Int>()
    var temp = Set<Int>()

    func dfs(_ node: Int) {
        if temp.contains(node) { return }  // Handle cycles
        if visited.contains(node) { return }

        temp.insert(node)

        if let neighbors = graph[node] {
            for neighbor in neighbors {
                dfs(neighbor)
            }
        }

        temp.remove(node)
        visited.insert(node)
        result.insert(node, at: 0)
    }

    for page in pages {
        if !visited.contains(page) {
            dfs(page)
        }
    }

    return result
}

func findMiddleNumber(_ sequence: [Int]) -> Int {
    return sequence[sequence.count / 2]
}

func solve(_ input: String) -> Int {
    let (rules, updates) = parseInput(input)

    let incorrectUpdates = updates.filter { update in
        !isValidSequence(update: update, rules: rules)
    }

    let middleSum = incorrectUpdates.reduce(0) { sum, update in
        let sortedUpdate = topologicalSort(update, rules: rules)
        return sum + findMiddleNumber(sortedUpdate)
    }

    return middleSum
}

let currentFilePath = #file
let currentDirectory = URL(fileURLWithPath: currentFilePath).deletingLastPathComponent().path
let inputPath = currentDirectory + "/inputs.txt"

if let fileContents = try? String(contentsOfFile: inputPath, encoding: .utf8) {
    let result = solve(fileContents)
    print("Sum of middle numbers from corrected sequences: \(result)")
} else {
    print("Error reading file: \(inputPath)")
}
