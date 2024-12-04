// Utils.swift
import Foundation

struct FileUtils {
    static func getInputPath(for day: Int) -> String {
        let currentFile = #file
        let currentDirectory = URL(fileURLWithPath: currentFile)
            .deletingLastPathComponent()
            .path
        return "\(currentDirectory)/Day\(day)/inputs.txt"
    }

    static func readInputFile(for day: Int) -> String? {
        let path = getInputPath(for: day)
        return try? String(contentsOfFile: path, encoding: .utf8)
    }

    static func readLines(for day: Int) -> [String] {
        guard let contents = readInputFile(for: day) else { return [] }
        return contents.components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
    }
}
