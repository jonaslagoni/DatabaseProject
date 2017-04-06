CREATE TABLE Component(
	componentId SERIAL,
    name VARCHAR(100) NOT NULL,
    kind VARCHAR(15) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    preferedRestock INT NOT NULL,
    minimumRestock INT NOT NULL,
    stock INT NOT NULL,
    CHECK (price >= 0),
    CHECK (stock >= 0),
    CHECK (preferedRestock >= 0),
    CHECK (minimumRestock >= 0),
    PRIMARY KEY (componentId)
);
CREATE TABLE Cpu(
	componentId INT,
    socket VARCHAR(30) NOT NULL,
    clockspeed DECIMAL(3,1) NOT NULL,
    CHECK (clockspeed >= 0),
	FOREIGN KEY (componentId) 
    REFERENCES Component (componentId) 
    ON DELETE CASCADE
);
CREATE TABLE Ram(
	componentId INT,
    ramType VARCHAR(20) NOT NULL,
    busspeed INT NOT NULL,
    CHECK (busspeed >= 0),
	FOREIGN KEY (componentId) 
    REFERENCES Component (componentId) 
    ON DELETE CASCADE
);
CREATE TABLE Mainboard(
	componentId INT,
    socket VARCHAR(30) NOT NULL,
    ramType VARCHAR(20) NOT NULL,
    onBoardGraphics BOOLEAN NOT NULL,
    formFactor VARCHAR(10) NOT NULL,
	FOREIGN KEY (componentId) 
    REFERENCES Component (componentId) 
    ON DELETE CASCADE
);
CREATE TABLE ComputerCase(
	componentId INT,
    formFactor VARCHAR(10) NOT NULL,
	FOREIGN KEY (componentId) 
    REFERENCES Component (componentId) 
    ON DELETE CASCADE
);
CREATE TABLE ComputerSystem(
	componentListId SERIAL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (componentListId)
);
CREATE TABLE ComputerSystemComponents(
	componentId INT,
    componentListId INT,
	FOREIGN KEY (componentId) 
    REFERENCES Component (componentId) 
    ON DELETE CASCADE,
	FOREIGN KEY (componentListId) 
    REFERENCES ComputerSystem (componentListId) 
    ON DELETE CASCADE
);


