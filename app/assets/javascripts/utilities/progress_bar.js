document.addEventListener('turbolinks:load', function() {
  var controls = document.querySelector('.passage-progress');

  if (controls) {
    var progressPercentage = controls.dataset.progressPercentage;
    showProgress(progressPercentage);
  }
})

// на основе идей из https://www.w3schools.com/howto/howto_js_progressbar.asp
function showProgress(progressPercentage) {
  var progress = document.getElementById("progress");
  // изменяем ширину progress в % относительно фиксированного по ширине bar
  progress.style.width =  progressPercentage + '%';
  // отображаем прогресс в %
  progress.innerHTML = Math.round(progressPercentage) + '%';
}
