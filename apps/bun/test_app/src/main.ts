// Copyright (C) 2023 Javier Albiero (jalbiero)
// Distributed under the MIT License (see the accompanying LICENSE file
// or go to http://opensource.org/licenses/MIT).

import express, { Application, Request, Response } from "express"
import { countPrimesLessThan, primesLessThan } from "./primes";

const serverPort = 8000;
const serverHost = "0.0.0.0";
const app: Application = express();

app.get("/", (req: Request, res: Response) => {
  res.send("Bun test");
});

app.get("/getPrimesLessThan/:limit", (req: Request, res: Response) => {
  const limit: number = Number.parseInt(req.params.limit);

  if (!Number.isNaN(limit)) {
    const primes: number[] = primesLessThan(limit);

    res.send({
      prime_less_than: limit,
      count: primes.length,
      primes: primes
    });
  }
  else {
    res.send(`Error: Invalid limit = '${req.params.limit}', it must be a number`);
  }
});

app.get("/countPrimesLessThan/:limit", (req: Request, res: Response) => {
  const limit: number = Number.parseInt(req.params.limit);

  if (!Number.isNaN(limit)) {
    res.send({
      prime_less_than: limit,
      count: countPrimesLessThan(limit),
    });
  }
  else {
    res.send(`Error: Invalid limit = '${req.params.limit}', it must be a number`);
  }
});

app.listen(serverPort, serverHost, () => {
  console.log(`Listening on http://${serverHost}:${serverPort}`);
});


