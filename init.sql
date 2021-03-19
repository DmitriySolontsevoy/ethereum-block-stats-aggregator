CREATE TABLE IF NOT EXISTS blocknumbers (
	id uuid PRIMARY KEY NOT NULL,
	blocknumber int8 NOT NULL,
	recordtime int8 NOT NULL
);

CREATE TABLE IF NOT EXISTS blocktimes (
	id uuid PRIMARY KEY NOT NULL,
	blockid uuid NOT NULL,
	blocktime int8 NOT NULL,
	recordtime int8 NOT NULL,
	FOREIGN KEY (blockid)
		REFERENCES blocknumbers (id)
);
