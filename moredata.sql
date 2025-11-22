USE fma;

------------------------------------------------------------
-- 21. More Cities
------------------------------------------------------------
INSERT INTO Cities VALUES
(6, 'Ishval Ruins', 'East Region'),
(7, 'Resembool', 'East Region'),
(8, 'South HQ', 'South Region'),
(9, 'West HQ', 'West Region'),
(10, 'Xing Trade Port', 'Far East Region');

------------------------------------------------------------
-- 22. More Alchemists
------------------------------------------------------------
INSERT INTO Alchemists VALUES
(106, 'Maes', NULL, 'Hughes', 'Information Analysis', NULL, 'AM'),
(107, 'Jean', NULL, 'Havoc', 'Firearms Support', NULL, 'AM'),
(108, 'Heymans', NULL, 'Breda', 'Logistics Operations', NULL, 'AM'),
(109, 'Vato', NULL, 'Falman', 'Intelligence', NULL, 'AM'),
(110, 'Kain', NULL, 'Fuery', 'Communications', NULL, 'AM'),
(111, 'Izumi', NULL, 'Curtis', 'Biological Alchemy', NULL, 'AM'),
(112, 'Basque', NULL, 'Grand', 'Iron Blood Alchemy', 'SE-010', 'AM'),
(113, 'Soline', NULL, 'Brooks', 'Medical Alchemy', 'SE-045', 'AM'),
(114, 'Miles', NULL, 'Miles', 'Tactical Operations', NULL, 'AM'),
(115, 'Buccaneer', NULL, 'Buccaneer', 'Briggs Heavy Assault', NULL, 'AM');

------------------------------------------------------------
-- 23. More Labs
------------------------------------------------------------
INSERT INTO Labs VALUES
(13, 'Central Intelligence Archives', 1, 5),
(14, 'East Command Hospital Lab', 2, 3),
(15, 'Ishval Reconstruction Lab', 6, 2);

------------------------------------------------------------
-- 24. More Units
------------------------------------------------------------
INSERT INTO Units VALUES
(3, 'East City Garrison', 2, 106),
(4, 'Intelligence Division', 1, 109),
(5, 'Ishval Reconstruction Corps', 6, 111);

------------------------------------------------------------
-- 25. More Missions
------------------------------------------------------------
INSERT INTO Missions VALUES
(203, 'MS-ISHVAL-RELIEF', 1909, 'Humanitarian', '1909-06-10', '1909-11-30', 'Completed'),
(204, 'MS-CENT-DATA', 1911, 'Investigation', '1911-09-01', '1911-09-20', 'Completed'),
(205, 'MS-EAST-RAID', 1912, 'Combat', '1912-03-05', '1912-03-07', 'Failed'),
(206, 'MS-RUSH-ESCORT', 1912, 'Escort', '1912-04-01', '1912-04-02', 'Completed'),
(207, 'MS-XING-NEGOT', 1913, 'Diplomacy', '1913-05-12', '1913-05-25', 'Completed'),
(208, 'MS-BRIGGS-02', 1914, 'Defense', '1914-11-05', NULL, 'Active'),
(209, 'MS-GATE-RES', 1914, 'Research', '1914-01-15', NULL, 'Ongoing'),
(210, 'MS-INTEL-NORTH', 1913, 'Reconnaissance', '1913-02-03', '1913-02-12', 'Completed'),
(211, 'MS-TRAIN-CADET', 1910, 'Training', '1910-08-01', '1910-08-15', 'Completed'),
(212, 'MS-ISHVAL-CLEAN', 1911, 'Investigation', '1911-02-01', '1911-03-10', 'Completed');

------------------------------------------------------------
-- 26. More Artifacts
------------------------------------------------------------
INSERT INTO Artifacts VALUES
(502, 'Stabilized Red Stone', '1911-09-09', 'Synthesized at East Research Lab', 7, 11),
(503, 'Ishval Memory Array', '1912-04-02', 'Recovered from Ishval Ruins', 6, 15),
(504, 'Prototype Automail Reactor', '1913-03-11', 'Rush Valley experimental core', 5, 10),
(505, 'Emotion Suppression Seal', '1912-12-21', 'Briggs psychological operations artifact', 8, 12),
(506, 'Gate Signature Sample', '1914-07-30', 'Central clandestine archive sample', 10, 13);

