CREATE TABLE songs (
	id INTEGER PRIMARY KEY,
	title TEXT,
	album_id INTEGER
);

CREATE TABLE albums (
	id INTEGER PRIMARY KEY,
	names TEXT,
	artist_id INTEGER
);

CREATE TABLE artists (
	id INTEGER PRIMARY KEY,
	name TEXT
);


INSERT INTO artists (name) VALUES
("Red Hot Chili Peppers"),
("Rolling Stones"),
("Led Zeppelin");


INSERT INTO albums (names, artist_id) VALUES
-- Red Hot Chili Peppers
("Blood Sugar Sex Magik", 1),
("One Hot Minute", 1),
("Californication", 1),

-- Rolling Stones
("Aftermath", 2),
("Beggar's Banquet", 2),
("Let it Bleed", 2),

-- Led Zeppelin
("Led Zeppelin", 3),
("Led Zeppelin II", 3),
("Led Zeppelin III", 3);


INSERT INTO songs (title, album_id) VALUES
-- Blood Sugar Sex Magik Red Hot Chili Peppers
("Suck My Kiss", 1),
("Give It Away Now", 1),
("Funky Monks", 1),

-- One Hot Minute Red Hot Chili Peppers
("My Friends", 2),
("Aeroplane", 2),
("Warped", 2),

-- Californication Red Hot Chili Peppers
("Scar Tissue", 3),
("Californication", 3),
("Otherside", 3),

-- Aftermath Rolling Stones
("Paint It, Black", 4),
("Under My Thumb", 4),
("High and Dry", 4),

-- Beggar's Banquet Rolling Stones
("Sympthy For The Devil", 5),
("Street Fighting Man", 5),
("Factory Girl", 5),

-- Let it Bleed Rolling Stones
("Gimme Shelter", 6),
("Let it Bleed", 6),
("Monkey Man", 6),

-- Led Zeppelin, Led Zeppelin
("Good Times Bad Times", 7),
("Babe I'm Gunna Leave You", 7),
("I Can't Quit You Baby", 7),

-- Led Zeppelin, Led Zeppelin II
("Whole Lotta Love", 8),
("What Is and What Should Never Be", 8),
("Ramble On", 8),

-- Led Zeppelin, Led Zeppelin III
("Immigrant Song", 9),
("Since I've Been Loving You", 9),
("Friends", 9);