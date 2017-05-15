# CalculatorObjC

Создать проект Calculator c MRC.

  * Создать базовый UI: 
    - UILabel (displayLabel)- для отображения вводимых данных и результата вычисления. По умолчанию, отображается “0"
    - UIButton (digitCollectionButtons)- кнопки, с тайтлами от 0 до 9, служащие для ввода значения. 
    - UIButton (clearButton) - служит для очистки значения в поле displayLabel
    - UIButton (dotButton) - служит для ввода дробных значений
  * Добавить обработчик для digit buttons. Предусмотреть ситуации с вводом 0 в начале, например “0234”, “0000123”
  * Добавить обработчик для clearButton. По нажатие, значение в displayLabel должно сбрасываться в “0"
  * Добавить UISwipeGestureRecognizer на displayLabel. При swipe должно происходить стирание последней цифры 
  * Постараться реализовать обработку нажатия dotButton
