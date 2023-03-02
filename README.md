# NodeJS vs Deno vs Bun vs Others

**DISCLAIMER: this is a work in progress (tests are unfinished/not working)**

## Introduction

With the arrival of a new competitor to the Javascript runtime ecosystem, _Bun_, I was curious about how fast it is, because one of its selling points is that it is faster than NodeJS and Deno. 

So, the idea of this repository, is to test the following Javascript runtime environments:

Runtime | Appareance | Coded in | Estimated usage [(*)](https://devclass.com/2023/01/11/javascript-survey-shows-enthusiasm-for-tauri-over-electron-and-vite-over-webpack/)
-- | -- | -- | --
[NodeJS](https://en.wikipedia.org/wiki/Node.js) | 2009 | C++ | 71%
[Deno](https://en.wikipedia.org/wiki/Deno_(software)) | 2018 | Rust (originally in Go) | 8.5%
[Bun](https://bun.sh/) | 2021 | Zig | 3.2%

In order to make the tests more interesting I added 2 fast native environments, C++ and Rust, a classic one like Java (no GraalVM at the moment), and also a "slow" one like Python. Future versions of these tests will include Go and a GraalVM version of the Java test.

Tests are executed from [JMeter](https://jmeter.apache.org/) via some REST APIs. 

Language/Runtime | Version | REST Library/Framework used | Version 
-- | -- | -- | -- 
Bun  | 0.5.1 | Express | 4.18.2
C++  | g++ 12.2.1, C++20 mode | Drogon | 1.8.3
Deno | 1.30.3 | Express | 4.18.2
Java (OpenJDK) | 19.0.1 | Spring boot | 3.0.2
NodeJS | 19.6.1 | Express | 4.18.2
Python | 3.11.2 | Flask | 2.2.2
Rust | 1.67.1 | Rocket | 0.5.0-rc.2

For more information about the latest versions check the [version.txt](apps/versions.txt) file.

## Tests

The tests are based on the following REST APIs:

Verb | Route | Result | Description
-- | -- | -- | -- 
GET | `/` | Fixed little string: e.g. "Deno test" | Very simple API that return a fixed data
GET | `/echo/<data>` | Return the same `<data>` | Simple API that return the same received data
GET | `/getPrimesLessThan/<limit>` | Return a list of primes less than `<limit>` | CPU and memory are function of the specified _limit_
GET | `/countPrimesLessThan/<limit>` | Return the number of primes less than `<limit>` | CPU is function of the specified _limit_

### Notes
- All tests are coded without tweeking them for performance (CPU, network usage, etc) or memory consumption. The idea is to add tweaks for all examples in the future.
- Currently the only minor tweak is in the Rust application in order to be on pair with C++ (primes functions were hinted as _inline_).
- For sure there are better ways to test these runtimes/languages, but as an entry point, they could be useful to have an idea of where is each implementation.