INSERT INTO component VALUES (1, 'CPU 1', 'CPU', 1235.30, 25, 4, 7);
INSERT INTO component VALUES (2, 'CPU 2', 'CPU', 1166.13, 21, 8, 39);
INSERT INTO component VALUES (3, 'CPU 3', 'CPU', 2769.50, 24, 5, 39);
INSERT INTO component VALUES (4, 'CPU 4', 'CPU', 906.63, 34, 6, 40);
INSERT INTO component VALUES (5, 'CPU 5', 'CPU', 7034.71, 33, 8, 44);
INSERT INTO component VALUES (6, 'CPU 6', 'CPU', 9616.43, 17, 5, 47);
INSERT INTO component VALUES (7, 'CPU 7', 'CPU', 5272.09, 35, 5, 28);
INSERT INTO component VALUES (9, 'CPU 9', 'CPU', 3813.89, 39, 3, 34);
INSERT INTO component VALUES (10, 'CPU 10', 'CPU', 2676.19, 32, 7, 39);
INSERT INTO component VALUES (11, 'CPU 11', 'CPU', 6125.96, 24, 4, 13);
INSERT INTO component VALUES (12, 'CPU 12', 'CPU', 1510.04, 24, 3, 15);
INSERT INTO component VALUES (13, 'CPU 13', 'CPU', 6049.54, 20, 4, 48);
INSERT INTO component VALUES (14, 'CPU 14', 'CPU', 8237.43, 32, 6, 28);
INSERT INTO component VALUES (15, 'CPU 15', 'CPU', 5921.38, 25, 5, 47);
INSERT INTO component VALUES (16, 'CPU 16', 'CPU', 6346.07, 46, 3, 5);
INSERT INTO component VALUES (17, 'CPU 17', 'CPU', 6674.23, 28, 8, 12);
INSERT INTO component VALUES (18, 'CPU 18', 'CPU', 644.32, 21, 2, 33);
INSERT INTO component VALUES (19, 'CPU 19', 'CPU', 5417.33, 43, 4, 25);
INSERT INTO component VALUES (20, 'CPU 20', 'CPU', 8419.02, 11, 6, 19);
INSERT INTO component VALUES (21, 'CPU 21', 'CPU', 578.15, 26, 6, 16);
INSERT INTO component VALUES (22, 'CPU 22', 'CPU', 1346.57, 17, 2, 9);
INSERT INTO component VALUES (23, 'CPU 23', 'CPU', 9155.74, 36, 6, 22);
INSERT INTO component VALUES (24, 'CPU 24', 'CPU', 9263.21, 21, 2, 6);
INSERT INTO component VALUES (25, 'CPU 25', 'CPU', 7321.74, 40, 7, 21);
INSERT INTO component VALUES (26, 'CPU 26', 'CPU', 3429.37, 42, 8, 40);
INSERT INTO component VALUES (27, 'CPU 27', 'CPU', 7865.66, 20, 6, 32);
INSERT INTO component VALUES (28, 'CPU 28', 'CPU', 7757.07, 49, 8, 44);
INSERT INTO component VALUES (29, 'CPU 29', 'CPU', 2936.95, 14, 5, 9);
INSERT INTO component VALUES (30, 'CPU 30', 'CPU', 2908.93, 33, 4, 22);
INSERT INTO component VALUES (31, 'RAM 1', 'RAM', 1106.03, 13, 2, 22);
INSERT INTO component VALUES (32, 'RAM 2', 'RAM', 8210.74, 17, 5, 22);
INSERT INTO component VALUES (33, 'RAM 3', 'RAM', 5826.24, 14, 7, 26);
INSERT INTO component VALUES (34, 'RAM 4', 'RAM', 8444.11, 22, 4, 29);
INSERT INTO component VALUES (35, 'RAM 5', 'RAM', 562.75, 11, 4, 23);
INSERT INTO component VALUES (36, 'RAM 6', 'RAM', 7033.22, 23, 5, 5);
INSERT INTO component VALUES (37, 'RAM 7', 'RAM', 623.93, 47, 3, 40);
INSERT INTO component VALUES (38, 'RAM 8', 'RAM', 9512.40, 21, 2, 22);
INSERT INTO component VALUES (39, 'RAM 9', 'RAM', 5553.46, 29, 6, 37);
INSERT INTO component VALUES (40, 'RAM 10', 'RAM', 3982.53, 40, 5, 45);
INSERT INTO component VALUES (41, 'RAM 11', 'RAM', 9807.61, 23, 3, 7);
INSERT INTO component VALUES (42, 'RAM 12', 'RAM', 1182.14, 29, 3, 32);
INSERT INTO component VALUES (43, 'RAM 13', 'RAM', 5616.96, 19, 4, 35);
INSERT INTO component VALUES (44, 'RAM 14', 'RAM', 700.13, 35, 6, 22);
INSERT INTO component VALUES (45, 'RAM 15', 'RAM', 6083.52, 48, 6, 28);
INSERT INTO component VALUES (46, 'RAM 16', 'RAM', 1412.41, 20, 7, 42);
INSERT INTO component VALUES (47, 'RAM 17', 'RAM', 588.34, 14, 3, 8);
INSERT INTO component VALUES (48, 'RAM 18', 'RAM', 602.43, 24, 5, 38);
INSERT INTO component VALUES (49, 'RAM 19', 'RAM', 8865.45, 45, 2, 12);
INSERT INTO component VALUES (50, 'RAM 20', 'RAM', 4281.86, 12, 2, 4);
INSERT INTO component VALUES (51, 'RAM 21', 'RAM', 6268.16, 44, 5, 11);
INSERT INTO component VALUES (52, 'RAM 22', 'RAM', 269.36, 34, 6, 40);
INSERT INTO component VALUES (53, 'RAM 23', 'RAM', 5786.29, 34, 2, 33);
INSERT INTO component VALUES (54, 'RAM 24', 'RAM', 9686.50, 42, 4, 35);
INSERT INTO component VALUES (55, 'RAM 25', 'RAM', 3687.69, 26, 7, 37);
INSERT INTO component VALUES (56, 'RAM 26', 'RAM', 3217.70, 30, 3, 25);
INSERT INTO component VALUES (57, 'RAM 27', 'RAM', 4850.93, 40, 2, 5);
INSERT INTO component VALUES (58, 'RAM 28', 'RAM', 6918.01, 43, 3, 27);
INSERT INTO component VALUES (59, 'RAM 29', 'RAM', 2030.89, 17, 7, 35);
INSERT INTO component VALUES (60, 'RAM 30', 'RAM', 2394.77, 42, 5, 23);
INSERT INTO component VALUES (61, 'CASE 1', 'CASE', 4814.88, 31, 4, 36);
INSERT INTO component VALUES (62, 'CASE 2', 'CASE', 6434.80, 22, 7, 46);
INSERT INTO component VALUES (63, 'CASE 3', 'CASE', 5666.32, 32, 6, 27);
INSERT INTO component VALUES (64, 'CASE 4', 'CASE', 9305.20, 35, 6, 30);
INSERT INTO component VALUES (65, 'CASE 5', 'CASE', 2621.76, 17, 5, 42);
INSERT INTO component VALUES (66, 'CASE 6', 'CASE', 8953.32, 36, 3, 14);
INSERT INTO component VALUES (67, 'CASE 7', 'CASE', 7270.82, 29, 8, 37);
INSERT INTO component VALUES (68, 'CASE 8', 'CASE', 9597.19, 28, 3, 6);
INSERT INTO component VALUES (69, 'CASE 9', 'CASE', 8757.26, 44, 7, 32);
INSERT INTO component VALUES (70, 'CASE 10', 'CASE', 3649.82, 29, 7, 12);
INSERT INTO component VALUES (71, 'CASE 11', 'CASE', 8675.15, 13, 3, 41);
INSERT INTO component VALUES (72, 'CASE 12', 'CASE', 6637.69, 12, 7, 32);
INSERT INTO component VALUES (73, 'CASE 13', 'CASE', 7704.92, 40, 7, 3);
INSERT INTO component VALUES (74, 'CASE 14', 'CASE', 3308.99, 48, 5, 12);
INSERT INTO component VALUES (75, 'CASE 15', 'CASE', 3415.35, 25, 3, 31);
INSERT INTO component VALUES (76, 'CASE 16', 'CASE', 2507.77, 25, 7, 27);
INSERT INTO component VALUES (77, 'CASE 17', 'CASE', 4341.18, 29, 2, 37);
INSERT INTO component VALUES (78, 'CASE 18', 'CASE', 5506.90, 36, 4, 45);
INSERT INTO component VALUES (79, 'CASE 19', 'CASE', 537.45, 26, 8, 45);
INSERT INTO component VALUES (80, 'CASE 20', 'CASE', 6230.11, 47, 7, 30);
INSERT INTO component VALUES (81, 'CASE 21', 'CASE', 9144.69, 32, 5, 18);
INSERT INTO component VALUES (82, 'CASE 22', 'CASE', 8114.78, 35, 8, 49);
INSERT INTO component VALUES (83, 'CASE 23', 'CASE', 520.18, 23, 2, 32);
INSERT INTO component VALUES (84, 'CASE 24', 'CASE', 3248.70, 14, 4, 19);
INSERT INTO component VALUES (85, 'CASE 25', 'CASE', 7279.46, 29, 7, 15);
INSERT INTO component VALUES (86, 'CASE 26', 'CASE', 6547.06, 24, 8, 45);
INSERT INTO component VALUES (87, 'CASE 27', 'CASE', 5096.69, 37, 2, 3);
INSERT INTO component VALUES (88, 'CASE 28', 'CASE', 7441.23, 45, 8, 27);
INSERT INTO component VALUES (89, 'CASE 29', 'CASE', 7122.55, 39, 8, 35);
INSERT INTO component VALUES (90, 'CASE 30', 'CASE', 294.92, 26, 4, 42);
INSERT INTO component VALUES (91, 'GPU 1', 'GPU', 8434.93, 20, 5, 45);
INSERT INTO component VALUES (92, 'GPU 2', 'GPU', 8353.85, 26, 6, 18);
INSERT INTO component VALUES (93, 'GPU 3', 'GPU', 1459.86, 27, 8, 13);
INSERT INTO component VALUES (94, 'GPU 4', 'GPU', 5222.14, 37, 7, 10);
INSERT INTO component VALUES (95, 'GPU 5', 'GPU', 7646.38, 28, 5, 21);
INSERT INTO component VALUES (96, 'GPU 6', 'GPU', 7874.40, 38, 5, 22);
INSERT INTO component VALUES (97, 'GPU 7', 'GPU', 5007.78, 38, 4, 7);
INSERT INTO component VALUES (98, 'GPU 8', 'GPU', 8125.99, 27, 3, 35);
INSERT INTO component VALUES (99, 'GPU 9', 'GPU', 8434.51, 20, 6, 12);
INSERT INTO component VALUES (100, 'GPU 10', 'GPU', 9799.17, 18, 4, 41);
INSERT INTO component VALUES (101, 'GPU 11', 'GPU', 9640.45, 10, 8, 11);
INSERT INTO component VALUES (102, 'GPU 12', 'GPU', 6337.93, 29, 7, 42);
INSERT INTO component VALUES (103, 'GPU 13', 'GPU', 7787.12, 38, 5, 32);
INSERT INTO component VALUES (104, 'GPU 14', 'GPU', 4469.00, 40, 6, 2);
INSERT INTO component VALUES (105, 'GPU 15', 'GPU', 7934.64, 41, 8, 7);
INSERT INTO component VALUES (106, 'GPU 16', 'GPU', 5786.02, 47, 8, 22);
INSERT INTO component VALUES (107, 'GPU 17', 'GPU', 8369.77, 22, 5, 16);
INSERT INTO component VALUES (108, 'GPU 18', 'GPU', 2191.43, 19, 8, 7);
INSERT INTO component VALUES (109, 'GPU 19', 'GPU', 4589.48, 23, 7, 10);
INSERT INTO component VALUES (110, 'GPU 20', 'GPU', 3019.21, 27, 4, 30);
INSERT INTO component VALUES (111, 'GPU 21', 'GPU', 7262.24, 45, 5, 42);
INSERT INTO component VALUES (112, 'GPU 22', 'GPU', 1370.27, 45, 7, 15);
INSERT INTO component VALUES (113, 'GPU 23', 'GPU', 3849.80, 46, 3, 2);
INSERT INTO component VALUES (114, 'GPU 24', 'GPU', 4679.66, 36, 3, 40);
INSERT INTO component VALUES (115, 'GPU 25', 'GPU', 8716.52, 14, 8, 45);
INSERT INTO component VALUES (116, 'GPU 26', 'GPU', 9882.28, 24, 4, 16);
INSERT INTO component VALUES (117, 'GPU 27', 'GPU', 4566.07, 33, 6, 14);
INSERT INTO component VALUES (118, 'GPU 28', 'GPU', 6657.44, 27, 2, 10);
INSERT INTO component VALUES (119, 'GPU 29', 'GPU', 8793.36, 28, 7, 38);
INSERT INTO component VALUES (120, 'GPU 30', 'GPU', 3189.40, 32, 4, 49);
INSERT INTO component VALUES (8, 'CPU 8', 'CPU', 9653.15, 31, 8, 8);
INSERT INTO component VALUES (121, 'MAINBOARD 1', 'MAINBOARD', 1992.57, 25, 2, 13);
INSERT INTO component VALUES (122, 'MAINBOARD 2', 'MAINBOARD', 3600.87, 48, 2, 5);
INSERT INTO component VALUES (123, 'MAINBOARD 3', 'MAINBOARD', 4401.89, 32, 6, 41);
INSERT INTO component VALUES (124, 'MAINBOARD 4', 'MAINBOARD', 551.75, 43, 3, 2);
INSERT INTO component VALUES (125, 'MAINBOARD 5', 'MAINBOARD', 9994.10, 47, 7, 29);
INSERT INTO component VALUES (126, 'MAINBOARD 6', 'MAINBOARD', 7048.58, 26, 5, 20);
INSERT INTO component VALUES (127, 'MAINBOARD 7', 'MAINBOARD', 974.89, 31, 3, 18);
INSERT INTO component VALUES (128, 'MAINBOARD 8', 'MAINBOARD', 8807.40, 46, 4, 36);
INSERT INTO component VALUES (129, 'MAINBOARD 9', 'MAINBOARD', 1604.79, 28, 6, 39);
INSERT INTO component VALUES (130, 'MAINBOARD 10', 'MAINBOARD', 5640.21, 23, 4, 44);
INSERT INTO component VALUES (131, 'MAINBOARD 11', 'MAINBOARD', 2191.24, 17, 7, 38);
INSERT INTO component VALUES (132, 'MAINBOARD 12', 'MAINBOARD', 5005.68, 44, 6, 3);
INSERT INTO component VALUES (133, 'MAINBOARD 13', 'MAINBOARD', 8901.86, 47, 2, 7);
INSERT INTO component VALUES (134, 'MAINBOARD 14', 'MAINBOARD', 3629.80, 45, 6, 40);
INSERT INTO component VALUES (135, 'MAINBOARD 15', 'MAINBOARD', 1900.13, 36, 7, 21);
INSERT INTO component VALUES (136, 'MAINBOARD 16', 'MAINBOARD', 6448.76, 39, 7, 37);
INSERT INTO component VALUES (137, 'MAINBOARD 17', 'MAINBOARD', 1242.11, 31, 3, 42);
INSERT INTO component VALUES (138, 'MAINBOARD 18', 'MAINBOARD', 5703.38, 34, 3, 21);
INSERT INTO component VALUES (139, 'MAINBOARD 19', 'MAINBOARD', 7205.46, 30, 7, 32);
INSERT INTO component VALUES (140, 'MAINBOARD 20', 'MAINBOARD', 3415.69, 35, 6, 16);
INSERT INTO component VALUES (141, 'MAINBOARD 21', 'MAINBOARD', 1752.15, 26, 6, 2);
INSERT INTO component VALUES (142, 'MAINBOARD 22', 'MAINBOARD', 6443.59, 16, 7, 36);
INSERT INTO component VALUES (143, 'MAINBOARD 23', 'MAINBOARD', 1416.60, 32, 5, 14);
INSERT INTO component VALUES (144, 'MAINBOARD 24', 'MAINBOARD', 7113.36, 12, 5, 36);
INSERT INTO component VALUES (145, 'MAINBOARD 25', 'MAINBOARD', 2500.33, 32, 7, 29);
INSERT INTO component VALUES (146, 'MAINBOARD 26', 'MAINBOARD', 9009.50, 26, 5, 2);
INSERT INTO component VALUES (147, 'MAINBOARD 27', 'MAINBOARD', 9125.93, 22, 8, 48);
INSERT INTO component VALUES (148, 'MAINBOARD 28', 'MAINBOARD', 8524.56, 48, 8, 45);
INSERT INTO component VALUES (149, 'MAINBOARD 29', 'MAINBOARD', 2465.17, 49, 4, 31);
INSERT INTO component VALUES (150, 'MAINBOARD 30', 'MAINBOARD', 3968.48, 28, 6, 28);

