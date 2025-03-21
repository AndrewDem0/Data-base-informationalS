------------------------  Завдання №1  -------------------------------

-- Створення Типу Enum 
create type book_status as enum('new','used','unknown');

-- Додавання Нового Стовпця В Таблицю Books
alter table books add column status book_status default 'unknown';

-- Запити Для Перевірки Взаємодії Таблиць
select * from books;

-- Перевірка Group By Та Пошук По Status
select status, count(*) as b_count
from books
group by status;

-- Перевірка Join
select u.full_name, b.title, b.status
from borrowings bor
join users u on bor.user_id = u.id
join books b on bor.book_id = b.id
order by b.status;

-- Delete
delete from books where id = 5; 

-- Insert
insert into books (title, author, published_year, genre, status)  
values ('нова книга', 'автор книги', 2024, 'фантастика', 'new');

------------------------  Завдання №2  -------------------------------

-- Створення Функції Яка Розділяє Ініціали Автора
create or replace function fn_author_initials()
returns table (
    full_name varchar(55),
    first_name varchar(55),
    last_name varchar(55)
) 
as
$$
begin
    return query
    select 
        author::varchar(55) as full_name,
        split_part(author, ' ', 1)::varchar(55) as first_name,
        split_part(author, ' ', 2)::varchar(55) as last_name
    from books;
end;
$$
language plpgsql;

-- Тестування Відповідної Функції
select full_name from fn_author_initials() where last_name = 'brown';

------------------------  Завдання №3  -------------------------------

-- Створення Бази Даних Для Логів
create table tabel_logs_books(
    log_id serial primary key,
    book_id int,
    log_message varchar(255),
    log_date timestamp default current_timestamp
);

-- Перевірка Наявності Таблиці
select * from tabel_logs_books;

-- Створення Функції Для Тригера
create or replace function log_books_changes()
returns trigger
as
$$
begin
    -- Insert
    if tg_op = 'INSERT' then
    insert into tabel_logs_books(book_id, log_message, log_date)
    values (new.id, 'Inserted book: ' || new.title, current_timestamp);
    -- Update
    elsif tg_op = 'UPDATE' then
    insert into tabel_logs_books(book_id, log_message, log_date)
    values (new.id, 'Updated book: ' || new.title, current_timestamp);
    -- Delete
    elsif tg_op = 'DELETE' then
    insert into tabel_logs_books(book_id, log_message, log_date)
    values (old.id, 'Deleted book: ' || old.title, current_timestamp);
    -- Завершення Умовного Оператора If
    end if;

    return null; -- Тригери AFTER Не Змінюють Запис
end;
$$
language plpgsql;

-- Умови Активації І Створення Тригера 
create trigger trg_books
after insert or update or delete
on books
for each row
execute function log_books_changes();

-- Перевірка Insert
insert into books (title, author, published_year, genre, status)
values ('test book 2', 'john doe', 2024, 'fiction', 'new');

-- Перевірка Update
update books set title = 'updated test book 2' where title = 'test book 2';

-- Перевірка Delete
delete from books where title = 'updated test book 2';

select * from tabel_logs_books;
