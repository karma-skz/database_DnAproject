DROP DATABASE IF EXISTS fma;
CREATE DATABASE fma;
USE fma;

-- =============================
-- 1. Cities (Normalized Location)
-- =============================
CREATE TABLE Cities (
    CityID   INT PRIMARY KEY,
    City     VARCHAR(100) NOT NULL,
    Region   VARCHAR(100) NOT NULL
);

-- =============================
-- 2. Alchemists (Superclass)
-- =============================
CREATE TABLE Alchemists (
    AlchemistID     INT PRIMARY KEY,
    FName           VARCHAR(100) NOT NULL,
    MName           VARCHAR(100),
    LName           VARCHAR(100),
    School          VARCHAR(150),
    LicenseNumber   VARCHAR(100),
    NationCode      VARCHAR(10)
);

-- =============================
-- 3. Research Labs
-- =============================
CREATE TABLE Labs (
    LabID          INT PRIMARY KEY,
    LabName        VARCHAR(150) NOT NULL,
    CityID         INT NOT NULL,
    SecurityLevel  INT NOT NULL,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);

-- =============================
-- 4. Military Units
-- =============================
CREATE TABLE Units (
    UnitID        INT PRIMARY KEY,
    UnitName      VARCHAR(150) NOT NULL,
    CityID        INT NOT NULL,
    CommanderID   INT,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID),
    FOREIGN KEY (CommanderID) REFERENCES Alchemists(AlchemistID)
);

-- =============================
-- 5. Missions (MissionCode + Year)
-- =============================
CREATE TABLE Missions (
    MissionID     INT PRIMARY KEY,
    MissionCode   VARCHAR(50) NOT NULL,
    Year          INT NOT NULL,
    MissionType   VARCHAR(100) NOT NULL,
    StartDate     DATE NOT NULL,
    EndDate       DATE,
    Status        VARCHAR(50) NOT NULL,
    CHECK (EndDate IS NULL OR EndDate >= StartDate)
);

-- =============================
-- 6. Artifacts
-- =============================
CREATE TABLE Artifacts (
    ArtifactID      INT PRIMARY KEY,
    Name            VARCHAR(150) NOT NULL,
    CreationDate    DATE,
    KnownHistory    TEXT,
    DangerLevel     INT NOT NULL,
    LabID           INT,
    FOREIGN KEY (LabID) REFERENCES Labs(LabID)
);

-- =============================
-- 7. Homunculi
-- =============================
CREATE TABLE Homunculi (
    HomunculusID      INT PRIMARY KEY,
    GivenName         VARCHAR(100),
    CreationMethod    VARCHAR(150),
    ActiveStatus      VARCHAR(50),
    RegenerationIndex INT NOT NULL,
    LabID             INT,
    FOREIGN KEY (LabID) REFERENCES Labs(LabID)
);

-- =============================
-- 8. Ingredients
-- =============================
CREATE TABLE Ingredients (
    IngredientID   INT PRIMARY KEY,
    ChemicalName   VARCHAR(150) NOT NULL,
    HazardClass    VARCHAR(50) NOT NULL
);

-- ==========================================
-- 9. Ingredient Stock (Normalized from Ingredient)
-- ==========================================
CREATE TABLE IngredientStock (
    IngredientID   INT NOT NULL,
    LabID          INT NOT NULL,
    StockQuantity  INT NOT NULL,
    PRIMARY KEY (IngredientID, LabID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID),
    FOREIGN KEY (LabID) REFERENCES Labs(LabID)
);

-- =============================
-- 10. Alchemical Devices
-- =============================
CREATE TABLE Devices (
    DeviceID     INT PRIMARY KEY,
    DeviceName   VARCHAR(150) NOT NULL,
    DeviceType   VARCHAR(100) NOT NULL,
    LabID        INT NOT NULL,
    FOREIGN KEY (LabID) REFERENCES Labs(LabID)
);

-- =============================
-- 11. Mission Logs (Weak Entity)
-- =============================
CREATE TABLE MissionLogs (
    MissionID     INT NOT NULL,
    LogSeqNo      INT NOT NULL,
    Timestamp     DATETIME NOT NULL,
    ReporterID    INT NOT NULL,
    Description   TEXT,
    Outcome       VARCHAR(100),
    EvidenceRef   VARCHAR(200),
    PRIMARY KEY (MissionID, LogSeqNo),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID) ON DELETE CASCADE,
    FOREIGN KEY (ReporterID) REFERENCES Alchemists(AlchemistID)
);