INSERT INTO computersystem VALUES (1, 'SYSTEM 1');
INSERT INTO computersystem VALUES (2, 'SYSTEM 2');
INSERT INTO computersystem VALUES (3, 'SYSTEM 3');
INSERT INTO computersystem VALUES (4, 'SYSTEM 4');
INSERT INTO computersystem VALUES (5, 'SYSTEM 5');
INSERT INTO computersystem VALUES (6, 'SYSTEM 6');
INSERT INTO computersystem VALUES (7, 'SYSTEM 7');
INSERT INTO computersystem VALUES (8, 'SYSTEM 8');

INSERT INTO computersystemcomponents VALUES (122, 1);
INSERT INTO computersystemcomponents VALUES (8, 1);
INSERT INTO computersystemcomponents VALUES (61, 1);
INSERT INTO computersystemcomponents VALUES (57, 1);
INSERT INTO computersystemcomponents VALUES (145, 2);
INSERT INTO computersystemcomponents VALUES (16, 2);
INSERT INTO computersystemcomponents VALUES (83, 2);
INSERT INTO computersystemcomponents VALUES (34, 2);
INSERT INTO computersystemcomponents VALUES (115, 2);
INSERT INTO computersystemcomponents VALUES (138, 3);
INSERT INTO computersystemcomponents VALUES (28, 3);
INSERT INTO computersystemcomponents VALUES (89, 3);
INSERT INTO computersystemcomponents VALUES (52, 3);
INSERT INTO computersystemcomponents VALUES (144, 4);
INSERT INTO computersystemcomponents VALUES (16, 4);
INSERT INTO computersystemcomponents VALUES (66, 4);
INSERT INTO computersystemcomponents VALUES (45, 4);
INSERT INTO computersystemcomponents VALUES (126, 5);
INSERT INTO computersystemcomponents VALUES (19, 5);
INSERT INTO computersystemcomponents VALUES (89, 5);
INSERT INTO computersystemcomponents VALUES (33, 5);
INSERT INTO computersystemcomponents VALUES (124, 6);
INSERT INTO computersystemcomponents VALUES (13, 6);
INSERT INTO computersystemcomponents VALUES (70, 6);
INSERT INTO computersystemcomponents VALUES (57, 6);
INSERT INTO computersystemcomponents VALUES (148, 7);
INSERT INTO computersystemcomponents VALUES (17, 7);
INSERT INTO computersystemcomponents VALUES (87, 7);
INSERT INTO computersystemcomponents VALUES (32, 7);
INSERT INTO computersystemcomponents VALUES (144, 8);
INSERT INTO computersystemcomponents VALUES (16, 8);
INSERT INTO computersystemcomponents VALUES (86, 8);
INSERT INTO computersystemcomponents VALUES (32, 8);