------------------------------------------------------------
-- 27. More Homunculi
------------------------------------------------------------
INSERT INTO Homunculi VALUES
(602, 'Gluttony', 'Father Creation', 'Active', 75, 11),
(603, 'Greed', 'Father Creation', 'Rogue', 85, 12),
(604, 'Wrath', 'Father Creation', 'Active', 95, 1),
(605, 'Sloth', 'Father Creation', 'Active', 88, 3),
(606, 'Pride', 'Father Creation', 'Active', 98, 13);

------------------------------------------------------------
-- 28. More Ingredients
------------------------------------------------------------
INSERT INTO Ingredients VALUES
(403, 'Silver Nitrate', 'Medium'),
(404, 'Human Blood Sample', 'High'),
(405, 'Automail Steel Shavings', 'Low'),
(406, 'Ishvalan Soil', 'Medium'),
(407, 'Xingese Alkahestry Catalyst', 'High');

------------------------------------------------------------
-- 29. More Ingredient Stock
------------------------------------------------------------
INSERT INTO IngredientStock VALUES
(400, 11, 40),
(400, 13, 15),
(401, 11, 500),
(402, 13, 80),
(403, 11, 60),
(403, 14, 40),
(404, 14, 10),
(405, 10, 120),
(405, 14, 60),
(406, 15, 200),
(407, 13, 25);

------------------------------------------------------------
-- 30. More Devices
------------------------------------------------------------
INSERT INTO Devices VALUES
(302, 'Long-range Communication Array', 'Support Device', 13),
(303, 'Automail Stress Bench', 'Engineering Device', 10),
(304, 'Ishvalan Soil Analyzer', 'Research Device', 15),
(305, 'Alkahestry Circle Projector', 'Alchemy Device', 13),
(306, 'Vital Sign Stabilizer', 'Medical Device', 14);

------------------------------------------------------------
-- 31. More Mission Logs
------------------------------------------------------------
INSERT INTO MissionLogs VALUES
(203, 1, '1909-06-12 08:00:00', 111, 'Arrived at Ishval relief zone', 'Ongoing', 'EV-203-01'),
(203, 2, '1909-09-01 18:30:00', 111, 'Stabilized refugee camp supplies', 'Ongoing', 'EV-203-02'),
(204, 1, '1911-09-02 10:15:00', 106, 'Secured Central data archive perimeter', 'Ongoing', 'EV-204-01'),
(204, 2, '1911-09-18 21:00:00', 102, 'Cross-checked classified alchemy reports', 'Success', 'EV-204-02'),
(205, 1, '1912-03-05 05:45:00', 104, 'Deployed to East raid staging area', 'Ongoing', 'EV-205-01'),
(205, 2, '1912-03-07 14:10:00', 107, 'Enemy counterattack overwhelmed squad', 'Failure', 'EV-205-02'),
(206, 1, '1912-04-01 09:00:00', 100, 'Escort caravan departed Rush Valley', 'Ongoing', 'EV-206-01'),
(206, 2, '1912-04-02 16:30:00', 101, 'Caravan arrived safely at Central', 'Success', 'EV-206-02'),
(207, 1, '1913-05-13 13:00:00', 105, 'Met Xing delegation at border', 'Ongoing', 'EV-207-01'),
(207, 2, '1913-05-25 19:45:00', 105, 'Signed preliminary trade agreements', 'Success', 'EV-207-02'),
(208, 1, '1914-11-05 06:20:00', 105, 'Briggs perimeter on high alert', 'Ongoing', 'EV-208-01'),
(208, 2, '1914-11-20 22:10:00', 115, 'Heavy brigade repelled northern incursion', 'Ongoing', 'EV-208-02'),
(209, 1, '1914-01-16 08:30:00', 102, 'Initial analysis of Gate signature sample', 'Ongoing', 'EV-209-01'),
(210, 1, '1913-02-03 07:50:00', 104, 'Recon unit departed Central Command', 'Ongoing', 'EV-210-01'),
(211, 1, '1910-08-01 06:00:00', 104, 'Cadet training exercises initiated', 'Ongoing', 'EV-211-01'),
(212, 1, '1911-02-02 09:15:00', 103, 'Forensic sweep of Ishval ruins started', 'Ongoing', 'EV-212-01');

