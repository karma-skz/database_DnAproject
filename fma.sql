-- ============================================
-- MASTER DATABASE SCHEMA WITH FOREIGN KEYS
-- ============================================
drop database if exists fma;
CREATE DATABASE IF NOT EXISTS fma;

USE fma;

-- 1. Cities
CREATE TABLE Cities (
    CityID   INT PRIMARY KEY,
    Region   VARCHAR(100),
    City     VARCHAR(100)
);

-- 2. Alchemists
CREATE TABLE Alchemists (
    AlchemistID     INT PRIMARY KEY,
    FName           VARCHAR(100),
    MName           VARCHAR(100),
    LName           VARCHAR(100),
    School          VARCHAR(150),
    LicenseNumber   VARCHAR(100),
    NationCode      VARCHAR(10)
);

-- 3. Labs
CREATE TABLE Labs (
    LabID          INT PRIMARY KEY,
    LabName        VARCHAR(150),
    CityID         INT,
    SecurityLevel  INT,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);

-- 4. Units
CREATE TABLE Units (
    UnitID        INT PRIMARY KEY,
    UnitName      VARCHAR(150),
    CityID        INT,
    CommanderID   INT,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID),
    FOREIGN KEY (CommanderID) REFERENCES Alchemists(AlchemistID)
);

-- 5. Missions
CREATE TABLE Missions (
    MissionID     INT PRIMARY KEY,
    MissionCode   VARCHAR(50),
    Year          INT,
    MissionType   VARCHAR(100),
    StartDate     DATE,
    EndDate       DATE,
    Status        VARCHAR(50)
);

-- 6. Artifacts
CREATE TABLE Artifacts (
    ArtifactID      INT PRIMARY KEY,
    Name            VARCHAR(150),
    CreationDate    DATE,
    KnownHistory    TEXT,
    DangerLevel     INT,
    CurrentLocation VARCHAR(150)
);

-- 7. Homunculi
CREATE TABLE Homunculi (
    HomunculusID      INT PRIMARY KEY,
    GivenName         VARCHAR(100),
    CreationMethod    VARCHAR(150),
    ActiveStatus      VARCHAR(50),
    RegenerationIndex INT,
    LabID             INT,
    FOREIGN KEY (LabID) REFERENCES Labs(LabID)
);

-- 8. Ingredients
CREATE TABLE Ingredients (
    IngredientID   INT PRIMARY KEY,
    ChemicalName   VARCHAR(150),
    HazardClass    VARCHAR(50)
);

-- 9. IngredientStock
CREATE TABLE IngredientStock (
    IngredientID   INT,
    StockQuantity  INT,
    LabID          INT,
    PRIMARY KEY (IngredientID, LabID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID),
    FOREIGN KEY (LabID) REFERENCES Labs(LabID)
);

-- 10. Devices
CREATE TABLE Devices (
    DeviceID     INT PRIMARY KEY,
    DeviceName   VARCHAR(150),
    DeviceType   VARCHAR(100),
    LabID        INT,
    FOREIGN KEY (LabID) REFERENCES Labs(LabID)
);

-- 11. MissionLogs
CREATE TABLE MissionLogs (
    MissionID     INT,
    LogSeqNo      INT,
    Timestamp     DATETIME,
    LName         VARCHAR(100),
    Description   TEXT,
    Outcome       VARCHAR(100),
    ReporterID    INT,
    EvidenceRef   VARCHAR(200),
    PRIMARY KEY (MissionID, LogSeqNo),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID),
    FOREIGN KEY (ReporterID) REFERENCES Alchemists(AlchemistID)
);

-- 12. ArtifactAttempts
CREATE TABLE ArtifactAttempts (
    ArtifactID     INT,
    AttemptNo      INT,
    AttemptDate    DATE,
    PerformerID    INT,
    Result         VARCHAR(200),
    Casualties     INT,
    Notes          TEXT,
    EvidenceRef    VARCHAR(200),
    PRIMARY KEY (ArtifactID, AttemptNo),
    FOREIGN KEY (ArtifactID) REFERENCES Artifacts(ArtifactID),
    FOREIGN KEY (PerformerID) REFERENCES Alchemists(AlchemistID)
);