INSERT INTO cpu VALUES (1, 'LGA1150 Socket', 3.9);
INSERT INTO cpu VALUES (2, 'LGA1150 Socket', 3.3);
INSERT INTO cpu VALUES (3, 'LGA1151 Socket', 4.2);
INSERT INTO cpu VALUES (4, 'LGA1151 Socket', 4.0);
INSERT INTO cpu VALUES (5, 'LGA1151 Socket', 2.9);
INSERT INTO cpu VALUES (6, 'LGA1151 Socket', 2.1);
INSERT INTO cpu VALUES (7, 'LGA1150 Socket', 2.2);
INSERT INTO cpu VALUES (8, 'LGA1151 Socket', 3.2);
INSERT INTO cpu VALUES (9, 'LGA2011-v3 Socket', 4.0);
INSERT INTO cpu VALUES (10, 'LGA1150 Socket', 3.0);
INSERT INTO cpu VALUES (11, 'LGA1150 Socket', 2.3);
INSERT INTO cpu VALUES (12, 'LGA1151 Socket', 3.9);
INSERT INTO cpu VALUES (13, 'LGA1151 Socket', 3.1);
INSERT INTO cpu VALUES (14, 'LGA1151 Socket', 2.9);
INSERT INTO cpu VALUES (15, 'LGA1151 Socket', 3.1);
INSERT INTO cpu VALUES (16, 'LGA2011-v3 Socket', 3.0);
INSERT INTO cpu VALUES (17, 'LGA2011-v3 Socket', 3.7);
INSERT INTO cpu VALUES (18, 'LGA1150 Socket', 2.9);
INSERT INTO cpu VALUES (19, 'LGA1151 Socket', 2.8);
INSERT INTO cpu VALUES (20, 'LGA1151 Socket', 3.4);
INSERT INTO cpu VALUES (21, 'LGA2011-v3 Socket', 2.6);
INSERT INTO cpu VALUES (22, 'LGA1150 Socket', 2.3);
INSERT INTO cpu VALUES (23, 'LGA2011-v3 Socket', 3.9);
INSERT INTO cpu VALUES (24, 'LGA1150 Socket', 4.5);
INSERT INTO cpu VALUES (25, 'LGA2011-v3 Socket', 3.4);
INSERT INTO cpu VALUES (26, 'LGA2011-v3 Socket', 4.4);
INSERT INTO cpu VALUES (27, 'LGA1151 Socket', 4.4);
INSERT INTO cpu VALUES (28, 'LGA2011-v3 Socket', 2.2);
INSERT INTO cpu VALUES (29, 'LGA2011-v3 Socket', 2.9);
INSERT INTO cpu VALUES (30, 'LGA1151 Socket', 2.5);


