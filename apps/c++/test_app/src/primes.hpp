// Copyright (C) 2023 Javier Albiero (jalbiero)
// Distributed under the MIT License (see the accompanying LICENSE file
// or go to http://opensource.org/licenses/MIT).

#pragma once

#include <cmath>
#include <cstdint>

#include <json/json.h>

namespace primes 
{
    inline bool is_prime(std::int64_t num) {
        if (num <= 1) return false;
        if (num == 2) return true;
        if (num % 2 == 0) return false; // the only even prime is 2

        // Trial division (https://en.wikipedia.org/wiki/Prime_number#Trial_division)
        std::int64_t limit = std::sqrt(num);

        for (std::int64_t i=3; i<=limit; i++) {
            if (num % i == 0) return false;
        }

        return true;
    }

    inline Json::Value get_primes_less_than(std::int64_t limit) {
        Json::Value result(Json::arrayValue);

        for (std::int64_t i=2; i<limit; i++) { 
            if (is_prime(i))
                result.append(Json::Value::UInt64(i));
        }

        return result;
    }
    
    inline std::int64_t count_primes_less_than(std::int64_t limit) {
        std::int64_t result = 0;

        for (std::int64_t i=2; i<limit; i++) {
            if (is_prime(i)) result++;
        }

        return result;
    }

} // namespace primes
