# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

from math import floor, sqrt
from typing import List


def _is_prime(n: int) -> bool:
    if n == 1: return False
    if n == 2: return True
    if n % 2 == 0: return False # the only even prime is 2
    
    # Trial division (https://en.wikipedia.org/wiki/Prime_number#Trial_division)
    limit: int = floor(sqrt(n)) + 1

    for i in range(3, limit): 
        if n % i == 0:
            return False

    return True

def get_primes_less_than(limit: int) -> List[int]:
    result: List[int] = []

    for i in range(2, limit): 
        if _is_prime(i):
            result.append(i)
    
    return result

def count_primes_less_than(limit: int) -> int:
    result: int = 0

    for i in range(2, limit): 
        if _is_prime(i):
            result += 1
    
    return result