INSERT INTO mainboard VALUES (121, 'LGA1150 Socket', 'DDR2', false, 'EATX');
INSERT INTO mainboard VALUES (122, 'LGA1151 Socket', 'DDR3', true, 'EATX');
INSERT INTO mainboard VALUES (123, 'LGA1150 Socket', 'DDR2', false, 'microATX');
INSERT INTO mainboard VALUES (124, 'LGA1151 Socket', 'DDR3', true, 'EATX');
INSERT INTO mainboard VALUES (125, 'LGA2011-v3 Socket', 'DDR2', false, 'EATX');
INSERT INTO mainboard VALUES (126, 'LGA1151 Socket', 'DDR2', true, 'ATX');
INSERT INTO mainboard VALUES (127, 'LGA2011-v3 Socket', 'DDR4', false, 'EATX');
INSERT INTO mainboard VALUES (128, 'LGA2011-v3 Socket', 'DDR4', true, 'ATX');
INSERT INTO mainboard VALUES (129, 'LGA1151 Socket', 'DDR3', false, 'microATX');
INSERT INTO mainboard VALUES (130, 'LGA1151 Socket', 'DDR3', true, 'EATX');
INSERT INTO mainboard VALUES (131, 'LGA1151 Socket', 'DDR2', false, 'EATX');
INSERT INTO mainboard VALUES (132, 'LGA2011-v3 Socket', 'DDR2', true, 'EATX');
INSERT INTO mainboard VALUES (133, 'LGA1151 Socket', 'DDR3', false, 'ATX');
INSERT INTO mainboard VALUES (134, 'LGA1151 Socket', 'DDR4', true, 'ATX');
INSERT INTO mainboard VALUES (135, 'LGA1151 Socket', 'DDR3', false, 'EATX');
INSERT INTO mainboard VALUES (136, 'LGA1151 Socket', 'DDR4', true, 'ATX');
INSERT INTO mainboard VALUES (137, 'LGA1150 Socket', 'DDR3', false, 'ATX');
INSERT INTO mainboard VALUES (138, 'LGA2011-v3 Socket', 'DDR4', true, 'ATX');
INSERT INTO mainboard VALUES (139, 'LGA1151 Socket', 'DDR4', false, 'EATX');
INSERT INTO mainboard VALUES (140, 'LGA1151 Socket', 'DDR3', true, 'EATX');
INSERT INTO mainboard VALUES (141, 'LGA1151 Socket', 'DDR2', false, 'microATX');
INSERT INTO mainboard VALUES (142, 'LGA1151 Socket', 'DDR3', true, 'EATX');
INSERT INTO mainboard VALUES (143, 'LGA1150 Socket', 'DDR2', false, 'microATX');
INSERT INTO mainboard VALUES (144, 'LGA2011-v3 Socket', 'DDR4', true, 'microATX');
INSERT INTO mainboard VALUES (145, 'LGA2011-v3 Socket', 'DDR3', false, 'microATX');
INSERT INTO mainboard VALUES (146, 'LGA2011-v3 Socket', 'DDR2', true, 'EATX');
INSERT INTO mainboard VALUES (147, 'LGA2011-v3 Socket', 'DDR3', false, 'ATX');
INSERT INTO mainboard VALUES (148, 'LGA2011-v3 Socket', 'DDR4', true, 'microATX');
INSERT INTO mainboard VALUES (149, 'LGA2011-v3 Socket', 'DDR2', false, 'EATX');
INSERT INTO mainboard VALUES (150, 'LGA2011-v3 Socket', 'DDR3', true, 'microATX');


