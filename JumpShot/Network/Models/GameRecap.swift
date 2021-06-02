//
//  GameRecap.swift
//  JumpShot
//
//  Copyright (c) 2021 Jerel Rocktaschel
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public struct Paragraph {

    // MARK: Internal Properties

    let text: String
}

extension Paragraph: Decodable {

    // MARK: Coding Keys

    enum LeadTrackerCodingKeys: String, CodingKey {
        case text = "paragraph"
    }
}

extension Paragraph: Equatable {

    // MARK: Equatable

    public static func ==(lhs: Paragraph, rhs: Paragraph) -> Bool {
        return lhs.text == rhs.text
    }
}

public struct GameRecap {

    // MARK: Internal Properties

    let author: String
    let authorTitle: String
    let copyright: String
    let title: String
    let publishDate: Date
    let paragraphs: [Paragraph]

    public init(from decoder: Decoder) throws {

        // MARK: Init

        let gameRecapCodingKeysContainer = try decoder.container(keyedBy: GameRecapCodingKeys.self)
        let publishDateString = try gameRecapCodingKeysContainer.decode(String.self,
                                                                                  forKey: .publishDate)
        let paragraphList = try gameRecapCodingKeysContainer.decode([[String: String]].self,
                                                                           forKey: .paragraphs)

        author = try gameRecapCodingKeysContainer.decode(String.self, forKey: .author)
        authorTitle = try gameRecapCodingKeysContainer.decode(String.self, forKey: .authorTitle)
        copyright = try gameRecapCodingKeysContainer.decode(String.self, forKey: .copyright)
        title = try gameRecapCodingKeysContainer.decode(String.self, forKey: .title)

        if let publishDateFormat = publishDateString.iso8601Date {
            publishDate = publishDateFormat
        } else {
            throw DecodingError.dataCorruptedError(forKey: .publishDate,
                                                       in: gameRecapCodingKeysContainer,
                                         debugDescription: "Publish Date not in expected format.")
        }

        var paragraphArray = [Paragraph]()
        for paragraph in paragraphList {
            if let text = paragraph.values.first {
                let paragraph = Paragraph(text: text)
                paragraphArray.append(paragraph)
            }
        }
        paragraphs = paragraphArray
    }
}

extension GameRecap: Decodable {

    // MARK: Coding Keys

    enum GameRecapCodingKeys: String, CodingKey {
        case author
        case authorTitle
        case copyright
        case title
        case publishDate = "pubDateUTC"
        case paragraphs
    }
}

struct GameRecapApiResponse {

    // MARK: Internal Properties

    var gameRecap: GameRecap
}

extension GameRecapApiResponse {

    // MARK: Init

    init?(json: [String: Any]) {

        do {
            guard let jsonGameRecapData = try? JSONSerialization.data(withJSONObject: json,
                                                                                 options: []) else {
                    return nil
            }

            let gameRecap = try JSONDecoder().decode(GameRecap.self, from: jsonGameRecapData)
            self.gameRecap = gameRecap
            } catch {
                return nil
        }
    }
}
