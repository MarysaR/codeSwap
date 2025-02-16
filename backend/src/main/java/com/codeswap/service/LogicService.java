package com.codeswap.service;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.ResponseEntity;
import java.util.Map;

@Service
public class LogicService {
    private final RestTemplate restTemplate = new RestTemplate();

    public String computeData(String input) {
        String url = "http://logic:5000/compute"; // Utilisation du nom du service Docker
        Map<String, String> request = Map.of("data", input);
        ResponseEntity<Map<String, Object>> response = restTemplate.postForEntity(url, request, (Class<Map<String, Object>>)(Class<?>)Map.class);
        Map<String, Object> responseBody = response.getBody();
        if (responseBody != null && responseBody.containsKey("result")) {
            return responseBody.get("result").toString();
        }
        return null;
    }
}
