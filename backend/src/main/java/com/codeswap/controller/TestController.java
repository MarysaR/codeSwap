package com.codeswap.controller;

import com.codeswap.service.LogicService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class TestController {
    private final LogicService logicService;

    public TestController(LogicService logicService) {
        this.logicService = logicService;
    }

    @GetMapping("/test")
    public String testLogic() {
        return logicService.computeData("hello");
    }
}

