package ru.sweetshop.request;

import java.math.BigDecimal;

public record PutProductRequest(
        Long categoryId,
        String description,
        Long id,
        String imageName,
        String name,
        BigDecimal price,
        Integer weightGrams) {
}