-- 13. AttemptArtifactIngredients
CREATE TABLE AttemptArtifactIngredients (
    AttemptArtifactID   INT,
    AttemptNo           INT,
    IngredientID        INT,
    AlchemistID         INT,
    DeviceID            INT,
    Quantity            DECIMAL(10,2),
    IngredientRole      VARCHAR(100),
    MeasurementUnit     VARCHAR(50),
    PRIMARY KEY (AttemptArtifactID, AttemptNo, IngredientID),
    FOREIGN KEY (AttemptArtifactID, AttemptNo) REFERENCES ArtifactAttempts(ArtifactID, AttemptNo),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID),
    FOREIGN KEY (DeviceID) REFERENCES Devices(DeviceID)
);

-- 14. MissionAssignments
CREATE TABLE MissionAssignments (
    MissionID       INT,
    AlchemistID     INT,
    Role            VARCHAR(100),
    AssignmentDate  DATE,
    PRIMARY KEY (MissionID, AlchemistID),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID)
);

-- 15. MissionUnitAssignments
CREATE TABLE MissionUnitAssignments (
    MissionID   INT,
    AlchemistID INT,
    UnitID      INT,
    PRIMARY KEY (MissionID, AlchemistID, UnitID),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID),
    FOREIGN KEY (UnitID) REFERENCES Units(UnitID)
);

-- 16. MissionLabAssignments
CREATE TABLE MissionLabAssignments (
    MissionID   INT,
    AlchemistID INT,
    LabID       INT,
    PRIMARY KEY (MissionID, AlchemistID, LabID),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID),
    FOREIGN KEY (LabID) REFERENCES Labs(LabID)
);

-- 17. AlchemistCertifications
CREATE TABLE AlchemistCertifications (
    AlchemistID        INT,
    CertificationLevel VARCHAR(50),
    LabID              INT,
    PRIMARY KEY (AlchemistID, CertificationLevel, LabID),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID),
    FOREIGN KEY (LabID) REFERENCES Labs(LabID)
);

-- 18. AlchemistCombatStats
CREATE TABLE AlchemistCombatStats (
    AlchemistID         INT PRIMARY KEY,
    CombatRating        INT,
    FieldExperienceYears INT,
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID)
);

-- 19. AlchemistMissionHistory
CREATE TABLE AlchemistMissionHistory (
    AlchemistID   INT,
    MissionID     INT,
    PRIMARY KEY (AlchemistID, MissionID),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID)
);

-- 20. ForensicsAnalystArtifacts
CREATE TABLE ForensicsAnalystArtifacts (
    ForensicsAnalystID  INT,
    ArtifactID          INT,
    PRIMARY KEY (ForensicsAnalystID, ArtifactID),
    FOREIGN KEY (ForensicsAnalystID) REFERENCES Alchemists(AlchemistID),
    FOREIGN KEY (ArtifactID) REFERENCES Artifacts(ArtifactID)
);

-- 21. AlchemistRankHistory
CREATE TABLE AlchemistRankHistory (
    AlchemistID   INT,
    `Rank`        VARCHAR(100),
    FromDate      DATE,
    ToDate        DATE,
    PRIMARY KEY (AlchemistID, `Rank`, FromDate),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID)
);

-- 22. AlchemistSpecializations
CREATE TABLE AlchemistSpecializations (
    AlchemistID     INT,
    Specialization  VARCHAR(150),
    PRIMARY KEY (AlchemistID, Specialization),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID)
);

-- ============================
-- CITIES
-- ============================
INSERT INTO Cities (CityID, Region, City) VALUES
(1, 'Central Region', 'Central City'),
(2, 'East Region', 'East City'),
(3, 'North Region', 'Briggs Fortress'),
(4, 'South Region', 'Dublith'),
(5, 'West Region', 'Rush Valley'),
(6, 'Xerxes Remnants', 'Xerxes Ruins'),
(7, 'Ishval Region', 'Ishval'),
(8, 'Xing Embassy Region', 'Xing Embassy');

