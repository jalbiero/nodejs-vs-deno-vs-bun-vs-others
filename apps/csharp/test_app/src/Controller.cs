using Microsoft.AspNetCore.Mvc;

namespace test_app.Controllers;

[ApiController]
[Route("/")]
public class Controller : ControllerBase
{
    // private readonly ILogger<Controller> _logger;

    // public Controller(ILogger<Controller> logger)
    // {
    //     _logger = logger;
    // }

    [HttpGet]
    public string Get()
    {
        return "C# test";
    }

    [HttpGet("echo/{data}")]
    public string Echo(string data) {
        return data;
    }

    [HttpGet("getPrimesLessThan/{limit}")]
    public IList<int> GetPrimesLessThan(int limit) {
        return Primes.GetPrimesLessThan(limit);
    }

    [HttpGet("countPrimesLessThan/{limit}")]
    public int CountPrimesLessThan(int limit) {
        return Primes.CountPrimesLessThan(limit);
    }
}
