CREATE TABLE IF NOT EXISTS settinginfo(
  setting_id int(11) NOT NULL AUTO_INCREMENT,
  message varchar(64) CHARACTER SET utf8 NOT NULL,
  version varchar(64) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (setting_id)
);

