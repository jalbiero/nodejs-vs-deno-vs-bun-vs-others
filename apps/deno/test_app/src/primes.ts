// Copyright (C) 2023 Javier Albiero (jalbiero)
// Distributed under the MIT License (see the accompanying LICENSE file
// or go to http://opensource.org/licenses/MIT).

function isPrime(n: number): boolean {
  if (n <= 1) return false;
  if (n == 2) return true;
  if (n % 2 == 0) return false; // the only even prime is 2

  // Trial division (https://en.wikipedia.org/wiki/Prime_number#Trial_division)
  const limit: number = Math.trunc(Math.sqrt(n)) + 1

  for (let i = 3; i < limit; i++) {
    if (n % i == 0) return false;
  }

  return true;
}

export function primesLessThan(limit: number): number[] {
  const result: number[] = [];

  for (let i = 2; i < limit; i++) {
    if (isPrime(i)) result.push(i);
  }

  return result;
}

export function countPrimesLessThan(limit: number): number {
  let result = 0;

  for (let i = 2; i < limit; i++) {
    if (isPrime(i)) result++;
  }

  return result;
}
