// Copyright (C) 2023 Javier Albiero (jalbiero)
// Distributed under the MIT License (see the accompanying LICENSE file
// or go to http://opensource.org/licenses/MIT).

use json::object;
use rocket::fairing::AdHoc;
use rocket::{get, launch, routes};

mod primes;

#[get("/")]
fn index() -> &'static str {
    "Rust test"
}

#[get("/echo/<data>")]
fn echo(data: &str) -> &str {
    data
}

#[get("/getPrimesLessThan/<limit>")]
fn get_primes_less_than(limit: i32) -> String {
    let primes = primes::get_primes_less_than(limit);

    let response = object! {
        primes_less_than: limit,
        count: primes.len(),
        primes: primes
    };

    response.dump()
}

#[get("/countPrimesLessThan/<limit>")]
fn count_primes_less_than(limit: i32) -> String {
    let response = object! {
        primes_less_than: limit,
        count: primes::count_primes_less_than(limit)
    };

    response.dump()
}

#[launch]
fn rocket() -> _ {
    rocket::build()
        .mount("/", routes![index])
        .mount("/", routes![echo])
        .mount("/", routes![get_primes_less_than])
        .mount("/", routes![count_primes_less_than])
        .attach(AdHoc::on_liftoff("Liftoff Message", |orbit| {
            Box::pin(async {
                println!(
                    "Listening on http://{}:{}",
                    orbit.config().address,
                    orbit.config().port
                );
            })
        }))
}
