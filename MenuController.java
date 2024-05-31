package taba.menutranslator.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import taba.menutranslator.entity.MenuEntity;
import taba.menutranslator.service.MenuService;

@RestController
public class MenuController {

    @Autowired
    private MenuService menuService;

    @GetMapping("/combined-data")
    public MenuEntity getCombinedData() {
        return menuService.getCombinedData();
    }
}
