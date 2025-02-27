package com.ai_email_assistant.app;

import lombok.Data;

@Data
public class EmailRequest {
    private String emailContent;
    private String tone;
}