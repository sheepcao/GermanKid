CREATE TABLE IF NOT EXISTS productinfo (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(64) CHARACTER SET utf8 NOT NULL,
  introduct varchar(100) CHARACTER SET utf8 NOT NULL,
  price varchar(64) CHARACTER SET utf8 NOT NULL,
  discount varchar(64) CHARACTER SET utf8 NOT NULL,
  image_count varchar(64) CHARACTER SET utf8 NOT NULL,
  like_count varchar(64) CHARACTER SET utf8 NOT NULL,
  url varchar(100) CHARACTER SET utf8 NOT NULL,
  category varchar(64) CHARACTER SET utf8 NOT NULL,
  menu varchar(64) CHARACTER SET utf8 NOT NULL,

  created_at datetime NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY (name)
);

