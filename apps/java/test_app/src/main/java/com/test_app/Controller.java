// Copyright (C) 2023 Javier Albiero (jalbiero)
// Distributed under the MIT License (see the accompanying LICENSE file
// or go to http://opensource.org/licenses/MIT).

package com.test_app;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
class Controller {

    @GetMapping("/")
    String index() {
        return "Java test";
    }

    @GetMapping("/echo/{data}")
    String echo(@PathVariable String data) {
        return data;
    }

    @GetMapping("getPrimesLessThan/{limit}")
    Map<String, Object> getPrimesLessThan(@PathVariable int limit) {
        var primes = Primes.getPrimesLessThan(limit);

        var result = new LinkedHashMap<String, Object>();

        result.put("prime_less_than", limit);
        result.put("count", primes.size());
        result.put("primes", primes);

        return result;
    }

    @GetMapping("countPrimesLessThan/{limit}")
    Map<String, Object> countPrimesLessThan(@PathVariable int limit) {
        var result = new LinkedHashMap<String, Object>();

        result.put("prime_less_than", limit);
        result.put("count", Primes.countPrimesLessThan(limit));

        return result;
    }
}
