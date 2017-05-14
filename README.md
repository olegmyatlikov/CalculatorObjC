# CalculatorObjC

Создать проект Calculator c MRC.

TASK 1
  * Создать базовый UI: 
    - UILabel (displayLabel)- для отображения вводимых данных и результата вычисления. По умолчанию, отображается “0"
    - UIButton (digitCollectionButtons)- кнопки, с тайтлами от 0 до 9, служащие для ввода значения. 
    - UIButton (clearButton) - служит для очистки значения в поле displayLabel
    - UIButton (dotButton) - служит для ввода дробных значений
  * Добавить обработчик для digit buttons. Предусмотреть ситуации с вводом 0 в начале, например “0234”, “0000123”
  * Добавить обработчик для clearButton. По нажатие, значение в displayLabel должно сбрасываться в “0"
  * Добавить UISwipeGestureRecognizer на displayLabel. При swipe должно происходить стирание последней цифры 
  * Постараться реализовать обработку нажатия dotButton

TASK 1.5
 * Добавить экран “О нас” используя .xib, содержащию информацию о разработчике
 * Добавить UIBarButtonItem на navigationItem и обработчик, по нажатию - происходит отображения экрана “О нас” в стэке
 * Добавить экран “Условия использования и лицензии” используя .xib, содержащию текстовую информацию о лицензии на ПО https://ru.wikipedia.org/wiki/Лицензия_MIT
 * Добавить UIButton и обработчик, по нажатию - происходит отображения экрана “Условия использования и лицензии” модально

TASK 2.0 
 * Расширить реализацию из предыдущих лекций. Реализовать модель для калькулятора, как показано было на лекциях:
 * Добавить операции: %(остаток от деления), √(корень), ±(смена знака), +(сложение), -(вычитание), *(умножение), /(деление)	
 * Кнопка С. Функция сброса - очищает все, получаем состояние, которое было при старте приложени
 * Повтор операции по нажатию на “=“
 * Предусмотреть многократное нажатие на бинарную операцию(операция с двумя операндами), например 3+++3 = 6
 * Предусмотреть корректное вычисление для операций, напр. 9+-√ = 3, 3+6√=3
 * Вычисления должны производится над дробными значениями, в поле displayLabel должно отображаться значение с максимум 6 цифрами после плавающей точки, для этих целей, ознакомьтесь с  NSNumberFormatter
 * Используйте delegate для уведомления о, изменениях значения result(displayValue)
 * Калькулятор должен сообщать об ошибках, например, 3/0, √-3, простым выводом на экран текста “Error”, приветствуется более детальное сообщение об ошибке “Деление на ноль”, “Корень из отрицательного значения" 

TASK 2.5
 * UI калькулятора. UI не должен быть беспорядочен, все элементы должны быть выровнены, присутствовать отступы.
 * Добавить constraints. Приложение должно “приятно” выглядеть на всех iphone-устройствах
 * Должна присутствовать поддержка landscape orientation
 * Используя stackView, предусмотреть перемещение операций(кнопок) в другое местоположение, например +,-,*,/  слева от digit-кнопок, если они были справа

TASK 3.0 
 * Добавить поддержку систем счисления
 * Расширить возможности калькулятора, должны присутствовать системы счисления: DEC, BIN, OCT, HEX
 * Для каждой из системы предусмотреть disable кнопок в соответствии со системой счисления
 * UI должен быть привлекателен