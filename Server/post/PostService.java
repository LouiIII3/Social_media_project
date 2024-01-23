package com.example.social.post;

import com.example.social.media.User;
import com.example.social.media.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PostService {

    private final PostRepository postRepository;
    private final UserRepository userRepository;

    @Autowired
    public PostService(PostRepository postRepository, UserRepository userRepository) {
        this.postRepository = postRepository;
        this.userRepository = userRepository;
    }

    public Post createPost(Post post, String userId) {
        // 사용자 정보를 이용하여 게시물 작성
        User user = userRepository.findByUserid(userId);
        if (user == null) {
            user = new User();
            user.setUserid(userId);
            // 다른 필드 설정...
            user = userRepository.save(user);
        }

        post.setUser(user);

        // 게시물 저장
        return postRepository.save(post);
    }
}





