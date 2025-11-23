USE fma;

-- 1. Cities
INSERT INTO Cities VALUES
(1, 'Central City', 'Central Region'),
(2, 'East City', 'East Region'),
(3, 'Briggs Fortress', 'North Region'),
(4, 'Dublith', 'South Region'),
(5, 'Rush Valley', 'West Region'),
(6, 'Ishval Ruins', 'East Region'),
(7, 'Resembool', 'East Region'),
(8, 'South HQ', 'South Region'),
(9, 'West HQ', 'West Region'),
(10, 'Xing Trade Port', 'Far East Region');

-- 2. Alchemists (Superclass)
INSERT INTO Alchemists VALUES
(100, 'Edward', NULL, 'Elric', 'State Alchemy', 'SE-092', 'AM'),
(101, 'Alphonse', NULL, 'Elric', 'State Alchemy', 'SE-093', 'AM'),
(102, 'Roy', NULL, 'Mustang', 'Flame Alchemy', 'SE-001', 'AM'),
(103, 'Riza', NULL, 'Hawkeye', 'Ballistics Ops', NULL, 'AM'),
(104, 'Alex', 'Louis', 'Armstrong', 'Armstrong Lineage', 'SE-008', 'AM'),
(105, 'Olivier', 'Mira', 'Armstrong', 'Strategic Ops', NULL, 'AM'),
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

-- 3. Labs
INSERT INTO Labs VALUES
(10, 'Central Lab 3', 1, 5),
(11, 'East Research Lab', 2, 4),
(12, 'Briggs Research Facility', 3, 4),
(13, 'Central Intelligence Archives', 1, 5),
(14, 'East Command Hospital Lab', 2, 3),
(15, 'Ishval Reconstruction Lab', 6, 2);

-- 4. Units
INSERT INTO Units VALUES
(1, 'Central Command', 1, 102),
(2, 'Briggs Defense Corps', 3, 105),
(3, 'East City Garrison', 2, 106),
(4, 'Intelligence Division', 1, 109),
(5, 'Ishval Reconstruction Corps', 6, 111);


-- 5. Missions
INSERT INTO Missions VALUES
(200, 'MS-ALPHA', 1911, 'Reconnaissance', '1911-01-05', '1911-01-10', 'Completed'),
(201, 'MS-BRIGGS-01', 1914, 'Defense', '1914-02-11', '1914-03-01', 'Ongoing'),
(202, 'MS-LAB3-INV', 1910, 'Investigation', '1910-07-02', NULL, 'Ongoing'),
(203, 'MS-ISHVAL-RELIEF', 1909, 'Humanitarian', '1909-06-10', '1909-11-30', 'Completed'),
(204, 'MS-CENT-DATA', 1911, 'Investigation', '1911-09-01', '1911-09-20', 'Completed'),
(205, 'MS-EAST-RAID', 1912, 'Combat', '1912-03-05', '1912-03-07', 'Failed'),
(206, 'MS-RUSH-ESCORT', 1912, 'Escort', '1912-04-01', '1912-04-02', 'Completed'),
(207, 'MS-XING-NEGOT', 1913, 'Diplomacy', '1913-05-12', '1913-05-25', 'Completed'),
(208, 'MS-BRIGGS-02', 1914, 'Defense', '1914-11-05', NULL, 'Ongoing'),
(209, 'MS-GATE-RES', 1914, 'Research', '1914-01-15', NULL, 'Ongoing'),
(210, 'MS-INTEL-NORTH', 1913, 'Reconnaissance', '1913-02-03', '1913-02-12', 'Completed'),
(211, 'MS-TRAIN-CADET', 1910, 'Training', '1910-08-01', '1910-08-15', 'Completed'),
(212, 'MS-ISHVAL-CLEAN', 1911, 'Investigation', '1911-02-01', '1911-03-10', 'Completed');
-- 6. Artifacts
INSERT INTO Artifacts VALUES
(500, 'Prototype Philosopher Stone', '1910-06-01', 'Recovered in Lab 3', 10, 10),
(501, 'Briggs Ice Array', '1913-12-12', 'Recovered at Briggs', 4, 12),
(502, 'Stabilized Red Stone', '1911-09-09', 'Synthesized at East Research Lab', 7, 11),
(503, 'Ishval Memory Array', '1912-04-02', 'Recovered from Ishval Ruins', 6, 15),
(504, 'Prototype Automail Reactor', '1913-03-11', 'Rush Valley experimental core', 5, 10),
(505, 'Emotion Suppression Seal', '1912-12-21', 'Briggs psychological operations artifact', 8, 12),
(506, 'Gate Signature Sample', '1914-07-30', 'Central clandestine archive sample', 10, 13);