------------------------------------------------------------
-- 32. More Transmutation Attempts
------------------------------------------------------------
INSERT INTO TransmutationAttempts VALUES
(500, 3, '1910-07-18', 103, 'Partial reconstruction of sample', 0, 'Traces of human signature detected', 'EV-102'),
(502, 1, '1911-09-10', 112, 'Successful stabilization', 0, 'Red Stone holds charge under stress', 'EV-502-01'),
(502, 2, '1911-09-12', 102, 'Controlled overload', 1, 'Stone destabilized at high temperature', 'EV-502-02'),
(503, 1, '1912-04-10', 111, 'Partial success', 0, 'Memory resonance observed', 'EV-503-01'),
(504, 1, '1913-03-12', 100, 'Failure', 2, 'Automail reactor overheated', 'EV-504-01'),
(505, 1, '1912-12-22', 105, 'Successful seal activation', 0, 'Subject emotional response dampened', 'EV-505-01'),
(506, 1, '1914-08-01', 102, 'Incomplete analysis', 0, 'Sample reacts to Gate-related arrays', 'EV-506-01');

------------------------------------------------------------
-- 33. More AttemptArtifactIngredients
------------------------------------------------------------
INSERT INTO AttemptArtifactIngredients VALUES
-- Existing artifact 500, additional attempt
(500, 3, 402, 103, 301, 8.0, 'Stabilizer', 'ml'),
(500, 3, 403, 103, 300, 1.5, 'Amplifier', 'g'),

-- Stabilized Red Stone (502)
(502, 1, 400, 112, 300, 15.0, 'Core Matrix', 'g'),
(502, 1, 403, 112, 301, 5.0, 'Purity Agent', 'g'),
(502, 2, 400, 102, 302, 12.0, 'Core Matrix', 'g'),
(502, 2, 402, 102, 302, 6.0, 'Stabilizer', 'ml'),

-- Ishval Memory Array (503)
(503, 1, 406, 111, 304, 50.0, 'Memory Medium', 'g'),
(503, 1, 403, 111, 301, 3.0, 'Conductor', 'g'),

-- Automail Reactor (504)
(504, 1, 405, 100, 303, 25.0, 'Metal Core', 'g'),
(504, 1, 402, 100, 306, 10.0, 'Coolant Gel', 'ml'),

-- Emotion Suppression Seal (505)
(505, 1, 404, 105, 306, 2.0, 'Human Anchor', 'ml'),
(505, 1, 403, 105, 305, 1.0, 'Circle Conductor', 'g'),

-- Gate Signature Sample (506)
(506, 1, 407, 102, 305, 0.5, 'Alkahestry Catalyst', 'g'),
(506, 1, 400, 102, 300, 4.0, 'Reference Stone', 'g');

------------------------------------------------------------
-- 34. More Mission Assignment
------------------------------------------------------------
INSERT INTO MissionAssignment VALUES
(203, 111, 'Lead Alchemist', '1909-06-10'),
(203, 106, 'Logistics Support', '1909-06-15'),
(204, 106, 'Lead Investigator', '1911-09-01'),
(204, 102, 'Senior Oversight', '1911-09-05'),
(205, 104, 'Frontline Commander', '1912-03-04'),
(205, 107, 'Fire Support', '1912-03-04'),
(206, 100, 'Escort Lead', '1912-04-01'),
(206, 101, 'Support Escort', '1912-04-01'),
(207, 105, 'Strategic Negotiator', '1913-05-12'),
(208, 105, 'Briggs Commander', '1914-11-05'),
(208, 115, 'Heavy Assault Lead', '1914-11-05'),
(209, 102, 'Gate Research Lead', '1914-01-15'),
(210, 104, 'Recon Lead', '1913-02-03'),
(211, 104, 'Training Officer', '1910-08-01'),
(211, 107, 'Range Instructor', '1910-08-01'),
(212, 103, 'Lead Forensics', '1911-02-01'),
(212, 113, 'Medical Forensics', '1911-02-05');

