CREATE DATABASE ogrdb;
CREATE USER 'ogrdb'@'%' IDENTIFIED BY 'ogrdb';
GRANT ALL PRIVILEGES ON ogrdb.* TO 'ogrdb'@'%';
USE ogrdb;
CREATE DATABASE digby;
CREATE USER 'digby'@'%' IDENTIFIED BY 'digby';
GRANT ALL PRIVILEGES ON digby.* TO 'digby'@'%';
USE digby;