CREATE DATABASE if not exists PlacementSystem;
USE PlacementSystem;

-- 1. Create Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Major VARCHAR(50),
    GPA DECIMAL(3, 2),
    GraduationYear INT,
    IsAlumni BOOLEAN DEFAULT FALSE,
    Status ENUM('Unplaced', 'Placed', 'Higher Studies') DEFAULT 'Unplaced'
);

-- 2. Create Companies Table
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    Tier ENUM('Product', 'Service', 'Startup'),
    BaseSalary_LPA DECIMAL(5, 2)
);

-- 3. Create Placements Table (The Transaction Table)
CREATE TABLE Placements (
    PlacementID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CompanyID INT,
    OfferedPackage_LPA DECIMAL(5, 2),
    PlacementDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);
INSERT INTO Students (StudentID, FullName, Major, GPA, GraduationYear, IsAlumni, Status) VALUES
(101, 'Ibrahim Khan', 'Computer Science', 3.85, 2026, 0, 'Unplaced'),
(102, 'Arjun Mehta', 'Computer Science', 3.90, 2025, 1, 'Placed'),
(103, 'Sara Ahmed', 'Electronics', 3.20, 2025, 1, 'Placed'),
(104, 'Rohan Das', 'Computer Science', 3.50, 2026, 0, 'Unplaced'),
(105, 'Priya Singh', 'Commerce', 3.70, 2025, 1, 'Higher Studies'),
(106, 'Kevin Joy', 'Computer Science', 2.90, 2025, 1, 'Placed'),
(107, 'Ananya Ray', 'Computer Science', 3.95, 2026, 0, 'Unplaced'),
(108, 'Zaid Shaikh', 'Information Technology', 3.40, 2025, 1, 'Placed'),
(109, 'Mehak Gill', 'Computer Science', 3.65, 2025, 1, 'Placed'),
(110, 'Rahul Varma', 'Mechanical', 3.10, 2024, 1, 'Placed'),
(111, 'Sana Khan', 'Computer Science', 3.80, 2026, 0, 'Unplaced'),
(112, 'Amit Shah', 'Electronics', 2.80, 2025, 1, 'Unplaced'),
(113, 'Vikram Seth', 'Computer Science', 3.45, 2025, 1, 'Placed'),
(114, 'Nisha Goel', 'Information Technology', 3.75, 2026, 0, 'Unplaced'),
(115, 'Siddharth M', 'Computer Science', 3.25, 2025, 1, 'Placed'),
(116, 'Riya Kapoor', 'Commerce', 3.60, 2025, 1, 'Placed'),
(117, 'Aman Gupta', 'Computer Science', 3.15, 2024, 1, 'Placed'),
(118, 'Karan Johar', 'Mechanical', 3.35, 2025, 1, 'Unplaced'),
(119, 'Ishani L', 'Computer Science', 3.92, 2026, 0, 'Unplaced'),
(120, 'Varun Dhawan', 'Information Technology', 3.05, 2025, 1, 'Placed');

INSERT INTO Companies (CompanyID, CompanyName, Tier, BaseSalary_LPA) VALUES
(1, 'Apple', 'Product', 35.00),
(2, 'EXL', 'Service', 4.50),
(3, 'Zomato', 'Startup', 18.00),
(4, 'Infosys', 'Service', 4.00),
(5, 'Microsoft', 'Product', 42.00),
(6, 'Amazon', 'Product', 32.00),
(7, 'Wipro', 'Service', 4.20),
(8, 'Swiggy', 'Startup', 15.50),
(9, 'Adobe', 'Product', 28.00),
(10, 'Accenture', 'Service', 5.50);




INSERT INTO Placements (StudentID, CompanyID, OfferedPackage_LPA, PlacementDate) VALUES
(102, 1, 38.00, '2025-01-15'),
(103, 2, 4.80, '2025-02-10'),
(106, 4, 4.20, '2025-03-05'),
(108, 3, 19.50, '2025-01-20'),
(109, 5, 45.00, '2025-02-25'),
(110, 7, 4.50, '2024-11-15'),
(113, 8, 16.00, '2025-01-12'),
(115, 10, 6.00, '2025-03-20'),
(116, 2, 4.50, '2025-02-15'),
(117, 6, 33.00, '2024-12-01'),
(120, 4, 4.10, '2025-01-30'),
(102, 5, 40.00, '2025-04-10'), -- Some students might have multiple offers
(108, 9, 29.00, '2025-05-15'),
(106, 2, 4.50, '2025-01-05'),
(113, 3, 17.50, '2025-02-28'),
(115, 6, 31.00, '2025-03-12'),
(117, 9, 27.50, '2024-11-20'),
(110, 10, 5.80, '2024-12-15'),
(109, 1, 36.00, '2025-01-22'),
(103, 7, 4.30, '2025-02-18');

SELECT * FROM Students ORDER BY StudentID DESC;
# Which company tiers are paying the best for each major
SELECT 
    s.Major, 
    c.Tier, 
    COUNT(p.PlacementID) AS Total_Placements,
    ROUND(AVG(p.OfferedPackage_LPA), 2) AS Avg_Package_LPA,
    MAX(p.OfferedPackage_LPA) AS Highest_Package
FROM Students s
JOIN Placements p ON s.StudentID = p.StudentID
JOIN Companies c ON p.CompanyID = c.CompanyID
GROUP BY s.Major, c.Tier
ORDER BY s.Major, Avg_Package_LPA DESC;