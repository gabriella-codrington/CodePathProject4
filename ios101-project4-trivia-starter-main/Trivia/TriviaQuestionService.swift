//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Gabriella Codrington on 10/10/23.
//

import Foundation

class TriviaQuestionService {
    static func fetchTrivia(category: String,
                            question: String,
                            correctAnswer: String,
                            incorrectAnswers: [String],
                            completion: ((TriviaQuestion) -> Void)?) {
        let parameters = "amount=5&category=\(category)&difficulty=easy"
        let url = URL(string: "https://opentdb.com/api.php?)amount=5")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
              // this closure is fired when the response is received
              guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
              }
              guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
              }
              guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
              }
                let question = parse(data: data)
                let decoder = JSONDecoder()
                let response = try! decoder.decode(TriviaAPIResponse.self, from: data)
                DispatchQueue.main.async {
                    completion?(question)
                }
            }
            task.resume() // resume the task and fire the request
        
    }
    private static func parse(data: Data) -> TriviaQuestion {
        let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        //let currentTrivia = jsonDictionary["results"] as! [String: Any]
        let category = jsonDictionary["category"] as! String
        let difficulty = jsonDictionary["difficulty"] as! String
        let type = jsonDictionary["type"] as! String
        let question = jsonDictionary["question"] as! String
        let correctAnswer = jsonDictionary["correctAnswer"] as! String
        let incorrectAnswers = jsonDictionary["incorrectAnswers"] as! [String]
        
        return TriviaQuestion(category: category,
                                     question: question,
                                     correctAnswer: correctAnswer,
                                     incorrectAnswers: incorrectAnswers)
    }
}