-- ============================
-- ALCHEMISTS
-- ============================
INSERT INTO Alchemists (AlchemistID, FName, MName, LName, School, LicenseNumber, NationCode) VALUES
(100, 'Edward', NULL, 'Elric', 'Amestrian State Alchemy', 'SE-092', 'AM'),
(101, 'Alphonse', NULL, 'Elric', 'Amestrian State Alchemy', 'SE-093', 'AM'),
(102, 'Roy', NULL, 'Mustang', 'Flame Alchemy', 'SE-001', 'AM'),
(103, 'Riza', NULL, 'Hawkeye', 'Ballistics & Field Ops', NULL, 'AM'),
(104, 'Alex', 'Louis', 'Armstrong', 'Armstrong Lineage Alchemy', 'SE-008', 'AM'),
(105, 'Olivier', 'Mira', 'Armstrong', 'Strategic Command', NULL, 'AM'),
(106, 'Maes', NULL, 'Hughes', 'Intelligence', NULL, 'AM'),
(107, 'Marcoh', 'Tim', 'Marcoh', 'Medical Alchemy', 'SE-023', 'AM'),
(108, 'Izumi', NULL, 'Curtis', 'Self-taught/Household Alchemy', NULL, 'AM'),
(109, 'King', NULL, 'Bradley', 'State Military (Adept)', 'SE-002', 'AM'),
(110, 'Van', NULL, 'Hohenheim', 'Philosophical Alchemy', NULL, 'AM'),
(111, 'Kimblee', '—', 'Kimblee', 'Explosive Alchemy', 'SE-045', 'AM'),
(112, 'Scar', NULL, NULL, 'Ishvalan Alchemy (Vengeance)', NULL, 'IS'),
(113, 'Winry', NULL, 'Rockbell', 'Automail Engineering', NULL, 'AM'),
(114, 'May', NULL, 'Chang', 'Xing Alchemy (Alchemy Mixed)', NULL, 'XG'),
(115, 'Ling', NULL, 'Yao', 'Xing Alchemy & Combat', NULL, 'XG'),
(116, 'Lan', NULL, 'Fan', 'Xing Alchemy', NULL, 'XG'),
(117, 'Dante', NULL, NULL, 'Forbidden Alchemy/Occult', NULL, 'OT'),
(118, 'Fuji', NULL, 'Colonel', 'Military Alchemy', NULL, 'AM'),
(119, 'Yoki', NULL, '—', 'Small-time mercenary', NULL, 'AM'),
(120, 'Sol', NULL, 'Fritz', 'Research Alchemy', NULL, 'AM');

-- ============================
-- LABS
-- ============================
INSERT INTO Labs (LabID, LabName, CityID, SecurityLevel) VALUES
(10, 'Central Laboratory No. 3', 1, 5),
(11, 'East Amestris Research Lab', 2, 4),
(12, 'Briggs Research Facility', 3, 4),
(13, 'Dublith Alchemy Workshop', 4, 2),
(14, 'Rush Valley Mining Lab', 5, 3),
(15, 'Central Vault - Artifact Storage', 1, 10),
(16, 'Xing Embassy Lab', 8, 3);

-- ============================
-- UNITS
-- ============================
INSERT INTO Units (UnitID, UnitName, CityID, CommanderID) VALUES
(1, 'Central Command Unit', 1, 102),
(2, 'Briggs Defense Corps', 3, 105),
(3, 'East City Battalion', 2, 104),
(4, 'Dublith Research Escort', 4, 107),
(5, 'Rush Valley Field Team', 5, 104);

-- ============================
-- MISSIONS
-- ============================
INSERT INTO Missions (MissionID, MissionCode, Year, MissionType, StartDate, EndDate, Status) VALUES
(200, 'MS-ALPHA', 1911, 'Reconnaissance', '1911-01-05', '1911-01-10', 'Completed'),
(201, 'MS-BRIGGS-01', 1914, 'Defense', '1914-02-11', '1914-03-01', 'Completed'),
(202, 'MS-LAB3-INV', 1910, 'Investigation', '1910-07-02', '1910-07-14', 'Failed'),
(203, 'MS-DUBLITH-INT', 1912, 'Intelligence', '1912-05-04', '1912-05-20', 'Completed'),
(204, 'MS-RUSH-EX', 1913, 'Extraction', '1913-09-01', '1913-09-10', 'Completed'),
(205, 'MS-ISHVAL-REC', 1911, 'Recovery', '1911-06-01', '1911-06-30', 'Completed'),
(206, 'MS-XERXES-ARC', 1910, 'Archaeology', '1910-06-01', '1910-08-01', 'Failed'),
(207, 'MS-VAULT-SEC', 1915, 'Security', '1915-01-15', '1915-01-20', 'Completed'),
(208, 'MS-CENTRAL-TRAIN', 1916, 'Training', '1916-03-01', '1916-03-15', 'Completed'),
(209, 'MS-XING-OBS', 1917, 'Diplomatic', '1917-04-01', '1917-04-07', 'Completed');