------------------------------------------------------------
-- 35. More MissionAssignmentUnit
------------------------------------------------------------
INSERT INTO MissionAssignmentUnit VALUES
(203, 111, 5),
(203, 106, 3),
(204, 106, 4),
(205, 104, 3),
(205, 107, 3),
(206, 100, 1),
(206, 101, 1),
(207, 105, 2),
(208, 105, 2),
(208, 115, 2),
(209, 102, 4),
(210, 104, 1),
(211, 104, 1),
(211, 107, 1),
(212, 103, 5);

------------------------------------------------------------
-- 36. More MissionAssignmentLab
------------------------------------------------------------
INSERT INTO MissionAssignmentLab VALUES
(203, 111, 15),
(204, 106, 13),
(204, 102, 10),
(205, 104, 11),
(206, 100, 10),
(207, 105, 12),
(208, 115, 12),
(209, 102, 13),
(210, 104, 10),
(212, 103, 15),
(212, 113, 14);

------------------------------------------------------------
-- 37. More ForensicsAnalyst
------------------------------------------------------------
INSERT INTO ForensicsAnalyst VALUES
(113, 'Forensics Level 2', 13);

------------------------------------------------------------
-- 38. More FieldOperative
------------------------------------------------------------
INSERT INTO FieldOperative VALUES
(101, 80, 4),
(102, 88, 9),
(103, 70, 3),
(105, 92, 12),
(106, 75, 6),
(107, 78, 7),
(111, 89, 10),
(115, 95, 15);

------------------------------------------------------------
-- 39. More AlchemistMissionHistory
------------------------------------------------------------
INSERT INTO AlchemistMissionHistory VALUES
(111, 203),
(106, 203),
(106, 204),
(102, 204),
(104, 205),
(107, 205),
(100, 206),
(101, 206),
(105, 207),
(105, 208),
(115, 208),
(102, 209),
(104, 210),
(104, 211),
(107, 211),
(103, 212),
(113, 212);

------------------------------------------------------------
-- 40. More ForensicsAnalystArtifacts
------------------------------------------------------------
INSERT INTO ForensicsAnalystArtifacts VALUES
(103, 502),
(103, 503),
(113, 503),
(113, 505),
(113, 506);

------------------------------------------------------------
-- 41. More AlchemistRankHistory
------------------------------------------------------------
INSERT INTO AlchemistRankHistory VALUES
(100, 'State Alchemist', '1909-10-01', NULL),
(101, 'State Alchemist', '1910-01-01', NULL),
(104, 'Major', '1908-05-01', '1911-05-01'),
(104, 'Major General', '1911-05-02', NULL),
(105, 'Major', '1908-07-01', '1912-02-01'),
(105, 'Major General', '1912-02-02', NULL),
(106, 'Lieutenant Colonel', '1910-03-01', NULL),
(107, 'Second Lieutenant', '1910-06-01', NULL),
(111, 'Civilian Master Alchemist', '1905-01-01', NULL);

------------------------------------------------------------
-- 42. More AlchemistSpecializations
------------------------------------------------------------
INSERT INTO AlchemistSpecializations VALUES
(100, 'Combat Transmutation'),
(100, 'Automail Integration'),
(101, 'Armor Binding'),
(102, 'Strategic Flame Arrays'),
(103, 'Ballistics Forensics'),
(104, 'Shockwave Alchemy'),
(105, 'Cold Climate Warfare'),
(106, 'Pattern Recognition'),
(107, 'Ballistics Support'),
(108, 'Supply Optimization'),
(109, 'Information Archiving'),
(110, 'Signal Interference'),
(111, 'Human Transmutation Theory'),
(112, 'Battlefield Enhancement'),
(113, 'Trauma Stabilization'),
(114, 'Mountain Warfare'),
(115, 'Heavy Weapons Integration');