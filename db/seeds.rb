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
      {login: 'alexe', password: 'pass1234', password_confirmation: 'pass1234', email: 'domainite@gmail.com' ,first_name: 'Алексей', last_name: 'Егоров', type: 'User'},
      {login: 'oksanb', password: 'pass2345', password_confirmation: 'pass2345', email: 'bogdanova@testmail.com', first_name: 'Оксана', last_name: 'Белова', type: 'User'},
      {login: 'serg', password: 'pass2345', password_confirmation: 'pass2345', email: 'serg@testmail.com', first_name: 'Сергей', last_name: 'Рожков', type: 'User'},
      {login: 'petrov', password: 'pass9876', password_confirmation: 'pass9876', email: 'petrov@testmail.com' , first_name: 'Олег', last_name: 'Петров', type: 'Admin'},
      {login: 'maksimova', password: 'pass9876', password_confirmation: 'pass9876', email: 'maksimova@testmail.com' , first_name: 'Ольга', last_name: 'Максимова', type: 'Admin'},
      {login: 'guruadmin', password: 'df_12cX9_q', password_confirmation: 'df_12cX9_q', email: 'developer@agileapps.net' , first_name: 'Admin', last_name: 'Guru', type: 'Admin'}
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

gists = Gist.create!(
  [
    {user: users[3], question: questions[5], url: 'https://gist.github.com/dmikhr/154034d53a156077ec77a63fd59b07ec'},
    {user: users[2], question: questions[1], url: 'https://gist.github.com/dmikhr/01b66f014cd6dceff5dc88f0148cc78d'}
  ]
  )
