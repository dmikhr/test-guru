# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = Category.create!(
  [
    {title: 'Английский' },
    {title: 'География' },
    {title: 'Информатика'},
    {title: 'Физика'}
  ]
  )

users = User.create!(
  [
    {login: 'alexe', password: 'pass1234', email: 'egorov@testmail.com' ,name: 'Алексей Егоров', role: 'студент'},
    {login: 'oksanb', password: 'pass2345', email: 'bogdanova@testmail.com' , name: 'Оксана Богданова', role: 'студент'},
    {login: 'kirillov', password: 'pass5678', email: 'kirillov@testmail.com' , name: 'Евгений Кириллов', role: 'студент'},
    {login: 'maksimivaob', password: 'pass3456', email: 'maksimova@testmail.com', name: 'Максимова Ольга Витальевна', role: 'преподаватель'},
    {login: 'petrov', password: 'pass9876', email: 'petrov@testmail.com' , name: 'Петров Олег Евгеньевич', role: 'преподаватель'},
  ]
  )

# добавил больше тестов для тестирования scope-методов выбора тестов по сложности
tests = Test.create!(
  [
    {title: 'Английский уровень Beginner', level: 0, category: categories[0], creator: users[3]},
    {title: 'Английский уровень Pre-Intermediate', level: 1, category: categories[0], creator: users[3]},
    {title: 'География для школьников', level: 0, category: categories[1], creator: users[3]},
    {title: 'География для студентов ВУЗов', level: 3, category: categories[1], creator: users[3]},
    {title: 'Теория алгоритмов', level: 2, category: categories[2], creator: users[4]},
    {title: 'Цифровая обработка сигналов', level: 4, category: categories[2], creator: users[4]},
    {title: 'Механика сплошных сред', level: 7, category: categories[3], creator: users[4]},
    {title: 'Квантовая физика', level: 10, category: categories[3], creator: users[4]}
  ]
  )

questions = Question.create!(
  [
    {body: 'Choose the correct word: He was so tired that he ... asleep in the chair', test: tests[0]},
    {body: 'Choose the correct word: Our company is a small organization with only a few ... ', test: tests[0]},
    {body: 'Choose the correct word: Before we start the lesson, I`d like to ... what we did yesterday', test: tests[1]},
    {body: 'Choose the correct word: In order to ... with his studies he worked through the summer', test: tests[1]},
    {body: 'Столица Непала', test: tests[2]},
    {body: 'Выберите островные государства', test: tests[3]},
    {body: 'Какие из представленных стран находятся в Южной Америке?', test: tests[3]},
    {body: 'Выберите города, находящиеся на Европейском континенте', test: tests[3]}
  ]
  )

answers = Answer.create!(
  [
    {correct: true, body: 'fell', question: questions[0]},
    {correct: false, body: 'went', question: questions[0]},
    {correct: false, body: 'employerers', question: questions[1]},
    {correct: true, body: 'employees', question: questions[1]},
    {correct: false, body: 'jobbers', question: questions[1]},
    {correct: false, body: 'run along', question: questions[2]},
    {correct: true, body: 'run through', question: questions[2]},
    {correct: false, body: 'take up', question: questions[3]},
    {correct: true, body: 'catch up', question: questions[3]},
    {correct: false, body: 'Мумбаи', question: questions[4]},
    {correct: true, body: 'Катманду', question: questions[4]},
    {correct: false, body: 'Севилья', question: questions[4]},
    {correct: true, body: 'Гонконг', question: questions[5]},
    {correct: false, body: 'Дания', question: questions[5]},
    {correct: true, body: 'Сингапур', question: questions[5]},
    {correct: true, body: 'Шри-Ланка', question: questions[5]},
    {correct: false, body: 'Мексика', question: questions[6]},
    {correct: true, body: 'Уругвай', question: questions[6]},
    {correct: true, body: 'Чили', question: questions[6]},
    {correct: true, body: 'Копенгаген', question: questions[7]},
    {correct: true, body: 'Москва', question: questions[7]},
    {correct: false, body: 'Токио', question: questions[7]}
  ]
  )
