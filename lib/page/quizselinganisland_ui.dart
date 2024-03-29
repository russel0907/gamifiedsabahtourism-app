// ignore_for_file: use_key_in_widget_constructors, duplicate_ignore, non_constant_identifier_names, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, deprecated_member_use, unused_local_variable

// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:home_interfaces/main.dart';

//color gradient
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

class QuizSelinganIslandUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuizSelinganIslandUIState();
  }
}

class _QuizSelinganIslandUIState extends State<QuizSelinganIslandUI> {
  var _questionIndex = 0;
  var _totalScore = 0;

  final questions_selinganisland = const [
    {
      "questionText": "Q1. Where is Selingan Island located?",
      "answers": [
        {'text': 'Penampang', 'score': 0},
        {'text': 'Ranau', 'score': 0},
        {'text': 'Kundasang', 'score': 0},
        {'text': 'Sandakan', 'score': 20},
      ],
    },
    {
      'questionText': 'Q2. How far is Selingan Island from Sandakan?',
      'answers': [
        {'text': '15 Kilometres', 'score': 0},
        {'text': '40 Kilometres', 'score': 20},
        {'text': '60 Kilometres', 'score': 0},
        {'text': '100 Kilometres', 'score': 0},
      ],
    },
    {
      'questionText': ' Q3. What other term can be called for Selingan Island?',
      'answers': [
        {'text': 'A sanctuary for green and hawksbill turtles', 'score': 0},
        {'text': 'Designated National Park', 'score': 0},
        {'text': 'The Safe Heaven for Turtles', 'score': 20},
        {'text': 'Turtle Islands', 'score': 0},
      ],
    },
    {
      'questionText':
          'Q4. What is the best time to see turtles lay their eggs?',
      'answers': [
        {'text': 'July', 'score': 20},
        {'text': 'October', 'score': 20},
        {'text': 'January', 'score': 0},
        {'text': 'December', 'score': 0},
      ],
    },
    {
      'questionText': 'Q5. All activities below are offered in Selingan except',
      'answers': [
        {'text': 'Camping', 'score': 20},
        {'text': 'Scuba', 'score': 0},
        {'text': 'Diving', 'score': 0},
        {'text': 'Snorkeling', 'score': 0},
      ],
    },
  ];

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < questions_selinganisland.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  GradientColors.aqua[1],
                  GradientColors.malibuBeach[1],
                  GradientColors.malibuBeach[0],
                ])),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: GradientColors.happyFisher[1], width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 50,
                  width: 260,
                  child: Center(
                    child: Text(
                      'Selingan Island',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 25),
                    child: Center(
                        child: Image(
                            width: 120,
                            image: AssetImage('img/logo/logo.png')))),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _questionIndex < questions_selinganisland.length
                          ? Quiz(
                              answerQuestion: _answerQuestion,
                              questionIndex: _questionIndex,
                              questions: questions_selinganisland,
                            ) //Quiz
                          : Result(_totalScore, _resetQuiz),
                    ),
                  ],
                ),
              ],
            )),
        //Padding
      ), //Scaffold
      debugShowCheckedModeBanner: false,
    ); //MaterialApp
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.9), BlendMode.dstATop),
                image: AssetImage('img/quizbackground/quizbackground.png'),
                fit: BoxFit.fill,
              ),
              border:
                  Border.all(color: GradientColors.happyFisher[1], width: 5),
              borderRadius: BorderRadius.circular(4),
            ),
            width: 400,
            height: 150,
            child: Center(
                child: Question(
              questions[questionIndex]['questionText']?.toString() ?? '',
            ))), //Question
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']),
              answer['text']?.toString() ?? '');
        }).toList(),
      ],
    ); //Column
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ), //Text
    ); //Container
  }
}

class Answer extends StatelessWidget {
  final Function() selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 5, top: 5),
      child: ElevatedButton(
        child: Text(answerText),
        onPressed: selectHandler,
      ), //RaisedButton
    ); //Container
  }
}

class Result extends StatelessWidget {
  final int resultScore;
  final Function() resetHandler;

  Result(this.resultScore, this.resetHandler);

//Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore == 100) {
      resultText = 'Excellent!';
      print(resultScore);
    } else if (resultScore >= 80) {
      resultText = 'You are awesome!';
      print(resultScore);
    } else if (resultScore >= 60) {
      resultText = 'Pretty likeable!';
      print(resultScore);
    } else if (resultScore >= 40) {
      resultText = 'You need to work more!';
    } else if (resultScore >= 20) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(
                  color: Colors.lightBlue,
                ),
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.only(top: 50),
            height: 300,
            child: Center(
              child: Column(
                children: [
                  Text(
                    resultPhrase,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ), //Text
                  Text(
                    'Score ' '$resultScore',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ), //Text
                  TextButton(
                    child: Text(
                      'Restart Quiz!',
                      style: TextStyle(fontSize: 16),
                    ), //Text
                    onPressed: resetHandler,
                  ),
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        border: Border.all(
                          width: 3,
                          color: Colors.black87,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    height: 50,
                    width: 150,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AppUI()));
                        },
                        child: Text(
                          'Home',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )),
                  ),
                ],
              ),
            ),
          )

          //FlatButton
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}
