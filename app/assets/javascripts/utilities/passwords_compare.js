document.addEventListener('turbolinks:load', function(){
  var password = document.getElementById('user_password')
  var passwordConfirmation = document.getElementById('user_password_confirmation')
  if (password && passwordConfirmation) {
    // если поля ввода паролей найдены
    // ставим перехват события input на оба поля, чтобы фиксировать изменения в обоих полях
    password.addEventListener("input", comparePasswords)
    passwordConfirmation.addEventListener("input", comparePasswords)
  }
})

function comparePasswords() {
  var password = document.getElementById('user_password')
  var passwordConfirmation = document.getElementById('user_password_confirmation')
  // не информировать пользователя, если поле подтверждения пароля пустое
  if (passwordConfirmation.value) {
    if (password.value === passwordConfirmation.value) {
      document.querySelector('.octicon-check').classList.remove('hide')
      document.querySelector('.octicon-x').classList.add('hide')
    } else {
      document.querySelector('.octicon-check').classList.add('hide')
      document.querySelector('.octicon-x').classList.remove('hide')
    }
  } else {
    document.querySelector('.octicon-check').classList.add('hide')
    document.querySelector('.octicon-x').classList.add('hide')
  }
}
