document.addEventListener('turbolinks:load', function() {
  var timer = document.querySelector('.time-left');

  if (timer) {
    var timeLeft = timer.dataset.timeLeft;
    startTimer(timer, timeLeft);
  }
})

function startTimer(timer, timeLeft) {
  var counter = setInterval(function() {
    sec = timeLeft % 60;
    min = (timeLeft - sec) / 60;
    timer.innerHTML = time_format(min) + ':' + time_format(sec);
    if (timeLeft > 0 && timeLeft <= 5) {
      // предупреждаем, что время скоро закончится
      timer.style.color = 'red';
      timer.style.fontWeight = 'bold';
    } else if (timeLeft <= 0) {
      // останавливаем таймер
      clearInterval(counter);
      // программно нажимаем на кнопку для завершения теста
      document.getElementById("test-passage-form").submit();
    }
    timeLeft--;
  }, 1000);
}

function time_format(time_elem) {
  if ( time_elem >= 0 && time_elem < 10) {
    return '0' + time_elem;
  } else {
    return time_elem;
  }
}
