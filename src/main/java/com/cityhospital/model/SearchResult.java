package com.cityhospital.model;

public class SearchResult {
    private String type;
    private String recordId;
    private String name;
    private String date;
    private String detail;

    public SearchResult(String type, String recordId, String name, String date, String detail) {
        this.type = type;
        this.recordId = recordId;
        this.name = name;
        this.date = date;
        this.detail = detail;
    }

    public String getType() { return type; }
    public String getRecordId() { return recordId; }
    public String getName() { return name; }
    public String getDate() { return date; }
    public String getDetail() { return detail; }
}
