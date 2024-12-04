import Foundation

struct Point {
    let x: Int
    let y: Int
}

// Possible directions
let directions = [
    // Horizontal
    Point(x: 0, y: -1),
    Point(x: 0, y: 1),

    // Vertical
    Point(x: -1, y: 0),
    Point(x: 1, y: 0),

    // Diagonal
    Point(x: -1, y: -1),
    Point(x: 1, y: 1),
    Point(x: -1, y: 1),
    Point(x: 1, y: -1),
]

func isValid(x: Int, y: Int, rows: Int, cols: Int) -> Bool {
    return x >= 0 && x < cols && y >= 0 && y < rows
}

func countXMAS(grid: [[Character]]) -> Int {
    let rows = grid.count
    let cols = grid[0].count
    var count = 0

    for y in 0..<rows {
        for x in 0..<cols {
            if grid[y][x] == "X" {
                for direction in directions {
                    // Check next three positions for "MAS"
                    let pos1 = (x: x + direction.x, y: y + direction.y)
                    let pos2 = (x: x + direction.x * 2, y: y + direction.y * 2)
                    let pos3 = (x: x + direction.x * 3, y: y + direction.y * 3)

                    if isValid(x: pos1.x, y: pos1.y, rows: rows, cols: cols)
                        && isValid(x: pos2.x, y: pos2.y, rows: rows, cols: cols)
                        && isValid(x: pos3.x, y: pos3.y, rows: rows, cols: cols)
                    {

                        if grid[pos1.y][pos1.x] == "M" && grid[pos2.y][pos2.x] == "A"
                            && grid[pos3.y][pos3.x] == "S"
                        {
                            count += 1
                        }
                    }
                }
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
