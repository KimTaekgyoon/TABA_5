package taba.menutranslator.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import taba.menutranslator.dto.MenuDTO;
import taba.menutranslator.entity.MenuEntity;
import taba.menutranslator.repository.MenuRepository;

@Service
public class MenuService {

    @Autowired
    private MenuRepository menuRepository;

    public MenuEntity getCombinedData() {
        // 플라스크 서버에서 데이터 가져오기
        RestTemplate restTemplate = new RestTemplate();
        String flaskUrl = "http://127.0.0.1:5000/";
        MenuDTO flaskData = restTemplate.getForObject(flaskUrl, MenuDTO.class);

        // 데이터베이스에서 일치하는 데이터 조회
        MenuEntity dbData = menuRepository.findByEname(flaskData.getEname());

        // dbData가 null인 경우 예외 처리
        if (dbData == null) {
            throw new RuntimeException("No data: " + flaskData.getEname());
        }

        // 조합된 데이터 반환
        return dbData;
    }
}
