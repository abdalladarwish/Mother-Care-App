package com.server.mothercare.models;

import lombok.Data;

@Data
public class Error {
    private String error;
    private String error_description;

    public Error(String error, String error_description){
        this.error = error;
        this.error_description = error_description;
    }
}
