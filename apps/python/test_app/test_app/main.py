# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

import json
from typing import Any, Dict, List

from flask import Flask

from test_app.primes import count_primes_less_than, get_primes_less_than

SERVER_PORT: int = 8000
SERVER_HOST: str = "0.0.0.0"

app = Flask(__name__)


@app.route("/")
def api_index() -> str:
    return "Python test"


@app.route("/echo/<string:data>")
def api_echo(data: str) -> str:
    return data


@app.route("/getPrimesLessThan/<int:limit>")
def api_get_primes_less_than(limit: int) -> str:
    primes: List[int] = get_primes_less_than(limit)

    response: Dict[str, Any] = {
        "prime_less_than": limit,
        "count": len(primes),
        "primes": primes
    }

    return json.dumps(response)


@app.route("/countPrimesLessThan/<int:limit>")
def api_count_primes_less_than(limit: int) -> str:
    response: Dict[str, Any] = {
        "prime_less_than": limit,
        "count": count_primes_less_than(limit),
    }

    return json.dumps(response)


def main() -> None:
    app.run(host=SERVER_HOST, port=SERVER_PORT)


if __name__ == "__main__":
    main()
