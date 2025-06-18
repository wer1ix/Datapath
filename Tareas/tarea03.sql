----------- Relacionados con nuesta DB usando como ejemplo
----------- la empresa Zillow


----------- Trigger 
-- Cuando una propiedad se vende 
-- (nueva fila en transactions), se actualiza 
-- automáticamente su status a "vendida".

CREATE TRIGGER trg_sold_property
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    UPDATE properties
    SET status = 'vendida'
    WHERE property_id = NEW.property_id;

----------- SP (Stored Procedure)
-- Prorcedimiento para publicar una nueva propiedad

CREATE PROCEDURE sp_publish_property (
    IN p_title VARCHAR(255),
    IN p_description TEXT,
    IN p_price DECIMAL(12,2),
    IN p_owner_id INT
)
BEGIN
    INSERT INTO properties (title, description, price, owner_id)
    VALUES (p_title, p_description, p_price, p_owner_id);

----------- Función
-- Función para calcular las propiedades que ha 
-- vendido un usuario

CREATE FUNCTION fn_properties_sold_by_user(p_user_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    -- Variable para guardar el total
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM transactions t
    JOIN properties p ON t.property_id = p.property_id
    WHERE p.owner_id = p_user_id;

    RETURN total;

----------- Vista
-- Vista para mostrar propiedades disponibles con 
-- información del dueño

CREATE VIEW view_available_properties AS
SELECT 
    p.property_id,
    p.title,
    p.price,
    u.name AS owner_name,
    u.email AS owner_email
FROM properties p
JOIN users u ON p.owner_id = u.user_id
WHERE p.status = 'disponible';