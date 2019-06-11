// быстрое редактирование реализовано через октиконы
// у каждого заголовка 2 октикона - на редатирование и отмену редактирования
document.addEventListener('turbolinks:load', function() {
  var controlsEdit = document.querySelectorAll('.form-inline-edit');
  var controlsCancel = document.querySelectorAll('.form-inline-cancel');
  if (controlsEdit.length && controlsCancel.length) {
    for (var i = 0; i < controlsEdit.length; i++) {
      controlsEdit[i].addEventListener('click', formInlineOcticonHandler);
      controlsCancel[i].addEventListener('click', formInlineOcticonHandler);
    }
  }
  var errors = document.querySelector('.resource-errors');
  if (errors) {
    var resourceId = errors.dataset.resourceId;
    formInlineHandler(resourceId);
  }
})

function formInlineOcticonHandler(event) {
  event.preventDefault();
  var testId = this.dataset.testId;
  formInlineHandler(testId);
}

function formInlineHandler(testId) {
  var edit = document.querySelector('.form-inline-edit[data-test-id="' + testId + '"]');
  var cancel = document.querySelector('.form-inline-cancel[data-test-id="' + testId + '"]');
  var testTitle = document.querySelector('.test-title[data-test-id="' + testId + '"]');
  var formInline = document.querySelector('.form-inline[data-test-id="' + testId + '"]');
  // "Найдите и исправьте ошибку в JavaScript на странице полной формы редактирования теста (появляется при попытке сохранить тест с невалидными данными)"
  // добавлена проверка на существование formInline, без этого будет ошибка
  // при попытке сохранить невалидные данные: TypeError: formInline is null
  if (formInline) {
    if (formInline.classList.contains('hide')) {
      testTitle.classList.add('hide');
      formInline.classList.remove('hide');
      edit.classList.add('hide');
      cancel.classList.remove('hide');
    } else {
      testTitle.classList.remove('hide');
      formInline.classList.add('hide');
      edit.classList.remove('hide');
      cancel.classList.add('hide');
    }
  }
}
