package com.cityhospital.util;

public final class AppUtil {
    private AppUtil() {
    }

    public static String doctorCode(int id) {
        return "D-" + (100 + id);
    }

    public static String patientCode(int id) {
        return "P-" + (2000 + id);
    }

    public static String appointmentCode(int id) {
        return "A-" + (1041 + id);
    }

    public static String prescriptionCode(int id) {
        return "RX-" + (500 + id);
    }

    public static String billCode(int id) {
        return "B-" + (9000 + id);
    }

    public static double parseDouble(String value) {
        if (value == null || value.isBlank()) {
            return 0;
        }
        return Double.parseDouble(value.trim());
    }

    public static int parseInt(String value) {
        if (value == null || value.isBlank()) {
            return 0;
        }
        return Integer.parseInt(value.trim());
    }
}