-- ============================
-- ARTIFACTS
-- ============================
INSERT INTO Artifacts (ArtifactID, Name, CreationDate, KnownHistory, DangerLevel, CurrentLocation) VALUES
(500, 'Incomplete Philosopher''s Stone', '1910-06-01', 'Recovered from Laboratory 5 during experiments', 10, 'Central Vault - Artifact Storage'),
(501, 'Ishvalan Transmutation Notes', '1905-03-15', 'Civil War era documents', 7, 'East City Archives'),
(502, 'Briggs Ice Wall Array', '1913-12-12', 'Defensive structure component', 4, 'Briggs Fortress - Armory'),
(503, 'Automail Schematic (Prototype)', '1908-01-01', 'Winry Rockbell prototype', 2, 'Dublith Workshop'),
(504, 'Stone Fragment (Unknown)', '1909-11-20', 'Recovered near Xerxes site', 9, 'Rush Valley Lab'),
(505, 'Transmutation Circle Tablet', '1903-02-18', 'Ancient circle etched on tablet', 6, 'Xing Embassy Lab'),
(506, 'Father''s Vessel Sample', '1910-05-20', 'Biological sample with abnormal properties', 10, 'Central Vault - Artifact Storage');

-- ============================
-- HOMUNCULI
-- ============================
INSERT INTO Homunculi (HomunculusID, GivenName, CreationMethod, ActiveStatus, RegenerationIndex, LabID) VALUES
(600, 'Lust', 'Father''s Creation', 'Active', 80, 10),
(601, 'Envy', 'Father''s Creation', 'Active', 95, 10),
(602, 'Gluttony', 'Father''s Creation', 'Active', 60, 10),
(603, 'Greed', 'Father''s Creation', 'Decommissioned', 85, 11),
(604, 'Sloth', 'Father''s Creation', 'Dormant', 70, 12),
(605, 'Pride', 'Father''s Creation', 'Active', 100, 10),
(606, 'Wrath', 'State-created avatar (Bradley)', 'Active', 90, 15),
(607, 'Homunculus-Unknown-A', 'Experimental Homunculus', 'Contained', 40, 15);

-- ============================
-- INGREDIENTS
-- ============================
INSERT INTO Ingredients (IngredientID, ChemicalName, HazardClass) VALUES
(400, 'Red Stone (Imitation)', 'High'),
(401, 'Carbon Powder', 'Low'),
(402, 'Soul-based Catalyst', 'Extreme'),
(403, 'Philosopher''s Alloy Shavings', 'Extreme'),
(404, 'Alkahest Concentrate', 'High'),
(405, 'Stabilizing Gel', 'Medium'),
(406, 'Blood Residue (Preserved)', 'High'),
(407, 'Ancient Mineral Dust', 'Medium'),
(408, 'Automail-grade Steel', 'Low'),
(409, 'Sealing Resin', 'Medium'),
(410, 'Xing Herbal Extract', 'Low');

-- ============================
-- INGREDIENT STOCK (base)
-- ============================
INSERT INTO IngredientStock (IngredientID, StockQuantity, LabID) VALUES
(400, 25, 10),
(401, 500, 10),
(402, 3, 10),
(403, 1, 15),
(404, 8, 11),
(405, 120, 13),
(406, 7, 10),
(407, 40, 14),
(408, 200, 13),
(409, 60, 15),
(410, 90, 16);

