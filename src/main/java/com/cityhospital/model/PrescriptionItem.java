package com.cityhospital.model;

public class PrescriptionItem {
    private int id;
    private int prescriptionId;
    private String medicineName;
    private String dosage;

    public PrescriptionItem() {
    }

    public PrescriptionItem(String medicineName, String dosage) {
        this.medicineName = medicineName;
        this.dosage = dosage;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getPrescriptionId() { return prescriptionId; }
    public void setPrescriptionId(int prescriptionId) { this.prescriptionId = prescriptionId; }
    public String getMedicineName() { return medicineName; }
    public void setMedicineName(String medicineName) { this.medicineName = medicineName; }
    public String getDosage() { return dosage; }
    public void setDosage(String dosage) { this.dosage = dosage; }
}
