package com.example.social.post;

import com.example.social.media.JwtTokenProvider;
import com.example.social.media.User;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/posts")
public class PostController {

    private final PostService postService;
    private final JwtTokenProvider jwtTokenProvider;

    @Autowired
    public PostController(PostService postService, JwtTokenProvider jwtTokenProvider) {
        this.postService = postService;
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @PostMapping("/create")
    public ResponseEntity<?> createPost(@RequestBody Post post, @RequestHeader("Authorization") String token) {
        try {
            // 토큰의 유효성 검사
            if (!jwtTokenProvider.validateToken(token)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("유효하지 않은 토큰입니다.");
            }

            // 토큰에서 사용자 정보를 추출
            String userId = jwtTokenProvider.extractUserid(token);

            // 사용자 정보를 이용하여 게시물 작성
            User user = new User(userId);
            post.setUser(user);

            // 게시물 생성
            Post createdPost = postService.createPost(post, userId);

            return ResponseEntity.ok(createdPost);
        } catch (ExpiredJwtException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("토큰이 만료되었습니다.");
        } catch (JwtException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("유효성 검사 중 오류가 발생했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시물 생성에 실패했습니다.");
        }
    }

}