-- ============================
-- DEVICES
-- ============================
INSERT INTO Devices (DeviceID, DeviceName, DeviceType, LabID) VALUES
(300, 'Transmutation Amplifier', 'Alchemy Device', 10),
(301, 'Philosopher''s Stone Analyzer', 'Research', 10),
(302, 'Cold Resistance Engine', 'Engineering', 12),
(303, 'Automail Fabricator Mk I', 'Manufacturing', 13),
(304, 'Sealing Matrix', 'Containment', 15),
(305, 'Soul Residue Microscope', 'Research', 11),
(306, 'Field Transmutation Array', 'Field Device', 10),
(307, 'Xing Herbal Distiller', 'Research', 16);

-- ============================
-- MISSION LOGS
-- ============================
INSERT INTO MissionLogs (MissionID, LogSeqNo, Timestamp, LName, Description, Outcome, ReporterID, EvidenceRef) VALUES
(202, 1, '1910-07-03 10:00:00', 'Mustang', 'Entered Laboratory 3. Strong odor of blood.', 'Ongoing', 102, 'LR-201'),
(202, 2, '1910-07-05 14:30:00', 'Hawkeye', 'Confirmed presence of artificial human experiments.', 'Critical', 103, 'LR-202'),
(200, 1, '1911-01-06 09:00:00', 'Elric', 'Recon sweep complete; no hostile activity.', 'Success', 100, 'LR-150'),
(201, 1, '1914-02-12 08:20:00', 'Armstrong', 'Briggs fortifications engaged; defensive lines stable.', 'Success', 104, 'LR-311'),
(205, 1, '1911-06-05 12:00:00', 'Marcoh', 'Ishval recovery team retrieved relics.', 'Success', 107, 'LR-502'),
(206, 1, '1910-06-10 11:50:00', 'Hohenheim', 'Xerxes site shows signs of mass transmutation.', 'Failed', 110, 'LR-601'),
(207, 1, '1915-01-16 09:15:00', 'Bradley', 'Vault security review completed; increased seals applied.', 'Success', 109, 'LR-710');

-- ============================
-- ARTIFACT ATTEMPTS
-- ============================
INSERT INTO ArtifactAttempts (ArtifactID, AttemptNo, AttemptDate, PerformerID, Result, Casualties, Notes, EvidenceRef) VALUES
(500, 1, '1910-07-10', 107, 'Partial success', 0, 'Stone remained unstable; partial energy output recorded', 'EV-001'),
(500, 2, '1910-07-13', 112, 'Catastrophic failure', 24, 'Explosion destroyed test chamber; high casualties', 'EV-002'),
(504, 1, '1909-12-01', 110, 'Analytical success', 0, 'Identified mineral composition related to Xerxes', 'EV-101'),
(503, 1, '1908-02-10', 113, 'Prototype completed', 0, 'Automail schematic proven workable', 'EV-201');

-- ============================
-- ATTEMPT ARTIFACT INGREDIENTS
-- Note: AttemptArtifactID corresponds to ArtifactID
-- ============================
INSERT INTO AttemptArtifactIngredients (AttemptArtifactID, AttemptNo, IngredientID, AlchemistID, DeviceID, Quantity, IngredientRole, MeasurementUnit) VALUES
(500, 1, 400, 107, 301, 10.50, 'Catalyst', 'grams'),
(500, 2, 402, 112, 300, 1.00, 'Core ingredient', 'unit'),
(500, 1, 403, 107, 301, 0.25, 'Concentrate', 'grams'),
(504, 1, 407, 110, 305, 5.00, 'Mineral sample', 'grams'),
(503, 1, 408, 113, 303, 12.00, 'Structural metal', 'kg');

-- ============================
-- MISSION ASSIGNMENTS
-- ============================
INSERT INTO MissionAssignments (MissionID, AlchemistID, Role, AssignmentDate) VALUES
(200, 100, 'Field Alchemist', '1911-01-05'),
(200, 101, 'Support', '1911-01-05'),
(202, 102, 'Investigator', '1910-07-02'),
(202, 103, 'Sniper Support', '1910-07-02'),
(201, 104, 'Defense Commander', '1914-02-11'),
(201, 105, 'Garrison Commander', '1914-02-11'),
(205, 107, 'Medical Recovery Lead', '1911-06-01'),
(206, 110, 'Archaeology Lead', '1910-06-01'),
(207, 109, 'Vault Security Lead', '1915-01-15'),
(209, 114, 'Diplomatic Liaison', '1917-04-01');

