package ru.sweetshop.response;

import ru.sweetshop.model.Product;

import java.math.BigDecimal;

public record ProductDto(
        Long id,
        String name,
        String description,
        BigDecimal price,
        Integer weightGrams,
        String imageName,
        Long categoryId) {

    public static ProductDto of(Product product) {
        return new ProductDto(
                product.getId(),
                product.getName(),
                product.getDescription(),
                product.getPrice(),
                product.getWeightGrams(),
                product.getImageName(),
                product.getCategory().getId()
        );
    }
}
