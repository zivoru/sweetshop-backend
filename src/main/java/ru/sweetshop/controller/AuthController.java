package ru.sweetshop.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import ru.sweetshop.model.Customer;
import ru.sweetshop.repository.CustomerRepository;
import ru.sweetshop.request.PhoneRequest;
import ru.sweetshop.request.VerifyRequest;

import java.util.Optional;
import java.util.Random;

@RestController
@RequiredArgsConstructor
public class AuthController {

    private final CustomerRepository customerRepository;

    @PostMapping("/request-code")
    public ResponseEntity<?> requestCode(@RequestBody PhoneRequest request) {
        String code = String.format("%06d", new Random().nextInt(999999));
        Optional<Customer> customer = customerRepository.findByPhone(request.phone());
        if (customer.isPresent()) {
            Customer customer1 = customer.get();
            customer1.setVerificationCode(code);
            customerRepository.save(customer1);
        } else {
            Customer customer1 = new Customer(request.phone());
            customer1.setVerificationCode(code);
            customerRepository.save(customer1);
        }
        return ResponseEntity.ok().build();
    }

    @PostMapping("/verify-code")
    public ResponseEntity<?> verifyCode(@RequestBody VerifyRequest request) {
        Customer customer = customerRepository.findByPhone(request.phone()).get();
        return ResponseEntity.ok(customer);
    }

//    @PostMapping("/request-code")
//    public ResponseEntity<?> requestCode(@RequestBody PhoneRequest request) {
//        // Валидация номера (должен начинаться с +7 и быть 12 символов)
//        String phone = request.phone();
//        if (!phone.startsWith("+7") || phone.length() != 12) {
//            return ResponseEntity.badRequest().body("Invalid Russian phone number");
//        }
//
//        // Генерация 6-значного кода
//        String code = String.format("%06d", new Random().nextInt(999999));
//
//        // Отправка SMS через Twilio (или другой сервис)
//        sendSms(phone, "Your verification code: " + code);
//
//        // Сохранение кода в базу
//        verificationCodeService.saveCode(phone, code);
//
//        return ResponseEntity.ok().build();
//    }
//
//    @PostMapping("/verify-code")
//    public ResponseEntity<?> verifyCode(@RequestBody VerifyRequest request) {
//        boolean isValid = verificationCodeService.verifyCode(
//                request.phone(),
//                request.code()
//        );
//
//        if (isValid) {
//            // Создаем/обновляем пользователя
//            User user = userService.findOrCreateUser(request.getPhone());
//            String jwt = jwtTokenProvider.generateToken(user.getPhone());
//            return ResponseEntity.ok(new AuthResponse(jwt));
//        } else {
//            return ResponseEntity.status(401).body("Invalid code");
//        }
//    }
//
//    private void sendSms(String phone, String message) {
//        Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
//        Message.creator(
//                new PhoneNumber(phone),
//                new PhoneNumber("+1234567890"), // Ваш Twilio номер
//                message
//        ).create();
//    }

}
