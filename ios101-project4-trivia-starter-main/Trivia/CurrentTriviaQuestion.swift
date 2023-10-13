//
//  CurrentTriviaQuestion.swift
//  Trivia
//
//  Created by Gabriella Codrington on 10/10/23.
//

import Foundation

struct TriviaAPIResponse: Decodable {
  let currentTriviaQuestion: CurrentTriviaQuestion

  private enum CodingKeys: String, CodingKey {
    case currentTriviaQuestion = "current_trivia_question"
  }
}

struct CurrentTriviaQuestion: Decodable {
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    private enum CodingKeys: String, CodingKey {
        case category = "category"
        case question = "question"
        case correctAnswer = "correctAnswer"
        case incorrectAnswers = "incorrectAnswers"
    }
}
