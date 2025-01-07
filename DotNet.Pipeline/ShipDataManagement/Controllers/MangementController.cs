using Microsoft.AspNetCore.Mvc;
using ShipDataManagement.Models;
using ShipDataManagement.Services;

namespace ShipDataManagement.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ManagementController(IDbOperations dbOperations, ILogger<ManagementController> logger) : ControllerBase
    {
        [HttpGet(Name = "get-stats")]
        public async Task<StateEntityResponse> Get()
        {

            return await dbOperations.GetAsync();
        }

        [HttpPost(Name = "post-stats")]
        public async Task<bool> Post([FromBody] StatsEntityRequest stateEntity)
        {

            return await dbOperations.AddAsync(stateEntity);
        }
    }
}
