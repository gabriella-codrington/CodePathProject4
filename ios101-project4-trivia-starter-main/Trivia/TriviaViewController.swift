//
//  ViewController.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import UIKit

class TriviaViewController: UIViewController {
    
    @IBOutlet weak var currentQuestionNumberLabel: UILabel!
    @IBOutlet weak var questionContainerView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var answerButton0: UIButton!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    
    private var questions = [TriviaQuestion]()
    private var currQuestionIndex = 0
    private var numCorrectQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        questionContainerView.layer.cornerRadius = 8.0
        // TODO: FETCH TRIVIA QUESTIONS HERE
        let question1 = TriviaQuestion(category: "Entertainment: Video Games",
                                       question: "The &quot;Day of Defeat&quot; series of games take place during which war?",
                                       correctAnswer: "World War II",
                                       incorrectAnswers: [
                                        "World War I",
                                        "Vietnam War",
                                        "Iraq War"
                                       ])
        let question2 = TriviaQuestion(category: "Entertainment: Comics",
                                       question: "What year was the first San Diego Comic-Con?",
                                       correctAnswer: "1970",
                                       incorrectAnswers: [
                                        "2000",
                                        "1990",
                                        "1985"
                                       ])
        let question3 = TriviaQuestion(category: "General Knowledge",
                                       question: "Dihydrogen Monoxide was banned due to health risks after being discovered in 1983 inside swimming pools and drinking water.",
                                       correctAnswer: "False",
                                       incorrectAnswers: [
                                        "True"
                                       ])
        let question4 = TriviaQuestion(category: "Entertainment: Japanese Anime & Manga",
                                       question: "In &quot;Black Lagoon&quot;, what colour is Rock&#039;s tie?",
                                       correctAnswer: "Teal",
                                       incorrectAnswers: [
                                        "Crimson",
                                        "Dark Brown",
                                        "Black"
                                       ])
        let question5 = TriviaQuestion(category: "Entertainment: Video Games",
                                       question: "What are tiny Thwomps called in Super Mario World?",
                                       correctAnswer: "Thwimps",
                                       incorrectAnswers: [
                                        "Little Thwomp",
                                        "Mini Thwomp",
                                        "Tiny Tims"
                                       ])
        
        questions = [question1, question2, question3, question4, question5]
        
    }
    private var correctAnswer: String = ""
    private var incorrectAnswers: [String] = [] 
    private func updateQuestion(withQuestionIndex questionIndex: Int) {
        currentQuestionNumberLabel.text = "Question: \(questionIndex + 1)/\(questions.count)"
        let question = questions[questionIndex]
        questionLabel.text = question.question
        categoryLabel.text = question.category
        let answers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
        if answers.count > 0 {
            answerButton0.setTitle(answers[0], for: .normal)
        }
        if answers.count > 1 {
            answerButton1.setTitle(answers[1], for: .normal)
            answerButton1.isHidden = false
        }
        if answers.count > 2 {
            answerButton2.setTitle(answers[2], for: .normal)
            answerButton2.isHidden = false
        }
        if answers.count > 3 {
            answerButton3.setTitle(answers[3], for: .normal)
            answerButton3.isHidden = false
        }
        TriviaQuestionService.fetchTrivia(category: question.category, question: question.question, correctAnswer: question.correctAnswer, incorrectAnswers: question.incorrectAnswers) { (question) in
            self.configure(with: question)
        }
        
    }
    private func configure(with question: TriviaQuestion) {
        categoryLabel.text = "\(question.category)"
        questionLabel.text = "\(question.question)"
        correctAnswer = question.correctAnswer
        incorrectAnswers = question.incorrectAnswers
    }

  private func updateToNextQuestion(answer: String) {
    if isCorrectAnswer(answer) {
      numCorrectQuestions += 1
    }
    currQuestionIndex += 1
    guard currQuestionIndex < questions.count else {
      showFinalScore()
      return
    }
    updateQuestion(withQuestionIndex: currQuestionIndex)
  }
  
  private func isCorrectAnswer(_ answer: String) -> Bool {
    return answer == questions[currQuestionIndex].correctAnswer
  }
  
  private func showFinalScore() {
    let alertController = UIAlertController(title: "Game over!",
                                            message: "Final score: \(numCorrectQuestions)/\(questions.count)",
                                            preferredStyle: .alert)
    let resetAction = UIAlertAction(title: "Restart", style: .default) { [unowned self] _ in
      currQuestionIndex = 0
      numCorrectQuestions = 0
      updateQuestion(withQuestionIndex: currQuestionIndex)
    }
    alertController.addAction(resetAction)
    present(alertController, animated: true, completion: nil)
  }
  
  private func addGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                            UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    view.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  @IBAction func didTapAnswerButton0(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton1(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton2(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton3(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
}

