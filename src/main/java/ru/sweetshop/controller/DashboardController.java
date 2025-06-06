package ru.sweetshop.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

import java.time.LocalDate;
import java.util.*;

@RestController
@RequestMapping("/dashboard")
public class DashboardController {

    @GetMapping("/orders/stats")
    public ResponseEntity<Map<String, Object>> getOrderStats() {
        Map<String, Object> response = new HashMap<>();
        response.put("total", 1423);
        response.put("today", 27);
        response.put("avg", 789.50);
        response.put("byStatus", Map.of(
                "CREATED", 130,
                "IN_PROGRESS", 95,
                "READY_FOR_PICKUP", 75,
                "OUT_FOR_DELIVERY", 50,
                "COMPLETED", 1073
        ));
        return ResponseEntity.ok(response);
    }

    @GetMapping("/orders/chart/daily")
    public ResponseEntity<List<Map<String, Object>>> getOrdersByDay() {
        List<Map<String, Object>> result = new ArrayList<>();
        LocalDate today = LocalDate.now();
        for (int i = 6; i >= 0; i--) {
            LocalDate date = today.minusDays(i);
            result.add(Map.of(
                    "date", date.toString(),
                    "count", new Random().nextInt(80) + 10
            ));
        }
        return ResponseEntity.ok(result);
    }

    @GetMapping("/orders/chart/status")
    public ResponseEntity<Map<String, Integer>> getOrderStatusChart() {
        return ResponseEntity.ok(Map.of(
                "CREATED", 130,
                "IN_PROGRESS", 95,
                "READY_FOR_PICKUP", 75,
                "OUT_FOR_DELIVERY", 50,
                "COMPLETED", 1073
        ));
    }

    @GetMapping("/orders/chart/delivery")
    public ResponseEntity<Map<String, Integer>> getOrderDeliveryChart() {
        return ResponseEntity.ok(Map.of(
                "pickup", 723,
                "delivery", 700
        ));
    }

    @GetMapping("/products/top")
    public ResponseEntity<List<Map<String, Object>>> getTopProducts() {
        List<Map<String, Object>> topProducts = Arrays.asList(
                Map.of(
                        "id", 1,
                        "name", "Эклер",
                        "sold", 120,
                        "image", "eclair.png"
                ),
                Map.of(
                        "id", 2,
                        "name", "Чизкейк",
                        "sold", 110,
                        "image", "cheesecake.png"
                ),
                Map.of(
                        "id", 3,
                        "name", "Тирамису",
                        "sold", 95,
                        "image", "tiramisu.png"
                )
        );
        return ResponseEntity.ok(topProducts);
    }

    @GetMapping("/orders/recent")
    public ResponseEntity<List<Map<String, Object>>> getRecentOrders() {
        List<Map<String, Object>> recentOrders = new ArrayList<>();
        for (int i = 1; i <= 5; i++) {
            recentOrders.add(Map.of(
                    "id", 1000 + i,
                    "orderDate", LocalDate.now().minusDays(i).toString(),
                    "customerName", "Покупатель " + i,
                    "status", List.of("CREATED", "IN_PROGRESS", "COMPLETED").get(i % 3),
                    "totalAmount", 450 + new Random().nextInt(300)
            ));
        }
        return ResponseEntity.ok(recentOrders);
    }
}
