//
//  Template.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 19/05/2022.
//

import Foundation

final class Template {
    
    private let textWithExpressions: String
    private let expressionPattern = try! NSRegularExpression(pattern: "\\$\\{\\w+\\}")
    
    init(textWithExpressions: String) {
        self.textWithExpressions = textWithExpressions
    }
    
    func evaluate(parameters: [String: String]) throws -> String {
        let result = substitute(parameters)
        try validate(result)
        return result
    }
    
    private func substitute(_ parameters: [String: String]) -> String {
        var result = textWithExpressions
        for (key, value) in parameters {
            result = result.replacingOccurrences(of: "${\(key)}", with: value)
        }
        return result
    }
    
    private func validate(_ result: String) throws {
        if expressionPattern.firstMatch(in: result, range: range(for: result)) != nil {
            throw TemplateError.missingParameter
        }
    }
    
    private func range(for text: String) -> NSRange {
        return NSRange(location: 0, length: text.utf16.count)
    }
    
}

enum TemplateError: Error {
    
    case missingParameter
    
}
