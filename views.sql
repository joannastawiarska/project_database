CREATE VIEW client_counter AS (
SELECT max(clients.count)
		FROM
			(SELECT count(r.client_ID) AS count
				FROM rent AS r 
				GROUP BY r.client_ID) AS clients
);

CREATE VIEW history_of_rents AS (
 SELECT 
    c.name AS `NAME`, 
    c.surname AS `SURNAME`, 
    r.date_rent AS `DATE RENT`, 
    r.date_return AS `DATE RETURN`,
    ca.make AS `AUTO'S MAKE`
 FROM 
    client as c JOIN rent as r ON c.client_ID = r.client_ID 
 JOIN 
    car as ca ON c.client_ID = r.client_ID
);

CREATE VIEW managers AS 
(SELECT
	name AS `NAME`,
	surname AS `SURRNAME`,
	date_birth AS `DATE OF BIRTH`
FROM 
	worker
WHERE 
	position_ID = 2
);

CREATE VIEW rents_2017 AS
(SELECT
	r.client_ID `CLIENT_ID`, 
    client.name AS `NAME`, 
    client.surname AS `SURNAME`, 
    ROUND(SUM(r.cost), 2) AS `SUM`
FROM 
	rent as r
JOIN 
	client 
ON 
	client.client_ID = r.client_ID AND YEAR(r.date_rent) = 2017
GROUP BY 
	r.client_ID
ORDER BY SUM DESC
);


