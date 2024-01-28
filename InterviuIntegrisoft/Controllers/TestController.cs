using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace InterviuIntegrisoft.Controllers;

[ApiController]
[Route("api/[controller]")]
public class TestController(UniversitateContext _context) : Controller
{
    [HttpGet]
    public async Task<IActionResult> TestDb()
    {
        return Ok(await _context.Materie.ToListAsync());
    }
}
