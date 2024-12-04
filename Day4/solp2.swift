import Foundation

struct Point {
    let x: Int
    let y: Int
}

let corners = [
    // Top-left, Top-right, Bottom-left, Bottom-right
    (
        Point(x: -1, y: -1),
        Point(x: 1, y: -1),
        Point(x: -1, y: 1),
        Point(x: 1, y: 1)
    )
]

func isValid(x: Int, y: Int, rows: Int, cols: Int) -> Bool {
    return x >= 0 && x < cols && y >= 0 && y < rows
}

func isValidXMAS(grid: [[Character]], centerX: Int, centerY: Int) -> Bool {
    let rows = grid.count
    let cols = grid[0].count

    // Check if center is 'A'
    guard grid[centerY][centerX] == "A" else { return false }

    let diagonals = [
        // Top-left to bottom-right paired with top-right to bottom-left
        [(Point(x: -1, y: -1), Point(x: 1, y: 1)), (Point(x: 1, y: -1), Point(x: -1, y: 1))],
        // Top-right to bottom-left paired with top-left to bottom-right
        [(Point(x: 1, y: -1), Point(x: -1, y: 1)), (Point(x: -1, y: -1), Point(x: 1, y: 1))],
    ]

    for diagonalPair in diagonals {
        let firstDiagonal = diagonalPair[0]
        let secondDiagonal = diagonalPair[1]

        // check all points' validity
        let points = [
            (centerX + firstDiagonal.0.x, centerY + firstDiagonal.0.y),
            (centerX + firstDiagonal.1.x, centerY + firstDiagonal.1.y),
            (centerX + secondDiagonal.0.x, centerY + secondDiagonal.0.y),
            (centerX + secondDiagonal.1.x, centerY + secondDiagonal.1.y),
        ]

        if points.allSatisfy({ isValid(x: $0.0, y: $0.1, rows: rows, cols: cols) }) {
            let first1 = grid[points[0].1][points[0].0]
            let first2 = grid[points[1].1][points[1].0]
            let second1 = grid[points[2].1][points[2].0]
            let second2 = grid[points[3].1][points[3].0]

            if ((first1 == "M" && first2 == "S") || (first1 == "S" && first2 == "M"))
                && ((second1 == "M" && second2 == "S") || (second1 == "S" && second2 == "M"))
            {
                return true
            }

        }

    }

    return false
}

func countXMAS(grid: [[Character]]) -> Int {
    let rows = grid.count
    let cols = grid[0].count
    var count = 0

    // Check each position as potential center 'A'
    for y in 0..<rows {
        for x in 0..<cols {
            if isValidXMAS(grid: grid, centerX: x, centerY: y) {
                count += 1
            }
        }
    }

    return count
}

// Get the current file's directory
let currentFilePath = #file
let currentDirectory = URL(fileURLWithPath: currentFilePath).deletingLastPathComponent().path

// Construct path to inputs.txt in the same directory
let inputPath = currentDirectory + "/inputs.txt"

if let fileContents = try? String(contentsOfFile: inputPath, encoding: .utf8) {
    let grid = fileContents.components(separatedBy: .newlines)
        .filter { !$0.isEmpty }
        .map { Array($0) }

    let result = countXMAS(grid: grid)
    print("Number of valid XMAS: \(result)")
} else {
    print("Error reading file: \(inputPath)")
}