INSERT INTO ram VALUES (31, 'DDR4', 3261);
INSERT INTO ram VALUES (32, 'DDR4', 1482);
INSERT INTO ram VALUES (33, 'DDR2', 1177);
INSERT INTO ram VALUES (34, 'DDR3', 3118);
INSERT INTO ram VALUES (35, 'DDR4', 2552);
INSERT INTO ram VALUES (36, 'DDR3', 3365);
INSERT INTO ram VALUES (37, 'DDR3', 2897);
INSERT INTO ram VALUES (38, 'DDR3', 2754);
INSERT INTO ram VALUES (39, 'DDR2', 1673);
INSERT INTO ram VALUES (40, 'DDR3', 3099);
INSERT INTO ram VALUES (41, 'DDR3', 3360);
INSERT INTO ram VALUES (42, 'DDR3', 1286);
INSERT INTO ram VALUES (43, 'DDR3', 1677);
INSERT INTO ram VALUES (44, 'DDR3', 2817);
INSERT INTO ram VALUES (45, 'DDR4', 1395);
INSERT INTO ram VALUES (46, 'DDR4', 3166);
INSERT INTO ram VALUES (47, 'DDR2', 2226);
INSERT INTO ram VALUES (48, 'DDR2', 2964);
INSERT INTO ram VALUES (49, 'DDR2', 1504);
INSERT INTO ram VALUES (50, 'DDR4', 3287);
INSERT INTO ram VALUES (51, 'DDR2', 1097);
INSERT INTO ram VALUES (52, 'DDR4', 1674);
INSERT INTO ram VALUES (53, 'DDR2', 1725);
INSERT INTO ram VALUES (54, 'DDR2', 1796);
INSERT INTO ram VALUES (55, 'DDR4', 2033);
INSERT INTO ram VALUES (56, 'DDR4', 1980);
INSERT INTO ram VALUES (57, 'DDR3', 2648);
INSERT INTO ram VALUES (58, 'DDR4', 2739);
INSERT INTO ram VALUES (59, 'DDR4', 3209);
INSERT INTO ram VALUES (60, 'DDR2', 3492);

