# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# категории названы по-английски для удобства отладки метода
# Test.tests_by_category_desc(category)
# т.к. консоль Rails кириллический ввод не принимает
# добавил больше категорий для тестирования scope-метода соритровки категорий
Category.create(
  [
    {title: 'English' },
    {title: 'OBZ' },
    {title: 'Computer Science'},
    {title: 'Physics'}
  ]
  )

User.create(
  [
    {login: 'alexe' , password: 'pass1234', email: 'egorov@testmail.com' ,name: 'Алексей Егоров' , role: 'студент'},
    {login: 'oksanb' , password: 'pass2345', email: 'bogdanova@testmail.com'  , name: 'Оксана Богданова', role: 'студент'},
    {login: 'kirillov' , password: 'pass5678', email: 'kirillov@testmail.com'  , name: 'Евгений Кириллов', role: 'студент'},
    {login: 'maksimivaob' , password: 'pass3456', email: 'maksimova@testmail.com', name: 'Максимова Ольга Витальевна' , role: 'преподаватель'},
    {login: 'petrov' , password: 'pass9876', email: 'petrov@testmail.com'  , name: 'Петров Олег Евгеньевич', role: 'преподаватель'},
  ]
  )

# добавил больше тестов для тестирования scope-методов выбора тестов по сложности
Test.create(
  [
    {title: 'Английский уровень Beginner' , level: 0, category_id: 1, creator_id: 4},
    {title: 'Английский уровень Pre-Intermediate' , level: 1, category_id: 1, creator_id: 4},
    {title: 'Основы ОБЖ' , level: 0, category_id: 2, creator_id: 5},
    {title: 'ОБЖ для специалистов' , level: 1, category_id: 2, creator_id: 5},
    {title: 'Теория алгоритмов' , level: 2, category_id: 3, creator_id: 5},
    {title: 'Цифровая обработка сигналов' , level: 4, category_id: 3, creator_id: 5},
    {title: 'Механика сплошных сред' , level: 7, category_id: 4, creator_id: 5},
    {title: 'Квантовая физика' , level: 10, category_id: 4, creator_id: 5}
  ]
  )

Question.create(
  [
    {body: 'Choose the correct word: He was so tired that he ... asleep in the chair' , test_id: 1},
    {body: 'Choose the correct word: Our company is a small organization with only a few ... ' , test_id: 1},
    {body: 'Choose the correct word: Before we start the lesson, I`d like to ... what we did yesterday' , test_id: 2},
    {body: 'Choose the correct word: In order to ... with his studies he worked through the summer' , test_id: 2},
    {body: 'Choose the correct word: Before we start the lesson, I`d like to ... what we did yesterday' , test_id: 2},
    {body: 'Правильно ли названы виды лесных пожаров: низовой, верховой, торфяной' , test_id: 3},
    {body: 'Укажите крутизну склона, при которой возникает наиболее вероятная ситуация схода лавин' , test_id: 4},
    {body: 'Укажите бальность очень сильного землетрясения' , test_id: 4}
  ]
  )

Answer.create(
  [
    {correct: true, body: 'fell' , question_id: 1},
    {correct: false, body: 'went' , question_id: 1},
    {correct: false, body: 'employerers' , question_id: 2},
    {correct: true, body: 'employees' , question_id: 2},
    {correct: false, body: 'run along' , question_id: 3},
    {correct: true, body: 'run through' , question_id: 3},
    {correct: false, body: 'take up' , question_id: 4},
    {correct: true, body: 'catch up' , question_id: 4},
    {correct: false, body: 'один лишний' , question_id: 5},
    {correct: true, body: 'да' , question_id: 5},
    {correct: false, body: '45-50' , question_id: 6},
    {correct: false, body: 'более 50' , question_id: 6},
    {correct: true, body: '30-40' , question_id: 6},
    {correct: true, body: '6 баллов' , question_id: 7},
    {correct: false, body: '3 балла' , question_id: 7}
  ]
  )

PassedTest.create(
  [
    {user_id: 1, test_id: 1},
    {user_id: 1, test_id: 2},
    {user_id: 1, test_id: 4},
    {user_id: 2, test_id: 2},
    {user_id: 2, test_id: 4},
    {user_id: 3, test_id: 1}
  ]
  )
