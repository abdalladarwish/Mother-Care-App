package com.server.mothercare.rest.user;

import com.server.mothercare.entities.ConfirmationToken;
import com.server.mothercare.entities.User;
import com.server.mothercare.DAOs.ConfirmationTokenDAO;
import com.server.mothercare.models.Error;
import com.server.mothercare.services.EmailSenderService;
import com.server.mothercare.services.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;


@RestController
@Slf4j
public class RegistrationController {
    private BCryptPasswordEncoder encoder;
    private UserService userService;
    private EmailSenderService emailSenderService;
    private ConfirmationTokenDAO confirmationTokenDAO;

    @Autowired
    public RegistrationController(BCryptPasswordEncoder encoder,
                                  UserService userService,
                                  EmailSenderService emailSenderService,
                                  ConfirmationTokenDAO confirmationTokenDAO
    ) {
        this.encoder = encoder;
        this.userService = userService;
        this.emailSenderService = emailSenderService;
        this.confirmationTokenDAO = confirmationTokenDAO;
    }

    @PostMapping(value = "/new/user")
    public ResponseEntity registerUser(@RequestBody User user) {
        User dbUser = null;
        ResponseEntity responseEntity = null;
        try {
            this.userService.getUserbyUserName(user.getUsername());
            Error error = new Error("user_exist", "User is already exist");
            responseEntity = new ResponseEntity(error, HttpStatus.CONFLICT);
        } catch (UsernameNotFoundException usernameNotFoundException){
            user.setPassword(this.encoder.encode(user.getPassword()));
            try {
                var confirmationToken = emailSenderService.confirm(user.getEmail(), user);
                user.setNumOfEvents((long)0);
                this.userService.registerUser(user);
                this.confirmationTokenDAO.save(confirmationToken);
                responseEntity = new ResponseEntity(user, HttpStatus.OK);
            } catch (Exception e){
                Error error = new Error("server_problem", "Server has a problem now try again later");
                responseEntity = new ResponseEntity(error, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
        return responseEntity;
    }

    @GetMapping("/confirm-account")
    public ResponseEntity confirmUserAccount(@RequestParam("token") String confirmationToken) {
        ConfirmationToken token = confirmationTokenDAO.findByConfirmationToken(confirmationToken);
        ResponseEntity responseEntity = null;
        if (token != null) {
            responseEntity = new ResponseEntity(HttpStatus.OK);
            User user = userService.userbyUserName(token.getUser().getUsername());
            user.setConfirmed(true);
            userService.update(user);
        } else {
            responseEntity = new ResponseEntity(HttpStatus.BAD_REQUEST);
        }
        return responseEntity;
    }
}