-- 7. Homunculi
INSERT INTO Homunculi VALUES
(600, 'Lust', 'Father Creation', 'Active', 80, 10),
(601, 'Envy', 'Father Creation', 'Active', 90, 10),
(602, 'Gluttony', 'Father Creation', 'Active', 75, 11),
(603, 'Greed', 'Father Creation', 'Rogue', 85, 12),
(604, 'Wrath', 'Father Creation', 'Active', 95, 13),
(605, 'Sloth', 'Father Creation', 'Active', 88, 10),
(606, 'Pride', 'Father Creation', 'Active', 98, 13);

-- 8. Ingredients
INSERT INTO Ingredients VALUES
(400, 'Red Stone', 'High'),
(401, 'Carbon Powder', 'Low'),
(402, 'Stabilizing Gel', 'Medium'),
(403, 'Silver Nitrate', 'Medium'),
(404, 'Human Blood Sample', 'High'),
(405, 'Automail Steel Shavings', 'Low'),
(406, 'Ishvalan Soil', 'Medium'),
(407, 'Xingese Alkahestry Catalyst', 'High');

-- 9. Ingredient Stock
INSERT INTO IngredientStock VALUES
(400, 10, 20),
(401, 10, 300),
(402, 12, 50),
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


-- 10. Devices
INSERT INTO Devices VALUES
(300, 'Transmutation Amplifier', 'Alchemy Device', 10),
(301, 'Stone Analyzer', 'Research Device', 10),
(302, 'Long-range Communication Array', 'Support Device', 13),
(303, 'Automail Stress Bench', 'Engineering Device', 10),
(304, 'Ishvalan Soil Analyzer', 'Research Device', 15),
(305, 'Alkahestry Circle Projector', 'Alchemy Device', 13),
(306, 'Vital Sign Stabilizer', 'Medical Device', 14);

-- 11. Mission Logs
INSERT INTO MissionLogs VALUES
(202, 1, '1910-07-03 10:00:00', 102, 'Entered Lab 3', 'Ongoing', 'EV-01'),
(200, 1, '1911-01-06 09:00:00', 100, 'Recon sweep', 'Success', 'EV-02'),
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


-- 12. Transmutation Attempts
INSERT INTO TransmutationAttempts VALUES
(500, 1, '1910-07-10', 102, 'Partial success', 0, 'Unstable output', 'EV-100'),
(500, 2, '1910-07-13', 100, 'Failure', 2, 'Explosion observed', 'EV-101'),
(500, 3, '1910-07-18', 103, 'Partial reconstruction of sample', 0, 'Traces of human signature detected', 'EV-102'),
(502, 1, '1911-09-10', 112, 'Successful stabilization', 0, 'Red Stone holds charge under stress', 'EV-502-01'),
(502, 2, '1911-09-12', 102, 'Controlled overload', 1, 'Stone destabilized at high temperature', 'EV-502-02'),
(503, 1, '1912-04-10', 111, 'Partial success', 0, 'Memory resonance observed', 'EV-503-01'),
(504, 1, '1913-03-12', 100, 'Failure', 2, 'Automail reactor overheated', 'EV-504-01'),
(505, 1, '1912-12-22', 105, 'Successful seal activation', 0, 'Subject emotional response dampened', 'EV-505-01'),
(506, 1, '1914-08-01', 102, 'Incomplete analysis', 0, 'Sample reacts to Gate-related arrays', 'EV-506-01');