-- ============================
-- MISSION UNIT ASSIGNMENTS (cleaned: removed duplicate (209,114,3))
-- ============================
INSERT INTO MissionUnitAssignments (MissionID, AlchemistID, UnitID) VALUES
(201, 104, 2),
(201, 105, 2),
(200, 102, 1),
(205, 107, 4),
(204, 104, 5);

-- (additional unit assignments)
INSERT INTO MissionUnitAssignments (MissionID, AlchemistID, UnitID) VALUES
(203, 107, 4),
(203, 102, 1);

-- ============================
-- MISSION LAB ASSIGNMENTS
-- ============================
INSERT INTO MissionLabAssignments (MissionID, AlchemistID, LabID) VALUES
(202, 102, 10),
(202, 107, 10),
(206, 110, 14),
(203, 107, 11),
(207, 109, 15);

-- ============================
-- ALCHEMIST CERTIFICATIONS
-- ============================
INSERT INTO AlchemistCertifications (AlchemistID, CertificationLevel, LabID) VALUES
(100, 'State Alchemist', 10),
(102, 'State Alchemist', 10),
(104, 'State Alchemist', 10),
(107, 'Medical Alchemist', 11),
(111, 'State Research Alchemist', 11),
(113, 'Automail Engineer (Honorary)', 13);

-- ============================
-- ALCHEMIST COMBAT STATS
-- ============================
INSERT INTO AlchemistCombatStats (AlchemistID, CombatRating, FieldExperienceYears) VALUES
(100, 85, 4),
(101, 70, 4),
(102, 93, 12),
(103, 88, 11),
(104, 88, 12),
(109, 95, 20),
(110, 90, 50),
(111, 86, 7),
(107, 65, 20);

-- ============================
-- ALCHEMIST MISSION HISTORY
-- ============================
INSERT INTO AlchemistMissionHistory (AlchemistID, MissionID) VALUES
(100, 200),
(101, 200),
(102, 202),
(102, 200),
(104, 201),
(105, 201),
(107, 205),
(110, 206),
(109, 207);
-- (114, 209);

-- ============================
-- FORENSICS ANALYST - ARTIFACT LINKS
-- ============================
INSERT INTO ForensicsAnalystArtifacts (ForensicsAnalystID, ArtifactID) VALUES
(107, 500),
(107, 501),
(111, 506);

-- ============================
-- ALCHEMIST RANK HISTORY
-- ============================
INSERT INTO AlchemistRankHistory (AlchemistID, `Rank`, FromDate, ToDate) VALUES
(102, 'Captain', '1907-01-01', '1909-12-31'),
(102, 'Colonel', '1910-01-01', '1913-12-31'),
(102, 'Brigadier General', '1914-01-01', NULL),
(109, 'Major', '1898-01-01', '1909-12-31'),
(109, 'Colonel', '1910-01-01', '1912-12-31'),
(109, 'Fuhrer', '1913-01-01', NULL),
(104, 'Lieutenant', '1906-01-01', '1910-12-31'),
(104, 'Captain', '1911-01-01', NULL);

-- ============================
-- ALCHEMIST SPECIALIZATIONS
-- ============================
INSERT INTO AlchemistSpecializations (AlchemistID, Specialization) VALUES
(100, 'Transmutation: Limb Restoration'),
(100, 'Alchemy Research'),
(101, 'Transmutation: Armor Binding'),
(102, 'Flame-based Alchemy'),
(103, 'Ballistics & Tactical Marksman'),
(104, 'Physical Alchemy / Strength Enhancement'),
(107, 'Medical Transmutation / Records'),
(110, 'Philosophical & Ancient Alchemy');

-- ============================
-- ADDITIONAL MISSION LOGS / ATTEMPTS / ASSIGNMENTS TO ENRICH DATA
-- ============================
INSERT INTO MissionLogs (MissionID, LogSeqNo, Timestamp, LName, Description, Outcome, ReporterID, EvidenceRef) VALUES
(204, 1, '1913-09-02 08:00:00', 'Armstrong', 'Extraction team secured artifact fragments at Rush Valley mine.', 'Success', 104, 'LR-411'),
(205, 2, '1911-06-12 13:20:00', 'Marcoh', 'Recovered biological samples consistent with Philosopher''s Stone synthesis.', 'Success', 107, 'LR-504'),
(206, 2, '1910-07-01 16:00:00', 'Hohenheim', 'Found evidence of mass sacrifice underlying Xerxes collapse.', 'Critical', 110, 'LR-608');

