 DROP DATABASE IF EXISTS cdsshopdb;
 
 CREATE DATABASE IF NOT EXISTS cdsshopdb;
 
 USE cdsshopdb;

CREATE TABLE `cd` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `price` double NOT NULL,
  `filename` varchar(200) NOT NULL,
  `singer` varchar(200) NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE cd;

INSERT INTO `cd` (`name`, `price`, `filename`, `singer`,`description`) VALUES
('Antexa', 8, 'images/antexa.jpg', 'Sakis Rouvas','Ο Σάκης Ρουβάς (πραγματικό όνομα: Αναστάσιος Ρουβάς) (Κέρκυρα, 5 Ιανουαρίου 1972) είναι Έλληνας τραγουδιστής, συνθέτης, επιχειρηματίας και πρώην αθλητής του άλματος επί κοντώ. Από πολύ μικρή ηλικία ασχολήθηκε με τον στίβο, κατακτώντας αρκετά μετάλλια ως μέλος των Ελληνικών Εθνικών Ομάδων παίδων και εφήβων τη δεκαετία του 80. Η μουσική του σταδιοδρομία ξεκίνησε το 1991, σε ηλικία 19 ετών, ως ποπ ερμηνευτής ενώ συνδύαζε τραγούδι, χορογραφία και σύνθεση του κομματιού.Ο Ρουβάς είχε κερδίσει 15 βραβεία στα «Μουσικά Βραβεία Ποπ Κορν», 6 στα «Μουσικά Βραβεία Αρίων», 26 στα «Mad Video Music Awards», 1 στα «MTV Europe Music Awards» (Ευρωπαϊκά Μουσικά Βραβεία MTV) και 1 στα «Παγκόσμια Μουσικά Βραβεία» (World Music Awards). Έχει ανακηρυχθεί «Άντρας της χρονιάς», το περιοδικό Down Town τού έδωσε τον τίτλο «Καλύτερος διασκεδαστής της δεκαετίας», ενώ το Forbes (Φορμπς) τον κατέταξε στην 3η θέση με τους πιο σημαντικούς καλλιτέχνες στην Ελλάδα. Τα αδέλφια του είναι ο Απόστολος Ρουβάς, ο Βασίλης Ρουβάς και ο Νίκος Ρουβάς. '),
('Ela mou', 8.5, 'images/elamou.jpg', 'Sakis Rouvas','Ο Σάκης Ρουβάς (πραγματικό όνομα: Αναστάσιος Ρουβάς) (Κέρκυρα, 5 Ιανουαρίου 1972) είναι Έλληνας τραγουδιστής, συνθέτης, επιχειρηματίας και πρώην αθλητής του άλματος επί κοντώ. Από πολύ μικρή ηλικία ασχολήθηκε με τον στίβο, κατακτώντας αρκετά μετάλλια ως μέλος των Ελληνικών Εθνικών Ομάδων παίδων και εφήβων τη δεκαετία του 80. Η μουσική του σταδιοδρομία ξεκίνησε το 1991, σε ηλικία 19 ετών, ως ποπ ερμηνευτής ενώ συνδύαζε τραγούδι, χορογραφία και σύνθεση του κομματιού.Ο Ρουβάς είχε κερδίσει 15 βραβεία στα «Μουσικά Βραβεία Ποπ Κορν», 6 στα «Μουσικά Βραβεία Αρίων», 26 στα «Mad Video Music Awards», 1 στα «MTV Europe Music Awards» (Ευρωπαϊκά Μουσικά Βραβεία MTV) και 1 στα «Παγκόσμια Μουσικά Βραβεία» (World Music Awards). Έχει ανακηρυχθεί «Άντρας της χρονιάς», το περιοδικό Down Town τού έδωσε τον τίτλο «Καλύτερος διασκεδαστής της δεκαετίας», ενώ το Forbes (Φορμπς) τον κατέταξε στην 3η θέση με τους πιο σημαντικούς καλλιτέχνες στην Ελλάδα. Τα αδέλφια του είναι ο Απόστολος Ρουβάς, ο Βασίλης Ρουβάς και ο Νίκος Ρουβάς. '),
('Anapantites kliseis', 5.5, 'images/anapantiteskliseis.jpg', 'Elena Paparizou','Η Έλενα Παπαρίζου (Μπορός Σουηδίας, 31 Ιανουαρίου 1982), είναι Ελληνίδα τραγουδίστρια. Ξεκίνησε την επαγγελματική της πορεία το 1999 ως μέλος του συγκροτήματος Antique[2] μαζί με το Νίκο Παναγιωτίδη, το οποίο έκανε μεγάλη επιτυχία σε μικρό χρονικό διάστημα τόσο στην Ελλάδα όσο και στη Σουηδία, όπου και μεγάλωσαν. Η επιτυχία αυτή συνεχίστηκε με τη συμμετοχή τους στο Διαγωνισμό Τραγουδιού Eurovision 2001 για την Ελλάδα κατακτώντας με το κομμάτι «(I Would) Die For You» την τρίτη θέση, την καλύτερη θέση της χώρας μέχρι τότε. Το 2005 εκπροσώπησε ξανά την Ελλάδα στη Eurovision και κατάφερε να νικήσει με το τραγούδι «My Number One», την πρώτη και μοναδική νίκη της χώρας μέχρι σήμερα στο διαγωνισμό.[3]'),
('Ekti Aisthisi', 6.5, 'images/ektiaisthisi.jpg', 'Christina Koletsa','H Χριστίνα Κολέτσα, γεννήθηκε και μεγάλωσε στη Βέροια. Σπούδασε δημοσιογραφία στη Θεσσαλονίκη και κατέβηκε στη Αθήνα το 2006, για τη συμμετοχή της στο Fame Story, το μουσικό talent show του ΑΝΤ1. Έκτοτε, εργάζεται ως τραγουδίστρια.  Στον ελεύθερο της χρόνο, της αρέσει πολύ να ταξιδεύει και να βλέπει ταινίες.'),
('Ti kano moni mou', 7.5, 'images/tikanomonimou.jpg', 'Despina Vandi','Η Δέσποινα Βανδή (πραγματικό όνομα: Δέσποινα Μαλέα, Τύμπιγκεν, 22 Ιουλίου 1969) είναι Ελληνίδα τραγουδίστρια. Στην πρεμιέρα του πρώτου κύκλου του The Voice of Greece, το 2014, αναφέρθηκε πως η Βανδή έχει ξεπεράσει 1.500.000 σε πωλήσεις στην Ελλάδα 2.500.000 αντίτυπα παγκοσμίως. [συνολικά] [1] Aπο το 2018 Ανήκει στο Δυναμικό της Panik Records. '),
('Moro mou sorry', 5.5, 'images/moromousorry.jpg', 'Elli Kokkinou','Έχει συνεργαστεί με πολλούς καλλιτέχνες, όπως: Άννα Βίσση, Γιάννης Γρόσης, Δέσποινα Βανδή, Γλυκερία, Γιάννης Ξανθόπουλος Μιχάλης Ρακιντζής, Πασχάλης Τερζής, Σάκης Ρουβάς, Τόλης Βοσκόπουλος, Θάνος Πετρέλης, Νατάσα Θεοδωρίδου, Νίκος Οικονομόπουλος, Γιώργος Τσαλίκης, Βασίλης Καρράς, Γιώργος Μαζωνάκης και Καλομοίρα.
Στις 14 Μαρτίου του 2010, σε εκπομπή που έγινε από τον τηλεοπτικό σταθμό Alpha για τις καλύτερες Ελληνίδες τραγουδίστριες από το 1960 μέχρι και το 2010, η Έλλη βρέθηκε στο νούμερο 27. Έχει Πουλήσει πάνω από 160.000 δίσκους.'),
('Choris Esena', 10.5, 'images/chorisesena.jpg', 'Dimitris Korialas','Ο Δημήτρης Κοργιαλάς (Ναύπακτος, 3 Αυγούστου 1971) είναι Έλληνας electro pop/rock συνθέτης και τραγουδιστής. Επίσης, υπογράφει στιχουργικά τα περισσότερα από τα τραγούδια του. Έχει συνεργαστεί με Έλληνες καλλιτέχνες, όπως ο Νίκος Ζιώγαλας, η Ευρυδίκη, η Άννα Βίσση και ο Σάκης Ρουβάς. ');

CREATE TABLE `area` (
  `id` int NOT NULL,
  `description` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP table area;

INSERT INTO area (id,description) VALUES
(1, 'Ampelokipoi'),
(2, 'Papagou'),
(3, 'Athens center'),
(4, 'Zografou'),
(5, 'Kifisia'),
(6, 'Nea Smyrni'),
(7, 'Chalandri'),
(8, 'Glyfada'),
(9, 'Marousi'),
(10, 'Kolonaki');

CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(200) NOT NULL,
  `address` varchar(200) NOT NULL,
  `area_id` int NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `tel` varchar(20) NOT NULL,
  `comments` varchar(200) DEFAULT NULL,
  `offer` tinyint DEFAULT NULL,
  `payment` varchar(20) DEFAULT NULL,
  `stamp` datetime NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_fk_area` (`area_id`),
  KEY `order_fk_user` (`user_id`),
  CONSTRAINT `order_fk_area` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`),
  CONSTRAINT `order_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE cdsshopdb.order;

CREATE TABLE `order_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `pie_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `order_item_fk_order` (`order_id`),
  KEY `order_item_fk_pie` (`pie_id`),
  CONSTRAINT `order_item_fk_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  CONSTRAINT `order_item_fk_cd` FOREIGN KEY (`cd_id`) REFERENCES `cd` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE cdsshopdb.order_item;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(200) NOT NULL,
  `fullname` varchar(200) NOT NULL,
  `email` varchar(50) NOT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `session` varchar(45) DEFAULT NULL,
  `salt` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE cdsshopdb.user;

SELECT * FROM user;

DELETE FROM user;

CREATE TABLE cdsshopdb.role (
    role_id INT PRIMARY KEY,
    description VARCHAR(45)
);

DROP table cdsshopdb.role;

INSERT INTO cdsshopdb.role (role_id,description)
VALUES (1,'admin'),
       (2,'customer');

SELECT * FROM role;
	
CREATE TABLE cdsshopdb.user_role (
    user_id INT,
    role_id INT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES role(role_id)
);

DROP table cdsshopdb.user_role;

INSERT INTO user_role (user_id,role_id)
VALUES (1,1),
       (2,2);

SELECT * FROM user_role;