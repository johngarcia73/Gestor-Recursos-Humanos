:- dynamic fecha_separada/3.

% Obtener la fecha actual
fecha_actual(Fecha) :-
    get_time(Timestamp),
    stamp_date_time(Timestamp, DateTime, 'UTC'),
    format_time(atom(Fecha), '%Y-%m-%d %H:%M:%S', DateTime).

% Obtener la fecha actual en formato 'YYYY-MM-DD'
fecha_separada(Day, Month, Year) :-
    get_time(Timestamp),
    stamp_date_time(Timestamp, DateTime, 'UTC'),
    format_time(atom(_), '%d-%m-%Y', DateTime),
    date_time_value(month, DateTime, Month),
    date_time_value(day, DateTime, Day),
    date_time_value(year, DateTime, Year).

