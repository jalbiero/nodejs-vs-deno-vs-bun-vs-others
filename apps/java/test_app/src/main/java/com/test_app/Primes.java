// Copyright (C) 2023 Javier Albiero (jalbiero)
// Distributed under the MIT License (see the accompanying LICENSE file
// or go to http://opensource.org/licenses/MIT).

package com.test_app;

import java.lang.Math;
import java.util.ArrayList;
import java.util.List;

class Primes {
    static boolean isPrime(long num) {
        if (num <= 1) return false;
        if (num == 2) return true;
        if (num % 2 == 0) return false; // the only even prime is 2

        // Trial division (https://en.wikipedia.org/wiki/Prime_number#Trial_division)
        var limit = Math.sqrt(num);

        for (long i=3; i<=limit; i++) {
            if (num % i == 0) return false;
        }

        return true;
    } 

    static List<Long> getPrimesLessThan(long limit) {
        var result = new ArrayList<Long>();

        for (long i=2; i<limit; i++) {
            if (Primes.isPrime(i)) result.add(i);
        }

        return result;
    }

    static long countPrimesLessThan(long limit) {
        long result = 0;

        for (long i=2; i<limit; i++) {
            if (Primes.isPrime(i)) result++;
        }

        return result;
    }
}