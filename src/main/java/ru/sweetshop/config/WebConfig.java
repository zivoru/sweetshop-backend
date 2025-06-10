package ru.sweetshop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig {

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**") // разрешить на все эндпоинты
                        .allowedOrigins(
                                "http://localhost:5173", "http://localhost:3001",
                                "http://89.104.65.160:8081", "http://89.104.65.160:8082",
                                "https://sweetshopp.ru", "https://admin.sweetshopp.ru"
                        ) // адрес твоего React-приложения
                        .allowedMethods("*")
                        .allowedHeaders("*")
                        .allowCredentials(false); // если нужны куки или заголовки авторизации
            }
        };
    }
}

