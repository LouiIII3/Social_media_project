package com.example.social.comment;

import jakarta.persistence.*;
import lombok.Data;
import com.example.social.post.Post;
import com.example.social.media.User;

import java.time.LocalDateTime;

@Entity
@Data
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "post_id", referencedColumnName = "userid")
    private Post post;

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "userid")
    private User user;

    @Column(nullable = false)
    private String content;

    @Column(name = "created_at", nullable = false, updatable = false, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
    private LocalDateTime updatedAt;

    // Constructors, getters, setters, etc.
}
