# NodeJS vs Deno vs Bun vs Others

**DISCLAIMER: this document is a work in progress (tests are finished, but results are to be published together with the instructions to execute them)**

## Introduction

With the arrival of a new competitor to the Javascript runtime ecosystem, _Bun_, I was curious about how fast it is, because one of its selling points is that it is faster than NodeJS and Deno.

So, the idea of this project, is to test the following Javascript runtime environments:

Runtime | Appareance | Coded in | Estimated usage [(*)](https://devclass.com/2023/01/11/javascript-survey-shows-enthusiasm-for-tauri-over-electron-and-vite-over-webpack/)
-- | -- | -- | --
[NodeJS](https://en.wikipedia.org/wiki/Node.js) | 2009 | C++ | 71%
[Deno](https://en.wikipedia.org/wiki/Deno_(software)) | 2018 | Rust (originally in Go) | 8.5%
[Bun](https://bun.sh/) | 2021 | Zig | 3.2%

In order to make the tests more interesting I added 2 fast native languages, C++ and Rust, 2 GC languages like Java and C#, and also a "slow" one like Python. Future versions of these tests will include Go and a GraalVM version of the Java test.

Tests are executed from [JMeter](https://jmeter.apache.org/) via some REST APIs.

Language/Runtime | Version | REST Library/Framework used | Version
--             | --                      | --          | --
Bun            | 1.1.10                  | Express     | 4.19.2
C++            | g++ 13.12.1, C++20 mode | Drogon      | 1.9.4
C#             | 12                      | .NET        | 8.0
Deno           | 1.43.6                  | Express     | 4.19.2
Java (OpenJDK) | 21                      | Spring boot | 3.3.0
NodeJS         | 20.14.0                 | Express     | 4.19.2
Python         | 3.12.3                  | Flask       | 3.0.3
Rust           | 1.78.0                  | Rocket      | 0.5.1

For more information about the latest versions check the [version.txt](apps/versions.txt) file.

## Tests

The tests are based on the following REST APIs:

Verb | Route | Result | Description
-- | -- | -- | --
GET | `/` | Fixed little string: e.g. "Deno test" | Very simple API that returns a fixed data
GET | `/echo/<data>` | Return the same `<data>` | Simple API that returns the same received data
GET | `/getPrimesLessThan/<limit>` | Returns a list of primes less than `<limit>` | CPU and memory are function of the specified _limit_
GET | `/countPrimesLessThan/<limit>` | Returns the number of primes less than `<limit>` | CPU is function of the specified _limit_

### Notes
- All tests are coded without tweeking them for performance (CPU, network usage, etc) or memory consumption. The idea is to add tweaks for all examples in the future.
- Currently the only minor tweak is in the Rust application in order to be on pair with C++ (primes functions were hinted as _inline_).
- For sure there are better ways to test these runtimes/languages, but as an entry point, it could be useful to have an idea of where each implementation is.
