package com.example.social.media;

import lombok.Data;

@Data
public class ErrorResponse {
    private boolean error;
    private  String reason;

    public ErrorResponse(boolean error, String reason) {
        this.error = error;
        this.reason = reason;
    }
}
