USE `essentialmode`;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('banana', 'Banane', -1, 0, 1),
	('exta', 'Extasy', -1, 0, 1),
	('kitheal', 'Pansement', -1, 0, 1),
	('tire', 'Bandage', -1, 0, 1),
	('sanitizer', 'Désinfectant', -1, 0, 1)
;


INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_para','Parachute',1),
;

INSERT INTO `addon_account_data` (id, account_name, money, owner) VALUES
  ('','society_para','0',''),
;

INSERT INTO `jobs` (name, label) VALUES
  ('para','Parachutisme'),
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('para',0,'recrue','Recrue',12,'{}','{}'),
  ('para',1,'novice','Novice',24,'{}','{}'),
  ('para',2,'experimente','Experimente',36,'{}','{}'),
  ('para',3,'chief','Chef d\'équipe',48,'{}','{}'),
  ('para',4,'boss','Patron',0,'{}','{}')
;

-------------------------------------------------------------

INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_wash','Lavage',1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('wash','Lavage Auto')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('wash',0,'boss','Recrue',0,'{}','{}'),

;
