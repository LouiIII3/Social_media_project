package com.example.social.post;

import jakarta.persistence.*;
import lombok.Data;
import com.example.social.media.User;

@Entity
@Data
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    //외래키 지정
    @ManyToOne
    @JoinColumn(name = "userid", referencedColumnName = "userid")
    private User user;

    @Column
    private String content;

    @Column(name = "media_url", nullable = true)
    private String mediaUrl;

    // Constructors, getters, setters, etc.
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getUserid() {
        return user != null ? user.getUserid() : null;
    }

    public void setUserid(String userid) {
        // This method is added to set the userid in Post entity.
    }
}
