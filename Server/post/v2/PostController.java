package com.example.social.post;

import com.example.social.media.JwtTokenProvider;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/posts")
public class PostController {

    private final PostService postService;
    private final JwtTokenProvider jwtTokenProvider;
    private PostRepository postRepository;

    @Autowired
    public PostController(PostService postService, JwtTokenProvider jwtTokenProvider, PostRepository postRepository) {
        this.postService = postService;
        this.jwtTokenProvider = jwtTokenProvider;
        this.postRepository = postRepository;
    }


    @PostMapping("/create")
    public ResponseEntity<?> createPost(@RequestBody PostDto postDTO, @RequestHeader("Authorization") String token) {
        try {
            // 토큰의 유효성 검사
            if (!jwtTokenProvider.validateToken(token)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("유효하지 않은 토큰입니다.");
            }

            // 토큰에서 사용자 정보를 추출
            String userId = jwtTokenProvider.extractUserid(token);

            // 사용자 정보를 이용하여 게시물 작성
            postDTO.setUserId(userId);

            // 게시물 생성
            Post createdPost = postService.createPost(postDTO);

            return ResponseEntity.ok(createdPost);
        } catch (ExpiredJwtException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("토큰이 만료되었습니다.");
        } catch (JwtException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("유효성 검사 중 오류가 발생했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시물 생성에 실패했습니다.");
        }
    }

    @PatchMapping("/edit/{id}")
    public ResponseEntity<?> editPost(@PathVariable Long id, @RequestBody PostDto PostDTO, @RequestHeader("Authorization") String token) {
        try {
            // 토큰의 유효성 검사
            if (!jwtTokenProvider.validateToken(token)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("유효하지 않은 토큰입니다.");
            }

            // 토큰에서 사용자 정보를 추출
            String userId = jwtTokenProvider.extractUserid(token);

            // 요청된 게시물의 작성자와 현재 로그인한 사용자가 일치하는지 확인
            Post existingPost = postRepository.findById(id).orElse(null);
            if (existingPost == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("해당 ID의 게시물을 찾을 수 없습니다.");
            }
            if (!existingPost.getUser().getUserid().equals(userId)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body("자신의 게시물만 수정할 수 있습니다.");
            }

            Post updated = postService.update(id, PostDTO);

            return ResponseEntity.ok(updated);
        } catch (ExpiredJwtException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("토큰이 만료되었습니다.");
        } catch (JwtException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("유효성 검사 중 오류가 발생했습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시물 수정에 실패했습니다.");
        }
    }

    @GetMapping("postall")
    public List<PostDto> getAllPosts() {
        return postService.getAllPosts();
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deletePost(@PathVariable Long id, @RequestHeader("Authorization") String token) {
        try {
            // 토큰의 유효성 검사
            if (!jwtTokenProvider.validateToken(token)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("유효하지 않은 토큰입니다.");
            }

            // 토큰에서 사용자 정보를 추출
            String userId = jwtTokenProvider.extractUserid(token);

            // 요청된 게시물의 작성자와 현재 로그인한 사용자가 일치하는지 확인
            Post existingPost = postRepository.findById(id).orElse(null);
            if (existingPost == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("해당 ID의 게시물을 찾을 수 없습니다.");
            }
            if (!existingPost.getUser().getUserid().equals(userId)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body("자신의 게시물만 삭제할 수 있습니다.");
            }

            Post deleted = postService.delete(id);
            return (deleted != null) ?
                    ResponseEntity.status(HttpStatus.NO_CONTENT).body("게시물이 없는 게시물입니다.") :
                    ResponseEntity.status(HttpStatus.BAD_REQUEST).body("잘못된 요청입니다.");
        } catch (ExpiredJwtException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("토큰이 만료되었습니다.");
        }

    }
}
