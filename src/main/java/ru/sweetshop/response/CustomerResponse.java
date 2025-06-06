package ru.sweetshop.response;

public record CustomerResponse(Long id, String name, String phone, int orderCount) {
}
