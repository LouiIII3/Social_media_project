package com.example.social.media;

import lombok.Data;

@Data
public class PasswordUpdateRequest {
    private String userid;
    private String currentPassword;
    private String newPassword;
    private String confirmPassword;
}
