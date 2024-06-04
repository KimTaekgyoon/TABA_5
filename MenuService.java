package taba.menutranslator.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.http.client.MultipartBodyBuilder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
public class MenuService {

    @Autowired
    private RestTemplate restTemplate;

    //이미지 로컬 저장 위치
    @Value("${image.upload.dir}") 
    private String uploadDir;

    //사진 url에 포함되는 정보
    @Value("${image.base.url}")
    private String imageBaseUrl;

    //이미지 인식 플라스크
    @Value("${flask.server.url}")
    private String flaskServerUrl;

    //OCR 플라스크
    @Value("http://192.168.0.41:9999/API_GPT_OCR")
    private String flaskServerUrl2;

    //인증키
    @Value("${flask.auth.token}")
    private String flaskAuthToken;


    //이미지 로컬 저장
    public String saveImage(MultipartFile image) throws IOException {
        if (image.isEmpty()) {
            throw new IOException("Empty file");
        }
        // Ensure the upload directory exists
        Path uploadPath = Paths.get(uploadDir);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        byte[] bytes = image.getBytes();
        Path path = Paths.get(uploadDir + File.separator + image.getOriginalFilename());
        Files.write(path, bytes);

        // Return the URL of the saved image
        return imageBaseUrl + "/" + image.getOriginalFilename();
    }


    //이미지 인식 플라스크 연동
    public String sendImageToFlask(MultipartFile image) throws IOException {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);

        MultipartBodyBuilder builder = new MultipartBodyBuilder();
        builder.part("image", image.getResource());

        HttpEntity<?> entity = new HttpEntity<>(builder.build(), headers);

        String flaskEndpoint = flaskServerUrl + "/detect";

        return restTemplate.postForObject(flaskEndpoint, entity, String.class);
    }


    //OCR 연동-수정해야함
    public String saveAndSendImage(MultipartFile image) throws IOException {
        // Save the image locally
        String imageUrl = saveImage(image);

        // Send the image URL to Flask server
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", flaskAuthToken);

        //header = {"Authorization": "myToken1234"}

        String flaskEndpoint = flaskServerUrl2 + "/receive-url";

        // JSON 형식으로 URL 전송
        String jsonRequest = String.format("{\"url\": \"%s\"}", imageUrl);

        HttpEntity<String> entity = new HttpEntity<>(jsonRequest, headers);

        String response = restTemplate.postForObject(flaskEndpoint, entity, String.class);


        // Parse the response JSON
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(response);
        String receivedUrl = root.path("received_url").asText();

        return receivedUrl;
    }

}
