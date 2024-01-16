package com.example.social.media;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service("customUserService")
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;


    //회원가입 양식
    public User registerUser(String key, String id, String password, LocalDate birthdate, String nickname, String profilePictureUrl) {
        User existingUser = userRepository.findBykey1(key);

        if (existingUser != null) {
            // 이미 해당 key1에 관련된 사용자 정보가 있는 경우
            if (existingUser.getUserid() != null && existingUser.getPassword() != null) {
                // 아이디와 패스워드가 이미 저장되어 있음
                return null; // 회원가입을 거부
            }

            // 클라이언트가 입력한 key 값과 데이터베이스에 저장되어 있는 key 값이 일치할 때만 id, password, birthdate, fullName, profilePictureUrl 저장
            existingUser.setUserid(id);
            existingUser.setPassword(passwordEncoder.encode(password));
            existingUser.setBirthdate(birthdate);
            existingUser.setNickname(nickname);
            existingUser.setProfilePictureUrl(profilePictureUrl);

            return userRepository.save(existingUser);
        }
        return null; // 사용자 정보가 존재하지 않는 경우 회원가입 실패
    }

    public boolean isUseridExists(String userid) {
        return userRepository.existsByUserid(userid);
    }

    //로그인 기능
    public User findUserByUsernameAndPassword(String userid, String password) {
        User user = userRepository.findByUserid(userid);
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null;
    }


    //비번 수정
    public boolean updatePassword(String userid, String currentPassword, String newPassword) {
        User user = userRepository.findByUserid(userid);

        if (user != null && passwordEncoder.matches(currentPassword, user.getPassword())) {
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(user);
            return true;
        }

        return false;
    }

    public User findUserByUsername(String userid) {
        return userRepository.findByUserid(userid);
    }

}
