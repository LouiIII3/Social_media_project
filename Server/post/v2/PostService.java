package com.example.social.post;

import com.example.social.media.JwtTokenProvider;
import com.example.social.media.User;
import com.example.social.media.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PostService {

    private final PostRepository postRepository;
    private final UserRepository userRepository;

    @Autowired
    public PostService(PostRepository postRepository, UserRepository userRepository) {
        this.postRepository = postRepository;
        this.userRepository = userRepository;
    }

    //생성
    public Post createPost(PostDto postDTO) {
        // 사용자 정보를 이용하여 게시물 작성
        User user = userRepository.findByUserid(postDTO.getUserId());
        // DTO를 Entity로 변환(타입이 다른 이유는 보안상의 이유)
        Post post = new Post();
        post.setUser(user);
        post.setContent(postDTO.getContent());
        post.setMediaUrl(postDTO.getMediaUrl());

        // 게시물 저장
        post = postRepository.save(post);

        // 저장된 게시물의 ID를 DTO에 설정하여 반환
        postDTO.setId(post.getId());

        return post;
    }

    //수정
    public Post update(Long id, PostDto postDTO) {
        //바꿀 id
        Post target = postRepository.findById(id).orElse(null);
        //잘못된 요청 처리
        if(target == null){
            return null;
        }

        // DTO에서 가져온 내용으로 엔티티를 업데이트합니다.
        target.setContent(postDTO.getContent());
        target.setMediaUrl(postDTO.getMediaUrl());

        // 엔티티를 저장하고 반환합니다.
        return postRepository.save(target);
    }


    public Post delete(Long id){
        Post target = postRepository.findById(id).orElse(null);
        if (target == null) {
            return null;
        }
        postRepository.delete(target);
        return target;
    }

    //전체 반환
    public List<PostDto> getAllPosts() {
        List<Post> posts = postRepository.findAll();
        return convertToDtoList(posts);
    }

    private List<PostDto> convertToDtoList(List<Post> posts) {
        return posts.stream()
                .map(post -> {
                    PostDto postDto = new PostDto();
                    postDto.setId(post.getId());
                    postDto.setContent(post.getContent());
                    postDto.setMediaUrl(post.getMediaUrl());
                    return postDto;
                })
                .collect(Collectors.toList());
    }
}





