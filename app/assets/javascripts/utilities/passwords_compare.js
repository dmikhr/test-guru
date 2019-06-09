document.addEventListener('turbolinks:load', function() {
  var password = document.getElementById('user_password');
  var passwordConfirmation = document.getElementById('user_password_confirmation');
  if (password && passwordConfirmation) {
    // если поля ввода паролей найдены
    // ставим перехват события input на оба поля, чтобы фиксировать изменения в обоих полях
    password.addEventListener("input", function() {
      comparePasswords(password, passwordConfirmation);
    });
    passwordConfirmation.addEventListener("input", function() {
      comparePasswords(password, passwordConfirmation);
    });
  }
})

function comparePasswords(password, passwordConfirmation) {
  var match = document.querySelector('.octicon-check').classList;
  var notMatch = document.querySelector('.octicon-x').classList;
  // не информировать пользователя, если поле подтверждения пароля пустое
  if (passwordConfirmation.value) {
    if (password.value === passwordConfirmation.value) {
      match.remove('hide');
      notMatch.add('hide');
    } else {
      match.add('hide');
      notMatch.remove('hide');
    }
  } else {
    match.add('hide');
    notMatch.add('hide');
  }
}
