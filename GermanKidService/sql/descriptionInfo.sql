CREATE TABLE IF NOT EXISTS descriptioninfo (
  id int(11) NOT NULL AUTO_INCREMENT,
  content varchar(100) CHARACTER SET utf8 NOT NULL,
  introduct_index varchar(64) CHARACTER SET utf8 NOT NULL,
  related_product varchar(100) CHARACTER SET utf8 NOT NULL,

  created_at datetime NOT NULL,
  PRIMARY KEY (id)
);

