-- DROP DATABASE cinema_db;

DROP TABLE cinema, hall, seat, booking, movie, genre, movie_join_genre, ticket;

-- CREATE DATABASE cinema_db;

-- \connect cinema_db

CREATE TABLE cinema (
    cinema_id serial PRIMARY KEY,
    address varchar(100) NOT NULL,
    phone numeric(11) NOT NULL,
    name varchar(50) NOT NULL
);

CREATE TABLE hall (
    hall_id serial PRIMARY KEY,
    cinema_id int REFERENCES cinema(cinema_id) NOT NULL,
    count_seats smallint NOT NULL,
    name varchar(50) NOT NULL,
    image_format varchar(10) NOT NULL,
    hall_format varchar(10) NOT NULL,
    CHECK (image_format IN ('2D', '3D')),
    CHECK (hall_format IN ('usual', 'VIP', 'IMAX', 'D-box'))
);

CREATE TABLE seat (
    seat_id serial PRIMARY KEY,
    hall_id int REFERENCES hall(hall_id) NOT NULL,
    row smallint NOT NULL,
    col smallint NOT NULL,
    UNIQUE (hall_id, row, col)
);

CREATE TABLE booking (
    booking_code int PRIMARY KEY,
    email varchar(100),
    used boolean DEFAULT FALSE,
    total_price numeric(9, 2) DEFAULT 0,
    CHECK (email LIKE ('%@%.%'))
);

CREATE TABLE movie (
    movie_id serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    description text DEFAULT 'Нет описания',
    premier date NOT NULL,
    director varchar(50) NOT NULL,
    rating numeric(2, 1) DEFAULT 0.0,
    interval_time interval NOT NULL
);

CREATE TABLE genre (
    genre_id serial PRIMARY KEY,
    name varchar(50) NOT NULL
);

CREATE TABLE movie_join_genre (
    movie_join_genre_id serial PRIMARY KEY,
    movie_id int REFERENCES movie(movie_id) NOT NULL,
    genre_id int REFERENCES genre(genre_id) NOT NULL
);

CREATE TABLE ticket (
    ticket_id serial PRIMARY KEY,
    movie_id int REFERENCES movie(movie_id) NOT NULL,
    seat_id int REFERENCES seat(seat_id) NOT NULL,
    booking_code int REFERENCES booking(booking_code),
    session_date date NOT NULL,
    session_time time NOT NULL,
    status varchar(50) NOT NULL,
    price numeric(9, 2) NOT NULL,
    UNIQUE (movie_id, session_date, session_time, seat_id),
    CHECK (status IN ('Занято', 'Свободно')),
    CHECK (price >= 0)
);


-- INSERT INTO cinema (address, phone, name)
--     VALUES ('ул. Юных ленивцев, д. 21', 88005553535, 'CinemaStar');
--
-- INSERT INTO hall (cinema_id, count_seats, name, image_format, hall_format)
--     VALUES (1, 9, 'Альфа', '2D', 'VIP');
-- INSERT INTO hall (cinema_id, count_seats, name, image_format, hall_format)
--     VALUES (1, 12, 'Бета', '3D', 'D-box');
--
-- INSERT INTO seat (hall_id, row, col)
--     VALUES (1, 1, 1)




