package com.example.social.comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    public List<Comment> getCommentsByPost(Long postId) {
        // 게시물에 속한 댓글 조회
        return commentRepository.findByPostId(postId);
    }

    public void createComment(Comment comment) {
        // 댓글 생성
        commentRepository.save(comment);
    }

    //댓글 수정
    public void updateComment(Comment comment) {
        commentRepository.save(comment);
    }

    //댓글 삭제
    public void deleteComment(Long commentId) {
        commentRepository.deleteById(commentId);
    }
}
