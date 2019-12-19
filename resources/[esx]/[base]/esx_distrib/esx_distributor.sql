CREATE TABLE `distributor` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  
  PRIMARY KEY (`id`)
);

INSERT INTO `distributor` (name, item, price) VALUES
('Distributor','pepsi',10),
('Distributor','sprite',10),
('Distributor','coca',15),
('Distributor','7up',10),
('Distributor','fanta',15),
('Distributor','orangina',15);


INSERT INTO `items` (`id`, `name`, `label`, `limit`, `height`, `rare`, `can_remove`) VALUES
('pepsi', 'Pepsi', -1, 1, 0, 1),
('sprite', 'Sprite', -1, 0, 0, 1),
('coca', 'Coca-Cola', -1, 0, 0, 1),
('7up', '7up', -1, 0, 0, 1),
('fanta', 'Fanta', -1, 0, 0, 1),
('orangina', 'Orangina', -1, 0, 0, 1);