-- =============================================
-- 12. Transmutation Attempts (Weak Entity)
-- =============================================
CREATE TABLE TransmutationAttempts (
    ArtifactID     INT NOT NULL,
    AttemptNo      INT NOT NULL,
    AttemptDate    DATE NOT NULL,
    PerformerID    INT NOT NULL,
    Result         VARCHAR(200),
    Casualties     INT,
    Notes          TEXT,
    EvidenceRef    VARCHAR(200),
    PRIMARY KEY (ArtifactID, AttemptNo),
    FOREIGN KEY (ArtifactID) REFERENCES Artifacts(ArtifactID) ON DELETE CASCADE,
    FOREIGN KEY (PerformerID) REFERENCES Alchemists(AlchemistID)
);

-- =====================================================
-- 13. UseOfIngredientInExperiment (N=4 Relationship)
-- =====================================================
CREATE TABLE AttemptArtifactIngredients (
    ArtifactID       INT NOT NULL,
    AttemptNo        INT NOT NULL,
    IngredientID     INT NOT NULL,
    AlchemistID      INT NOT NULL,
    DeviceID         INT NOT NULL,
    Quantity         DECIMAL(10,2),
    IngredientRole   VARCHAR(100),
    MeasurementUnit  VARCHAR(50),
    PRIMARY KEY (ArtifactID, AttemptNo, IngredientID, AlchemistID, DeviceID),
    FOREIGN KEY (ArtifactID, AttemptNo)
        REFERENCES TransmutationAttempts(ArtifactID, AttemptNo)
        ON DELETE CASCADE,
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID),
    FOREIGN KEY (DeviceID) REFERENCES Devices(DeviceID)
);

-- =====================================================
-- 14A. MissionAssignment (Roles, Dates)
-- =====================================================
CREATE TABLE MissionAssignment (
    MissionID       INT NOT NULL,
    AlchemistID     INT NOT NULL,
    Role            VARCHAR(100),
    AssignmentDate  DATE,
    PRIMARY KEY (MissionID, AlchemistID),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID)
);

-- =====================================================
-- 14B. MissionAssignmentUnit (Split for 3NF)
-- =====================================================
CREATE TABLE MissionAssignmentUnit (
    MissionID   INT NOT NULL,
    AlchemistID INT NOT NULL,
    UnitID      INT NOT NULL,
    PRIMARY KEY (MissionID, AlchemistID, UnitID),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID),
    FOREIGN KEY (UnitID) REFERENCES Units(UnitID)
);

-- =====================================================
-- 14C. MissionAssignmentLab (Split for 3NF)
-- =====================================================
CREATE TABLE MissionAssignmentLab (
    MissionID   INT NOT NULL,
    AlchemistID INT NOT NULL,
    LabID       INT NOT NULL,
    PRIMARY KEY (MissionID, AlchemistID, LabID),
    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID),
    FOREIGN KEY (LabID) REFERENCES Labs(LabID)
);

-- =============================
-- 15. Subclass: Forensics Analyst
-- =============================
CREATE TABLE ForensicsAnalyst (
    AlchemistID        INT PRIMARY KEY,
    CertificationLevel VARCHAR(50) NOT NULL,
    LabID              INT NOT NULL,
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID),
    FOREIGN KEY (LabID) REFERENCES Labs(LabID)
);

-- =============================
-- 16. Subclass: Field Operative
-- =============================
CREATE TABLE FieldOperative (
    AlchemistID          INT PRIMARY KEY,
    CombatRating         INT NOT NULL,
    FieldExperienceYears INT NOT NULL,
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID)
);

-- =============================
-- 17. AlchemistMissionHistory (AssignedTo)
-- =============================
CREATE TABLE AlchemistMissionHistory (
    AlchemistID INT NOT NULL,
    MissionID   INT NOT NULL,
    PRIMARY KEY (AlchemistID, MissionID),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID),    FOREIGN KEY (MissionID) REFERENCES Missions(MissionID)
);

-- =============================
-- 18. ForensicsAnalystArtifacts (Examines M:N)
-- =============================
CREATE TABLE ForensicsAnalystArtifacts (
    AlchemistID INT NOT NULL,
    ArtifactID  INT NOT NULL,
    PRIMARY KEY (AlchemistID, ArtifactID),
    FOREIGN KEY (AlchemistID) REFERENCES ForensicsAnalyst(AlchemistID),
    FOREIGN KEY (ArtifactID) REFERENCES Artifacts(ArtifactID)
);

-- =============================
-- 19. AlchemistRankHistory (Multivalued Attribute)
-- =============================
CREATE TABLE AlchemistRankHistory (
    AlchemistID INT NOT NULL,
    `Rank`        VARCHAR(100) NOT NULL,
    FromDate    DATE NOT NULL,
    ToDate      DATE,
    PRIMARY KEY (AlchemistID, `Rank`, FromDate),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID)
);

-- =============================
-- 20. AlchemistSpecializations (Multivalued Attribute)
-- =============================
CREATE TABLE AlchemistSpecializations (
    AlchemistID    INT NOT NULL,
    Specialization VARCHAR(150) NOT NULL,
    PRIMARY KEY (AlchemistID, Specialization),
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID)
);