-- 13. AttemptArtifactIngredients
INSERT INTO AttemptArtifactIngredients VALUES
(500, 1, 400, 102, 300, 10.5, 'Catalyst', 'g'),
(500, 1, 401, 102, 300, 2.0, 'Binder', 'g'),
(500, 2, 400, 100, 301, 5.0, 'Core', 'g'),
(500, 3, 402, 103, 301, 8.0, 'Stabilizer', 'ml'),
(500, 3, 403, 103, 300, 1.5, 'Amplifier', 'g'),
(502, 1, 400, 112, 300, 15.0, 'Core Matrix', 'g'),
(502, 1, 403, 112, 301, 5.0, 'Purity Agent', 'g'),
(502, 2, 400, 102, 302, 12.0, 'Core Matrix', 'g'),
(502, 2, 402, 102, 302, 6.0, 'Stabilizer', 'ml'),
(503, 1, 406, 111, 304, 50.0, 'Memory Medium', 'g'),
(503, 1, 403, 111, 301, 3.0, 'Conductor', 'g'),
(504, 1, 405, 100, 303, 25.0, 'Metal Core', 'g'),
(504, 1, 402, 100, 306, 10.0, 'Coolant Gel', 'ml'),
(505, 1, 404, 105, 306, 2.0, 'Human Anchor', 'ml'),
(505, 1, 403, 105, 305, 1.0, 'Circle Conductor', 'g'),
(506, 1, 407, 102, 305, 0.5, 'Alkahestry Catalyst', 'g'),
(506, 1, 400, 102, 300, 4.0, 'Reference Stone', 'g');

-- 14A. Mission Assignment
INSERT INTO MissionAssignment VALUES
(200, 100, 'Lead', '1911-01-05'),
(200, 101, 'Support', '1911-01-05'),
(202, 102, 'Investigator', '1910-07-02'),
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

-- 14B. MissionAssignmentUnit
INSERT INTO MissionAssignmentUnit VALUES
(200, 100, 1),
(201, 104, 2),
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

-- 14C. MissionAssignmentLab
INSERT INTO MissionAssignmentLab VALUES
(202, 102, 10),
(201, 105, 12),
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


-- 15. Forensics Analyst
INSERT INTO ForensicsAnalyst VALUES
(103, 'Forensics Level 1', 10);
(113, 'Forensics Level 2', 13);

-- 16. FieldOperative
INSERT INTO FieldOperative VALUES
(100, 85, 5),
(104, 90, 10),
(101, 80, 4),
(102, 88, 9),
(103, 70, 3),
(105, 92, 12),
(106, 75, 6),
(107, 78, 7),
(111, 89, 10),
(115, 95, 15);

-- 17. AlchemistMissionHistory
INSERT INTO AlchemistMissionHistory VALUES
(100, 200),
(101, 200),
(102, 202),
(104, 201),
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

-- 18. ForensicsAnalystArtifacts
INSERT INTO ForensicsAnalystArtifacts VALUES
(103, 500),
(103, 501),
(103, 502),
(103, 503),
(113, 503),
(113, 505),
(113, 506);

-- 19. AlchemistRankHistory
INSERT INTO AlchemistRankHistory VALUES
(102, 'Colonel', '1909-01-01', '1912-01-01'),
(102, 'Brigadier General', '1912-01-02', NULL);
(100, 'State Alchemist', '1909-10-01', NULL),
(101, 'State Alchemist', '1910-01-01', NULL),
(104, 'Major', '1908-05-01', '1911-05-01'),
(104, 'Major General', '1911-05-02', NULL),
(105, 'Major', '1908-07-01', '1912-02-01'),
(105, 'Major General', '1912-02-02', NULL),
(106, 'Lieutenant Colonel', '1910-03-01', NULL),
(107, 'Second Lieutenant', '1910-06-01', NULL),
(111, 'Civilian Master Alchemist', '1905-01-01', NULL);

-- 20. AlchemistSpecializations
INSERT INTO AlchemistSpecializations VALUES
(100, 'Limb Restoration'),
(100, 'Combat Transmutation'),
(100, 'Automail Integration'),
(101, 'Armor Binding'),
(102, 'Flame Alchemy'),
(102, 'Strategic Flame Arrays'),
(103, 'Ballistics Forensics'),
(104, 'Shockwave Alchemy'),
(104, 'Strength Enhancement'),
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
