--Знайди артистів, чиї альбоми не містять жодного треку, який було куплено хоча б один раз. 
--Які артисти "не приносять грошей взагалі"
--Для кожного артиста перевіряємо, чи існує хоч один куплений трек цього артиста
--Використовуємо NOT EXISTS з корельованим підзапитом або JOIN 
CREATE OR REPLACE VIEW vw_artist_loser AS
SELECT a.artist_id, a.name AS artist_name
FROM artist a
WHERE EXISTS (
    SELECT 1
    FROM album al
    WHERE al.artist_id = a.artist_id
)
AND NOT EXISTS (
    SELECT 1
    FROM album al
    JOIN track t USING(album_id)
    JOIN invoice_line il USING(track_id)
    WHERE al.artist_id = a.artist_id
);

SELECT * FROM vw_artist_loser