// Copyright (C) 2023 Javier Albiero (jalbiero)
// Distributed under the MIT License (see the accompanying LICENSE file
// or go to http://opensource.org/licenses/MIT).


// Inline attributes are just to be on pair with C++ implementation (see primes.hpp)

#[inline]
fn is_prime(n: i32) -> bool {
    if n <= 1 {
        return false;
    }

    if n == 2 {
        return true;
    }

    // the only even prime is 2
    if n % 2 == 0 {
        return false;
    }

    // Trial division (https://en.wikipedia.org/wiki/Prime_number#Trial_division)
    let limit = (n as f32).sqrt() as i32 + 1;

    for i in 3..limit {
        if n % i == 0 {
            return false;
        }
    }

    true
}

#[inline]
pub fn get_primes_less_than(limit: i32) -> Vec<i32> {
    let mut result: Vec<i32> = Vec::new();

    for i in 2..limit {
        if is_prime(i) {
            result.push(i);
        }
    }

    result
}

#[inline]
pub fn count_primes_less_than(limit: i32) -> i32 {
    let mut result: i32 = 0;

    for i in 2..limit {
        if is_prime(i) {
            result += 1;
        }
    }

    result
}
