-- a. вибірка всіх даних із певної таблиці
-- 1
select * from books;
-- 2
select * from users;
-- 3
select * from borrowings;

-- b. логічні оператори
-- 4
select * from books where published_year > 2000;
-- 5
select * from users where full_name like 'a%';
-- 6
select * from fines where amount > 50 and status = 'unpaid';

-- c. count(), sum(), avg(), min(), max()
-- 7
select count(*) from users;
-- 8
select avg(amount) from fines where status = 'unpaid';
-- 9
select sum(amount) from fines;
-- 10
select min(published_year) from books;
-- 11
select max(published_year) from books;

-- d. join (inner, left, right, full, cross, self)
-- 12
select u.full_name, b.title, br.borrow_date
from borrowings br
join users u on br.user_id = u.id
join books b on br.book_id = b.id;
-- 13
select u.full_name, b.title, br.borrow_date
from users u
left join borrowings br on u.id = br.user_id
left join books b on br.book_id = b.id;
-- 14
select u.full_name, br.borrow_date, b.title
from borrowings br
right join users u on br.user_id = u.id
right join books b on br.book_id = b.id;
-- 15
select u.full_name, b.title, br.borrow_date
from users u
full join borrowings br on u.id = br.user_id
full join books b on br.book_id = b.id;
-- 16
select a.full_name, b.full_name
from users a, users b
where a.id <> b.id;

-- e. підзапити (subqueries)
-- 17
select * from users where id in (select user_id from borrowings where return_date > '2024-08-26');
-- 18
select * from books where id > 3 and id in (select book_id from borrowings);
-- 19
select full_name from users where exists (select * from fines where users.id = fines.user_id and fines.amount > 7);

-- f. операції над множинами
-- 20
select id, full_name from users
union
select id, full_name from librarians;
-- 21
select genre from books where author = 'emily brown'
intersect
select genre from books where published_year > 2000;
-- 22
select full_name from users
except
select full_name from users where phone = '415791';

-- g. common table expressions (cte)
-- 23
with ovbooks as (
	select user_id, book_id, return_date
	from borrowings
	where return_date < now()
)
select u.full_name, b.title, o.return_date
from ovbooks o
join users u on o.user_id = u.id
join books b on o.book_id = b.id;

-- j. віконні функції (window functions)
-- 24
select user_id, count(*) over(partition by user_id) as borrow_count
from borrowings;
-- 25
select id, title, published_year,
		rank() over (order by published_year desc) as rank
from books;
-- 26
select user_id, borrow_date,
		lag(borrow_date) over(partition by user_id order by borrow_date) as pr_borrow
from borrowings;
-- 27
select user_id, amount,
		sum(amount) over(partition by user_id order by id rows between unbounded preceding and current row) as running_total
from fines;

-- k. додаткові запити
-- 28. кількість книг у кожному жанрі
select genre, count(*) from books group by genre;
-- 29. топ-5 користувачів із найбільшою кількістю неоплачених штрафів
select users.full_name, count(fines.id) as unpaid_fines
from fines
join users on fines.user_id = users.id
where fines.status = 'unpaid'
group by users.full_name
order by unpaid_fines desc
limit 5;
-- 30. користувачі з простроченими книгами
select users.full_name, books.title, borrowings.return_date
from borrowings
join users on borrowings.user_id = users.id
join books on borrowings.book_id = books.id
where borrowings.return_date < now();
-- 31. загальна сума всіх штрафів
select sum(amount) from fines;
-- 32. користувачі, які взяли більше 5 книг
select user_id, count(*) as borrow_count
from borrowings
group by user_id
having count(*) > 5;
-- 33. найпопулярніша книга
select book_id, count(*) as borrow_count
from borrowings
group by book_id
order by borrow_count desc
limit 1;
-- 34. книги, які рідко брали
select book_id, count(*) as borrow_count
from borrowings
group by book_id
having count(*) < 3;
-- 35. користувач, який позичав найбільше книг
select full_name
from users
where id in (
    select user_id from borrowings
    group by user_id
    having count(*) = (select max(borrow_count) from (select count(*) as borrow_count from borrowings group by user_id) as subquery)
);
-- 36. користувачі, які жодного разу не брали книг
select full_name from users
where id not in (select distinct user_id from borrowings);
-- 37. найбільш штрафований користувач
select full_name from users
where id in (
    select user_id from fines
    group by user_id
    having sum(amount) = (select max(total_fines) from (select sum(amount) as total_fines from fines group by user_id) as subquery)
);
-- 38. середня кількість запозичень на користувача
select avg(borrow_count) from (
    select user_id, count(*) as borrow_count
    from borrowings
    group by user_id
) as avg_borrows;
-- 39. знайти найменш популярний жанр
select genre from books
where genre in (
    select genre from books
    group by genre
    order by count(*) asc
    limit 1
);
-- 40. загальна кількість виданих книг
select count(*) from borrowings;
-- 41. знайти користувачів, які взяли книги в останні 7 днів
select distinct user_id from borrowings where borrow_date >= now() - interval '7 days';
-- 42. підрахунок книг кожного автора
select author, count(*) as book_count from books group by author;
-- 43. сума штрафів по місяцях
select date_trunc('month', issue_date) as month, sum(amount) as total_fines from fines group by month;