INSERT INTO computercase VALUES (61, 'EATX');
INSERT INTO computercase VALUES (62, 'ATX');
INSERT INTO computercase VALUES (63, 'microATX');
INSERT INTO computercase VALUES (64, 'ATX');
INSERT INTO computercase VALUES (65, 'EATX');
INSERT INTO computercase VALUES (66, 'microATX');
INSERT INTO computercase VALUES (67, 'ATX');
INSERT INTO computercase VALUES (68, 'microATX');
INSERT INTO computercase VALUES (69, 'EATX');
INSERT INTO computercase VALUES (70, 'EATX');
INSERT INTO computercase VALUES (71, 'microATX');
INSERT INTO computercase VALUES (72, 'EATX');
INSERT INTO computercase VALUES (73, 'ATX');
INSERT INTO computercase VALUES (74, 'microATX');
INSERT INTO computercase VALUES (75, 'ATX');
INSERT INTO computercase VALUES (76, 'ATX');
INSERT INTO computercase VALUES (77, 'EATX');
INSERT INTO computercase VALUES (78, 'ATX');
INSERT INTO computercase VALUES (79, 'EATX');
INSERT INTO computercase VALUES (80, 'ATX');
INSERT INTO computercase VALUES (81, 'EATX');
INSERT INTO computercase VALUES (82, 'microATX');
INSERT INTO computercase VALUES (83, 'microATX');
INSERT INTO computercase VALUES (84, 'ATX');
INSERT INTO computercase VALUES (85, 'EATX');
INSERT INTO computercase VALUES (86, 'microATX');
INSERT INTO computercase VALUES (87, 'microATX');
INSERT INTO computercase VALUES (88, 'microATX');
INSERT INTO computercase VALUES (89, 'ATX');
INSERT INTO computercase VALUES (90, 'EATX');