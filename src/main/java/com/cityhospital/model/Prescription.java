package com.cityhospital.model;

import java.util.ArrayList;
import java.util.List;

public class Prescription {
    private int id;
    private String prescriptionCode;
    private int patientId;
    private int doctorId;
    private String patientName;
    private String doctorName;
    private String prescriptionDate;
    private String diagnosis;
    private String medicineName;
    private String dosage;
    private String instructions;
    private String itemsBlob;
    private String medicinesSummary;
    private List<PrescriptionItem> items = new ArrayList<>();

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getPrescriptionCode() { return prescriptionCode; }
    public void setPrescriptionCode(String prescriptionCode) { this.prescriptionCode = prescriptionCode; }
    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }
    public int getDoctorId() { return doctorId; }
    public void setDoctorId(int doctorId) { this.doctorId = doctorId; }
    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }
    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }
    public String getPrescriptionDate() { return prescriptionDate; }
    public void setPrescriptionDate(String prescriptionDate) { this.prescriptionDate = prescriptionDate; }
    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
    public String getMedicineName() { return medicineName; }
    public void setMedicineName(String medicineName) { this.medicineName = medicineName; }
    public String getDosage() { return dosage; }
    public void setDosage(String dosage) { this.dosage = dosage; }
    public String getInstructions() { return instructions; }
    public void setInstructions(String instructions) { this.instructions = instructions; }
    public String getItemsBlob() { return itemsBlob; }
    public void setItemsBlob(String itemsBlob) { this.itemsBlob = itemsBlob; }
    public String getMedicinesSummary() { return medicinesSummary; }
    public void setMedicinesSummary(String medicinesSummary) { this.medicinesSummary = medicinesSummary; }
    public List<PrescriptionItem> getItems() { return items; }
    public void setItems(List<PrescriptionItem> items) { this.items = items; }
}