INSERT INTO ArtifactAttempts (ArtifactID, AttemptNo, AttemptDate, PerformerID, Result, Casualties, Notes, EvidenceRef) VALUES
(506, 1, '1910-06-20', 111, 'Contained sample analysis', 0, 'Unusual vessel biology; did not react to standard transmutation tests', 'EV-900'),
(501, 1, '1905-04-02', 107, 'Preservation & translation', 0, 'Translated unknown script; useful for Ishval study', 'EV-450');

INSERT INTO AttemptArtifactIngredients (AttemptArtifactID, AttemptNo, IngredientID, AlchemistID, DeviceID, Quantity, IngredientRole, MeasurementUnit) VALUES
(506, 1, 406, 111, 305, 2.00, 'Biological residue', 'ml'),
(501, 1, 407, 107, 305, 10.00, 'Document ink residue', 'grams');

-- ============================
-- MISSION UNIT / LAB / ASSIGNMENTS (extra)
-- ============================
-- (kept non-duplicates; removed only the extra duplicate earlier)
-- INSERT INTO MissionUnitAssignments (MissionID, AlchemistID, UnitID) VALUES
-- (203, 107, 4),
-- (203, 102, 1);

-- INSERT INTO MissionLabAssignments (MissionID, AlchemistID, LabID) VALUES
-- (204, 104, 14),
-- (203, 107, 11),
-- (209, 114, 16);

-- ============================
-- EXTRA CERTIFICATIONS / SPECIAL CASES
-- ============================
INSERT INTO AlchemistCertifications (AlchemistID, CertificationLevel, LabID) VALUES
(110, 'Ancient Transmutation Specialist', 15),
(113, 'Automail Master', 13),
(114, 'Xing Diplomatic Alchemy', 16);

-- ============================
-- MORE HOMUNCULI / LINKED EVENTS
-- ============================
INSERT INTO Homunculi (HomunculusID, GivenName, CreationMethod, ActiveStatus, RegenerationIndex, LabID) VALUES
(608, 'Homunculus-Prototype-B', 'Experimental', 'Contained', 30, 15),
(609, 'Homunculus-Prototype-C', 'Experimental', 'Decommissioned', 20, 15);

INSERT INTO ForensicsAnalystArtifacts (ForensicsAnalystID, ArtifactID) VALUES
(107, 504),
(107, 505);

-- ============================
-- MORE INGREDIENT STOCK ADJUSTMENTS (cleaned: removed duplicate INSERTs)
-- ============================
-- kept only the new, non-duplicate entry (404,2,15)
INSERT INTO IngredientStock (IngredientID, StockQuantity, LabID) VALUES
(404, 2, 15);

-- ============================
-- ADDITIONAL ALCHEMIST STATS / HISTORY ITEMS
-- ============================
INSERT INTO AlchemistCombatStats (AlchemistID, CombatRating, FieldExperienceYears) VALUES
(113, 60, 8),
(114, 50, 5),
(115, 75, 10);

INSERT INTO AlchemistMissionHistory (AlchemistID, MissionID) VALUES
(113, 204),
(114, 209),
(115, 209);

-- ============================
-- FINAL TOUCHES - extra Missions and small fillers
-- ============================
INSERT INTO Missions (MissionID, MissionCode, Year, MissionType, StartDate, EndDate, Status) VALUES
(210, 'MS-RELIC-SEC', 1918, 'Relic Recovery', '1918-05-01', '1918-05-25', 'Completed'),
(211, 'MS-EXP-TEST', 1919, 'Experimental', '1919-02-01', '1919-02-03', 'Cancelled');

INSERT INTO MissionAssignments (MissionID, AlchemistID, Role, AssignmentDate) VALUES
(210, 110, 'Relic Lead', '1918-05-01'),
(210, 107, 'Medical Support', '1918-05-01'),
(211, 111, 'Explosive Testing', '1919-02-01');

-- ============================
-- SAMPLE DATA COMPLETE (cleaned)
-- ============================
