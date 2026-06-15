package com.cityhospital.model;

public class DashboardStats {
    private int totalPatients;
    private int totalDoctors;
    private int todayAppointments;
    private int pendingBills;

    public int getTotalPatients() { return totalPatients; }
    public void setTotalPatients(int totalPatients) { this.totalPatients = totalPatients; }
    public int getTotalDoctors() { return totalDoctors; }
    public void setTotalDoctors(int totalDoctors) { this.totalDoctors = totalDoctors; }
    public int getTodayAppointments() { return todayAppointments; }
    public void setTodayAppointments(int todayAppointments) { this.todayAppointments = todayAppointments; }
    public int getPendingBills() { return pendingBills; }
    public void setPendingBills(int pendingBills) { this.pendingBills = pendingBills; }
}
