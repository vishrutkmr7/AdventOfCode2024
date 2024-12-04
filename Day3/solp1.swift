import Foundation

func calculateMulSum(_ text: String) -> Int {
    let pattern = "mul\\((\\d{1,3}),(\\d{1,3})\\)"
    var total = 0

    do {
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(text.startIndex..., in: text)

        let matches = regex.matches(in: text, range: range)

        for match in matches {
            if let xRange = Range(match.range(at: 1), in: text),
                let yRange = Range(match.range(at: 2), in: text),
                let x = Int(text[xRange]),
                let y = Int(text[yRange])
            {
                total += x * y
            }
        }
    } catch {
        print("Regex error: \(error)")
    }

    return total
}

// Get the current file's directory
let currentFilePath = #file
let currentDirectory = URL(fileURLWithPath: currentFilePath).deletingLastPathComponent().path

// Construct path to inputs.txt in the same directory
let inputPath = currentDirectory + "/inputs.txt"

if let fileContents = try? String(contentsOfFile: inputPath, encoding: .utf8) {
    var totalSum = 0
    let lines = fileContents.components(separatedBy: .newlines)

    for line in lines where !line.isEmpty {
        let lineSum = calculateMulSum(line)
        totalSum += lineSum
    }

    print("Sum of all multiplication results: \(totalSum)")
} else {
    print("Error reading file")
}
