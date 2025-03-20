Create table Books(
id serial primary key,
title VARCHAR(255) not null,
author VARCHAR(255) not null,
published_year integer check (published_year > 0),
genre VARCHAR(255)
);

Create table Users (
id serial primary key,
full_name VARCHAR(255) not null,
phone integer not null,
email VARCHAR(50) unique not null
);

Create table Librarians (
id serial primary key,
full_name VARCHAR(255) not null,
phone integer not null,
email VARCHAR(50) unique not null
);

Create table Borrowings(
id serial primary key,
user_id integer not null,
book_id integer not null,
borrow_date date not null,
return_date date,
foreign key(user_id) references Users(id) on delete cascade,
foreign key(book_id) references Books(id) on delete cascade
);

Create table Reservations(
id serial primary key,
user_id integer not null,
book_id integer not null,
reservation_date date not null,
foreign key(user_id) references Users(id) on delete cascade,
foreign key(book_id) references Books(id) on delete cascade
);

Create table Fines(
id serial primary key,
user_id integer not null,
amount decimal(10,2) check (amount >= 0),
status VARCHAR(50) not null check(status in ('Paid', 'Unpaid')),
foreign key(user_id) references Users(id) on delete cascade
);



