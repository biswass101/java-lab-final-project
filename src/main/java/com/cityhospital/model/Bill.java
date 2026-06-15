package com.cityhospital.model;

public class Bill {
    private int id;
    private String billCode;
    private int patientId;
    private String patientName;
    private String billDate;
    private double consultationFee;
    private double medicineCost;
    private double serviceCharge;
    private double totalAmount;
    private String paymentStatus;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getBillCode() { return billCode; }
    public void setBillCode(String billCode) { this.billCode = billCode; }
    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }
    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }
    public String getBillDate() { return billDate; }
    public void setBillDate(String billDate) { this.billDate = billDate; }
    public double getConsultationFee() { return consultationFee; }
    public void setConsultationFee(double consultationFee) { this.consultationFee = consultationFee; }
    public double getMedicineCost() { return medicineCost; }
    public void setMedicineCost(double medicineCost) { this.medicineCost = medicineCost; }
    public double getServiceCharge() { return serviceCharge; }
    public void setServiceCharge(double serviceCharge) { this.serviceCharge = serviceCharge; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
}
