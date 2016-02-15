CREATE TABLE IF NOT EXISTS categoryinfo (
  id_category int(11) NOT NULL AUTO_INCREMENT,
  name_category varchar(64) CHARACTER SET utf8 NOT NULL,
  menu_category varchar(64) CHARACTER SET utf8 NOT NULL,

  created_at datetime NOT NULL,
  PRIMARY KEY (id_category)
);

