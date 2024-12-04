import Foundation

func calculateEnabledMultiplications(_ memory: String) -> Int {
    var total = 0
    var enabled = true

    // Pattern for valid mul(X,Y) - must be exact match with no extra characters
    let mulPattern = "mul\\((\\d{1,3}),(\\d{1,3})\\)"
    // Pattern for control instructions
    let controlPattern = "(?:^|[^a-zA-Z])(do|don't)\\(\\)"

    do {
        let mulRegex = try NSRegularExpression(pattern: mulPattern, options: [])
        let controlRegex = try NSRegularExpression(pattern: controlPattern, options: [])

        let lines = memory.components(separatedBy: .newlines)

        for line in lines where !line.isEmpty {
            var pos = 0

            while pos < line.count {
                let remainingLine = String(line[line.index(line.startIndex, offsetBy: pos)...])
                let remainingRange = NSRange(remainingLine.startIndex..., in: remainingLine)

                let controlMatches = controlRegex.matches(in: remainingLine, range: remainingRange)
                let mulMatches = mulRegex.matches(in: remainingLine, range: remainingRange)

                guard controlMatches.count > 0 || mulMatches.count > 0 else { break }

                let controlPos = controlMatches.first.map { $0.range(at: 1).location } ?? Int.max
                let mulPos = mulMatches.first.map { $0.range.location } ?? Int.max

                if controlPos < mulPos {
                    if let match = controlMatches.first,
                        let range = Range(match.range(at: 1), in: remainingLine)
                    {
                        enabled = remainingLine[range] == "do"
                    }
                    pos += controlMatches.first?.range.upperBound ?? 0
                } else {
                    if enabled,
                        let match = mulMatches.first,
                        let xRange = Range(match.range(at: 1), in: remainingLine),
                        let yRange = Range(match.range(at: 2), in: remainingLine),
                        let x = Int(remainingLine[xRange]),
                        let y = Int(remainingLine[yRange])
                    {
                        total += x * y
                    }
                    pos += mulMatches.first?.range.upperBound ?? 0
                }
            }
        }
    } catch {
        print("Regex error: \(error)")
    }

    return total
}

// Read and process the input file
do {
    let memory = try String(contentsOfFile: "inputs.txt", encoding: .utf8)
    let result = calculateEnabledMultiplications(memory)
    print("Sum of enabled multiplications: \(result)")
} catch {
    print("Error: \(error)")
}
