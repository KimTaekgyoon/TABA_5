package taba.menutranslator.controller;


import org.springframework.web.bind.annotation.*;
import taba.menutranslator.dto.ImageResponse;
import taba.menutranslator.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/api/images")
public class MenuController {

    @Autowired
    MenuService menuService;

    //이미지 저장
    @PostMapping("/upload/save")
    public ResponseEntity<String> uploadSaveImage(@RequestParam("image") MultipartFile image) {
        try {
            String imageUrl = menuService.saveImage(image);
            return ResponseEntity.status(HttpStatus.OK).body("Image uploaded successfully");
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to upload image");
        }
    }

    //이미지 플라스크 연동
    @PostMapping("/upload/flask")
    public ResponseEntity<String> uploadFlaskImage(@RequestParam("image") MultipartFile image) {
        try {
            String response = menuService.sendImageToFlask(image);
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to upload image");
        }
    }

    //OCR 플라스크 연동
    @PostMapping("/upload/save-and-flask")
    public ResponseEntity<String> uploadImage(@RequestParam("image") MultipartFile image) {
        try {
            String imageUrl = menuService.saveAndSendImage(image);
            return ResponseEntity.ok(imageUrl);
        } catch (IOException e) {
            return ResponseEntity.status(500).body("Failed to upload image: " + e.getMessage());
        }
    }
}
