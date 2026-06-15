package com.cityhospital.model;

public class HospitalSetting {
    private int id;
    private String hospitalName;
    private String contactNumber;
    private String address;
    private String email;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getHospitalName() { return hospitalName; }
    public void setHospitalName(String hospitalName) { this.hospitalName = hospitalName; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
