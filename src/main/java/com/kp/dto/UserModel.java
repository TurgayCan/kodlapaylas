package com.kp.dto;

import com.kp.service.user.UserService;
import com.kp.validator.validate.KpInfoValidator;
import com.kp.validator.validate.Validateable;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;

import javax.validation.constraints.Size;
import java.io.Serializable;


/**
 * Created by turgaycan on 9/20/15.
 */
public class UserModel implements Validateable<UserModel>, Serializable {

    private static final long serialVersionUID = -7683933371854136134L;

    @Email(message = "E-Posta formatı hatalı!")
    @NotBlank(message = "E-Posta adresini boş bırakmayınız..")
    private String email;

    @NotBlank(message = "Kullanıcı Ad alanını boş bırakmayınız..")
    private String username;

    @Size(min = 6, max = 50, message = "Şifrenin en az 6, en çok 50 karakterden oluşmalıdır.")
    @NotBlank(message = "Şifre alanını boş bırakmayınız..")
    private String password;

    @NotBlank(message = "Şifre Yenile alanını boş bırakmayınız..")
    private String passwordRepeated;

    @NotBlank(message = "Ad Soyad alanını boş bırakmayınız..")
    private String fullname;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordRepeated() {
        return passwordRepeated;
    }

    public void setPasswordRepeated(String passwordRepeated) {
        this.passwordRepeated = passwordRepeated;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    @Override
    public KpInfoValidator<UserModel> validator() {
        return new KpInfoValidator<UserModel>() {
            @Autowired
            private UserService userService;

            @Override
            public void validate(UserModel target, Errors errors) {
                if (!target.getPassword().equals(target.getPasswordRepeated())) {
                    errors.rejectValue("password", "", "Şifreler uyuşmuyor!");
                    return;
                }

                if (userService.getUserByEmail(target.getEmail()) != null) {
                    errors.rejectValue("email", "", "E-Posta farklı bir kullanıcı tarafından kullanılıyor.");
                }

                if (userService.getUserByUsername(target.getUsername()) != null) {
                    errors.rejectValue("email", "", "Kullanıcı Ad farklı bir kullanıcı tarafından kullanılıyor.");
                }
            }

        };
    }

    @Override
    public String toString() {
        return "UserModel{" +
                "username='" + fullname + "'\n'" +
                "email='" + email.replaceFirst("@.+", "@***") + '\'' +
                ", password=***" + '\'' +
                ", passwordRepeated=***" + '\'' +
                '}';
    }
}
