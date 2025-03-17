# Data-base-informationalS

## Опис бізнес-процесу (формат .txt):

**1. Загальний опис**
Бібліотечна система призначена для автоматизації процесів обліку книг, реєстрації користувачів, видачі та повернення літератури. Вона включає кілька основних сутностей: книги, користувачі, бібліотекарі та операції (видача, повернення, бронювання).

**2. Основні сутності та їхня взаємодія**

- **Книги**: Містять інформацію про назву, автора, рік видання, жанр та унікальний ідентифікатор (ISBN). Кожна книга може мати кілька екземплярів.
- **Користувачі**: Зареєстровані читачі, які можуть брати книги в тимчасове користування. Включають персональні дані: ім'я, прізвище, контактну інформацію.
- **Бібліотекарі**: Відповідальні за управління бібліотекою, внесення нових книг, контроль за термінами повернення та ведення обліку операцій.
- **Операції**: Дії, пов'язані з видачею книг, поверненням, бронюванням та штрафами за прострочене повернення.

**3. Ключові бізнес-процеси**

1. **Реєстрація користувача**:
   - Користувач надає персональні дані.
   - Адміністратор створює запис у системі та надає унікальний ідентифікатор.

2. **Додавання нових книг**:
   - Бібліотекар вносить інформацію про книгу.
   - Кожен примірник отримує унікальний ідентифікаційний номер.

3. **Оформлення видачі книги**:
   - Користувач обирає книгу.
   - Бібліотекар перевіряє наявність та оформлює видачу.
   - Фіксується дата видачі та встановлюється крайній термін повернення.

4. **Повернення книги**:
   - Користувач повертає книгу.
   - Бібліотекар перевіряє стан книги.
   - Якщо повернення прострочене, система нараховує штраф.

5. **Бронювання книги**:
   - Користувач може зарезервувати книгу, якщо всі екземпляри видані.
   - Після повернення книги бібліотекар повідомляє користувача про можливість її отримання.

6. **Облік штрафів**:
   - При простроченні повернення система автоматично розраховує суму штрафу.
   - Оплата здійснюється у бібліотеці або через онлайн-систему.

**4. Використання бази даних**
База даних забезпечує зберігання інформації про всі книги, користувачів та операції. Основні таблиці:

- **Books** (Книги) – містить інформацію про всі книги в бібліотеці.
- **Users** (Користувачі) – реєстрація читачів та їхні контактні дані.
- **Librarians** (Бібліотекарі) – список співробітників бібліотеки.
- **Borrowings** (Видачі) – історія видач та повернень книг.
- **Reservations** (Бронювання) – записи про зарезервовані книги.
- **Fines** (Штрафи) – облік заборгованостей та сплачених штрафів.

**5. Висновок**
Автоматизована бібліотечна система значно спрощує управління літературою, облік користувачів та контроль за поверненням книг. Вона зменшує кількість помилок, покращує швидкість обробки запитів та забезпечує прозорість обліку літературних ресурсів.

## Реалізація бази даних та користувачів (формат .sql).
![image](https://github.com/user-attachments/assets/0d58207e-6ac6-4884-8ea6-f8945f72fbfc)

## Файли з виконанням завдань пов'язаних з запитами:

1. ER-діаграма у файлі __er_diagram.pdf.__  
2. Скрипти створення бази даних у файлі __create_db.sql.__  
3. Скрипти наповнення бази даних у папці __insert_data.sql__ з відповідними назвами таблиць.  
4. SQL-запити для аналізу даних у файлі __select_queries.sql.__  
