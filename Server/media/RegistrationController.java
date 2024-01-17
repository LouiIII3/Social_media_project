package com.example.social.media;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;


@RestController
public class RegistrationController {
    @Autowired
    private UserService userService;

    private final JwtTokenProvider jwtTokenProvider = new JwtTokenProvider();

    @PostMapping("/register")
    public ResponseEntity<String> registerUser(@RequestBody User user) {
        String key = user.getKey1();
        String id = user.getUserid();
        String password = user.getPassword();

        // Additional parameters for user registration
        LocalDate birthdate = user.getBirthdate();
        String fullName = user.getNickname();
        String profilePictureUrl = user.getProfilePictureUrl();

        try {
            // Check if userid already exists
            if (userService.isUseridExists(id)) {
                return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 존재하는 UserID입니다.");
            }

            User registeredUser = userService.registerUser(key, id, password, birthdate, fullName, profilePictureUrl);

            if (registeredUser != null) {
                return ResponseEntity.ok(jwtTokenProvider.generateToken(registeredUser.getUserid()));
            } else {
                return ResponseEntity.status(HttpStatus.CONFLICT).body("만료된 키입니다.");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류가 발생했습니다.");
        }
    }


    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody UserLoginRequest loginRequest) {
        String userid = loginRequest.getUserid();
        String password = loginRequest.getPassword();

        if (userid != null && password != null) {
            User user = userService.findUserByUsername(userid);
            if (user != null) {
                BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
                if (passwordEncoder.matches(password, user.getPassword())) {
                    return ResponseEntity.ok(jwtTokenProvider.generateToken(user.getUserid()));
                }
            }
        }

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("로그인 실패");
    }


    @PostMapping("/changePassword")
    public ResponseEntity<String> updatePassword(@RequestBody PasswordUpdateRequest passwordUpdateRequest, @RequestHeader("Authorization") String authorizationHeader) {
        try {
            String token = authorizationHeader.substring("Bearer ".length());
            String userid = jwtTokenProvider.extractUserid(token);

            User user = userService.findUserByUsername(userid);
            if (user != null) {
                BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
                if (passwordEncoder.matches(passwordUpdateRequest.getCurrentPassword(), user.getPassword())) {
                    if (passwordUpdateRequest.getNewPassword().equals(passwordUpdateRequest.getConfirmPassword())) {
                        userService.updatePassword(userid, passwordUpdateRequest.getCurrentPassword(), passwordUpdateRequest.getNewPassword());
                        return ResponseEntity.ok("패스워드가 성공적으로 변경되었습니다");
                    } else {
                        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("새로운 패스워드와 확인용 패스워드가 일치하지 않습니다.");
                    }
                } else {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("현재 패스워드가 올바르지 않습니다");
                }
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("사용자를 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }

    //키 저장
    @Autowired
    private UserRepository userRepository; // UserRepository 주입

    @PostMapping("/storeKey")
    public ResponseEntity<String> storeKey(@RequestBody User user) {
        String key = user.getKey1(); // "key1" 값을 가져옴

        if (key != null) {
            // User 객체 생성 및 "key1" 설정
            User userToSave = new User();
            userToSave.setKey1(key);

            // User 객체를 데이터베이스에 저장
            userRepository.save(userToSave);

            return ResponseEntity.ok("Key stored successfully");
        } else {
            return ResponseEntity.badRequest().body("Key is missing in the request");
        }
    }
}