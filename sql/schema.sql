CREATE DATABASE IF NOT EXISTS city_hospital_db;
USE city_hospital_db;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(30) NOT NULL DEFAULT 'Administrator'
);

CREATE TABLE IF NOT EXISTS hospital_settings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    hospital_name VARCHAR(120) NOT NULL,
    contact_number VARCHAR(40),
    address VARCHAR(255),
    email VARCHAR(120)
);

CREATE TABLE IF NOT EXISTS doctors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(120) NOT NULL,
    specialization VARCHAR(80) NOT NULL,
    phone VARCHAR(30),
    email VARCHAR(120),
    available_days VARCHAR(120),
    consultation_fee DECIMAL(10,2) DEFAULT 0,
    availability VARCHAR(30) DEFAULT 'Available'
);

CREATE TABLE IF NOT EXISTS patients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(120) NOT NULL,
    age INT,
    gender VARCHAR(20),
    phone VARCHAR(30),
    blood_group VARCHAR(10),
    email VARCHAR(120),
    address VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS appointments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_code VARCHAR(20) NOT NULL UNIQUE,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    reason TEXT,
    status VARCHAR(30) DEFAULT 'Pending',
    CONSTRAINT fk_appointments_patient FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    CONSTRAINT fk_appointments_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS prescriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    prescription_code VARCHAR(20) NOT NULL UNIQUE,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    prescription_date DATE NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    medicine_name VARCHAR(255),
    dosage VARCHAR(255),
    instructions TEXT,
    CONSTRAINT fk_prescriptions_patient FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    CONSTRAINT fk_prescriptions_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS prescription_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    prescription_id INT NOT NULL,
    medicine_name VARCHAR(255) NOT NULL,
    dosage VARCHAR(255),
    CONSTRAINT fk_prescription_items_prescription FOREIGN KEY (prescription_id) REFERENCES prescriptions(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS bills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    bill_code VARCHAR(20) NOT NULL UNIQUE,
    patient_id INT NOT NULL,
    bill_date DATE NOT NULL,
    consultation_fee DECIMAL(10,2) DEFAULT 0,
    medicine_cost DECIMAL(10,2) DEFAULT 0,
    service_charge DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) DEFAULT 0,
    payment_status VARCHAR(20) DEFAULT 'Unpaid',
    CONSTRAINT fk_bills_patient FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
);

INSERT INTO users (username, password, role)
SELECT 'admin', 'admin', 'Administrator'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'admin');

INSERT INTO hospital_settings (hospital_name, contact_number, address, email)
SELECT 'City Hospital', '+880-2-9876543', 'House 12, Road 7, Dhanmondi, Dhaka 1209, Bangladesh', 'admin@cityhospital.bd'
WHERE NOT EXISTS (SELECT 1 FROM hospital_settings);

INSERT INTO doctors (doctor_code, name, specialization, phone, email, available_days, consultation_fee, availability)
SELECT * FROM (
    SELECT 'D-101', 'Dr. Farhana Akter', 'Cardiology', '+880-1711-223344', 'farhana@cityhospital.bd', 'Sun, Mon, Wed', 900, 'Available' UNION ALL
    SELECT 'D-102', 'Dr. Mahbubur Rahman', 'Orthopedics', '+880-1712-556677', 'mahbubur@cityhospital.bd', 'Sat, Mon, Tue', 850, 'Available' UNION ALL
    SELECT 'D-103', 'Dr. Nusrat Jahan', 'Pediatrics', '+880-1713-889900', 'nusrat@cityhospital.bd', 'Sun, Tue, Thu', 800, 'On Leave' UNION ALL
    SELECT 'D-104', 'Dr. Tanvir Ahmed', 'General Medicine', '+880-1714-112233', 'tanvir@cityhospital.bd', 'Sat, Sun, Mon', 700, 'Available' UNION ALL
    SELECT 'D-105', 'Dr. Sabina Yasmin', 'Dermatology', '+880-1715-445566', 'sabina@cityhospital.bd', 'Mon, Wed, Thu', 950, 'Available'
) AS seed
WHERE NOT EXISTS (SELECT 1 FROM doctors);

INSERT INTO patients (patient_code, name, age, gender, phone, blood_group, email, address)
SELECT * FROM (
    SELECT 'P-2001', 'Rakibul Hasan', 45, 'Male', '+880-1811-234567', 'B+', 'rakibul@example.bd', 'Dhanmondi, Dhaka' UNION ALL
    SELECT 'P-2002', 'Sumaiya Akter', 32, 'Female', '+880-1812-345678', 'O+', 'sumaiya@example.bd', 'Uttara, Dhaka' UNION ALL
    SELECT 'P-2003', 'Mizanur Rahman', 60, 'Male', '+880-1813-456789', 'A-', 'mizanur@example.bd', 'Mirpur, Dhaka' UNION ALL
    SELECT 'P-2004', 'Ayesha Siddika', 28, 'Female', '+880-1814-567890', 'AB+', 'ayesha@example.bd', 'Banani, Dhaka' UNION ALL
    SELECT 'P-2005', 'Imran Hossain', 51, 'Male', '+880-1815-678901', 'O-', 'imran@example.bd', 'Mohakhali, Dhaka' UNION ALL
    SELECT 'P-2006', 'Tahmina Begum', 19, 'Female', '+880-1816-789012', 'B-', 'tahmina@example.bd', 'Bashundhara, Dhaka'
) AS seed
WHERE NOT EXISTS (SELECT 1 FROM patients);

