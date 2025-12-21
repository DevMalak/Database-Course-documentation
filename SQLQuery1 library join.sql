use library1;

----Display library ID, name, and the name of the manager------

select l.library_id, l.name, s.fullname
from library l
join staff s on l.library_id = s.library_id
where s.position = 'Manager';

-----Display library names and the books available in each one-------

select l.name, b.title
from library l
INNER JOIN book b on l.library_id = b.library_id;

---- Display all member data along with their loan history-----

select m.*, l.loan_id, l.loandate, l.status
from member m
LEFT JOIN loan l on m.member_id = l.member_id;

---- Display all books located in 'Zamalek' or 'Downtown'-----

select b.title, l.location
from book b
INNER JOIN library l on b.library_id = l.library_id
where l.location in ('Zamalek','Downtown'); -----empty because no exist in data---

select * from library;

---- Display all books whose titles start with 'T'---------

select book_id, title
from book
where title like 'T%';  -----empty because no exist in data----
select*from book;

----List members who borrowed books priced between 100 and 300 LE-----
select distinct m.fullname, b.title, b.price
from member m
INNER JOIN loan l on m.member_id = l.member_id
INNER JOIN book b on l.book_id = b.book_id
where b.price between 100 and 300;

----Retrieve members who borrowed and returned books titled 'The Alchemist'-----

select distinct m.fullname
from member m
INNER JOIN loan l on m.member_id = l.member_id
INNER JOIN book b on l.book_id = b.book_id
where b.title = 'The Alchemist' and l.status = 'Returned';

-----Find all members assisted by librarian "Sarah Fathy"---

create table loan (
    loan_id int identity(1,1) primary key,
    loandate date not null,
    duedate date not null,
    returndate date,
    status varchar(20) not null default 'Issued'
        check (status in ('Issued','Returned','Overdue')),
    member_id int not null,
    book_id int not null,
    staff_id int null,  -- added here

    foreign key (member_id) references member(member_id) on delete cascade on update cascade,
    foreign key (book_id) references book(book_id) on delete cascade on update cascade,
    foreign key (staff_id) references staff(staff_id) on delete set null on update cascade
);

select distinct m.fullname
from member m
inner join loan l on m.member_id = l.member_id
inner join staff s on l.staff_id = s.staff_id
where s.fullname = 'Sarah Fathy';

select * from staff where fullname = 'Sarah Fathy';

----- Display each member’s name and the books they borrowed, ordered by book title-----

select m.fullname, b.title
from member m
INNER JOIN loan l on m.member_id = l.member_id
INNER JOIN book b on l.book_id = b.book_id
order by b.title;

--- For each book located in 'Cairo Branch', show title, library name, manager, and shelf info---

select b.title, l.name, s.fullname, b.shelflocation
from book b
INNER JOIN library l on b.library_id = l.library_id
INNER JOIN staff s on l.library_id = s.library_id
where l.name = 'Cairo Branch' and s.position = 'Manager';----empty no library cairo branch---

----Display all staff members who manage libraries----

select s.staff_id, s.fullname, l.name
from staff s
INNER JOIN library l on s.library_id = l.library_id
where s.position = 'Manager';

---Display all members and their reviews, even if some didn’t submit any review yet-----
select m.fullname, r.review_id, r.rating, r.comments
from member m
LEFT JOIN review r on m.member_id = r.member_id;





















5. Display all books whose titles start with 'T'.
6. List members who borrowed books priced between 100 and 300 LE.
7. Retrieve members who borrowed and returned books titled 'The Alchemist'.
8. Find all members assisted by librarian "Sarah Fathy".
9. Display each member’s name and the books they borrowed, ordered by book title.
10. For each book located in 'Cairo Branch', show title, library name, manager, and shelf info.
11. Display all staff members who manage libraries.
12. Display all members and their reviews, even if some didn’t submit any review yet
