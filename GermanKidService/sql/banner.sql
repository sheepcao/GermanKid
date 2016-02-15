CREATE TABLE IF NOT EXISTS bannerinfo(
  id int(11) NOT NULL AUTO_INCREMENT,
  banner_index varchar(64) CHARACTER SET utf8 NOT NULL,
  product_name varchar(64) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY (banner_index)
);