INSERT INTO appointments (appointment_code, patient_id, doctor_id, appointment_date, appointment_time, reason, status)
SELECT * FROM (
    SELECT 'A-1042' AS appointment_code, p1.id AS patient_id, d1.id AS doctor_id, '2026-05-25' AS appointment_date, '10:30:00' AS appointment_time, 'Follow-up for blood pressure' AS reason, 'Confirmed' AS status FROM patients p1, doctors d1 WHERE p1.patient_code='P-2001' AND d1.doctor_code='D-101' UNION ALL
    SELECT 'A-1043', p2.id, d2.id, '2026-05-25', '11:00:00', 'Knee pain checkup', 'Pending' FROM patients p2, doctors d2 WHERE p2.patient_code='P-2002' AND d2.doctor_code='D-102' UNION ALL
    SELECT 'A-1044', p3.id, d3.id, '2026-05-25', '11:45:00', 'Fever consultation', 'Completed' FROM patients p3, doctors d3 WHERE p3.patient_code='P-2003' AND d3.doctor_code='D-103' UNION ALL
    SELECT 'A-1045', p4.id, d1.id, '2026-05-26', '09:00:00', 'Cardio screening', 'Confirmed' FROM patients p4, doctors d1 WHERE p4.patient_code='P-2004' AND d1.doctor_code='D-101' UNION ALL
    SELECT 'A-1046', p5.id, d4.id, '2026-05-26', '10:15:00', 'General health issue', 'Cancelled' FROM patients p5, doctors d4 WHERE p5.patient_code='P-2005' AND d4.doctor_code='D-104' UNION ALL
    SELECT 'A-1047', p6.id, d5.id, '2026-05-27', '15:00:00', 'Skin check', 'Pending' FROM patients p6, doctors d5 WHERE p6.patient_code='P-2006' AND d5.doctor_code='D-105'
) AS seed
WHERE NOT EXISTS (SELECT 1 FROM appointments);

INSERT INTO prescriptions (prescription_code, patient_id, doctor_id, prescription_date, diagnosis, medicine_name, dosage, instructions)
SELECT * FROM (
    SELECT 'RX-501' AS prescription_code, p1.id AS patient_id, d1.id AS doctor_id, '2026-05-20' AS prescription_date, 'Hypertension' AS diagnosis, 'Amlodipine 5mg' AS medicine_name, '1 tablet twice daily' AS dosage, 'Take after meals' AS instructions FROM patients p1, doctors d1 WHERE p1.patient_code='P-2001' AND d1.doctor_code='D-101' UNION ALL
    SELECT 'RX-502', p2.id, d2.id, '2026-05-21', 'Knee Pain', 'Naproxen 250mg', '1 tablet daily', 'Avoid heavy movement' FROM patients p2, doctors d2 WHERE p2.patient_code='P-2002' AND d2.doctor_code='D-102' UNION ALL
    SELECT 'RX-503', p3.id, d4.id, '2026-05-22', 'Viral Fever', 'Paracetamol 500mg', '1 tablet every 8 hours', 'Take plenty of water' FROM patients p3, doctors d4 WHERE p3.patient_code='P-2003' AND d4.doctor_code='D-104' UNION ALL
    SELECT 'RX-504', p4.id, d5.id, '2026-05-23', 'Skin Allergy', 'Cetirizine 10mg', '1 tablet at night', 'Avoid allergens' FROM patients p4, doctors d5 WHERE p4.patient_code='P-2004' AND d5.doctor_code='D-105'
) AS seed
WHERE NOT EXISTS (SELECT 1 FROM prescriptions);

INSERT INTO prescription_items (prescription_id, medicine_name, dosage)
SELECT r.id, r.medicine_name, r.dosage
FROM prescriptions r
WHERE NOT EXISTS (
    SELECT 1 FROM prescription_items pi
    WHERE pi.prescription_id = r.id
);

INSERT INTO bills (bill_code, patient_id, bill_date, consultation_fee, medicine_cost, service_charge, total_amount, payment_status)
SELECT * FROM (
    SELECT 'B-9001', p1.id, '2026-05-20', 500, 1150, 200, 1850, 'Paid' FROM patients p1 WHERE p1.patient_code='P-2001' UNION ALL
    SELECT 'B-9002', p2.id, '2026-05-21', 800, 2200, 200, 3200, 'Unpaid' FROM patients p2 WHERE p2.patient_code='P-2002' UNION ALL
    SELECT 'B-9003', p3.id, '2026-05-22', 400, 350, 200, 950, 'Paid' FROM patients p3 WHERE p3.patient_code='P-2003' UNION ALL
    SELECT 'B-9004', p4.id, '2026-05-23', 700, 1500, 200, 2400, 'Unpaid' FROM patients p4 WHERE p4.patient_code='P-2004' UNION ALL
    SELECT 'B-9005', p5.id, '2026-05-24', 1000, 4400, 200, 5600, 'Paid' FROM patients p5 WHERE p5.patient_code='P-2005'
) AS seed
WHERE NOT EXISTS (SELECT 1 FROM bills);
