DROP DATABASE cinema_db;

CREATE DATABASE cinema_db;

\connect cinema_db

CREATE TABLE cinema (
    cinema_id serial PRIMARY KEY,
    address varchar(100) NOT NULL,
    phone numeric(11) NOT NULL,
    name varchar(50) NOT NULL
);

CREATE TABLE hall (
    hall_id serial PRIMARY KEY,
    cinema_id int REFERENCES cinema(cinema_id),
    count_seats smallint NOT NULL,
    name varchar(50) NOT NULL,
    format varchar(50) NOT NULL
);

CREATE TABLE seat (
    seat_id serial PRIMARY KEY,
    hall_id int REFERENCES hall(hall_id),
    price int NOT NULL,
    row int NOT NULL,
    col int NOT NULL,
    CHECK (price >= 0),
    UNIQUE (hall_id, row, col)
);

CREATE TABLE booking (
    booking_code int PRIMARY KEY,
    email varchar(100),
    CHECK (email LIKE ('%@%.%'))
);

CREATE TABLE movie (
    movie_id serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    description text DEFAULT 'Нет описания',
    premier date NOT NULL,
    director varchar(50) NOT NULL,
    rating numeric(2, 1) DEFAULT 0.0,
    time interval NOT NULL
);

CREATE TABLE genre (
    genre_id serial PRIMARY KEY,
    name varchar(50) NOT NULL
);

CREATE TABLE movie_join_genre (
    movie_join_genre_id serial PRIMARY KEY,
    movie_id int REFERENCES movie(movie_id),
    genre_id int REFERENCES genre(genre_id)
);

CREATE TABLE ticket (
    ticket_id serial PRIMARY KEY,
    movie_id int REFERENCES movie(movie_id),
    date date NOT NULL,
    time time NOT NULL,
    seat_id int REFERENCES seat(seat_id),
    status varchar(50) NOT NULL,
    booking_code int REFERENCES booking(booking_code),
    UNIQUE (movie_id, date, time, seat_id),
    CHECK (status IN ('Занято', 'Свободно'))
);

