using AutoMapper;
using glovo_webapi.Entities;
using glovo_webapi.Helpers;
using glovo_webapi.Models.Location;
using glovo_webapi.Services;
using glovo_webapi.Services.UserService;
using Microsoft.AspNetCore.Mvc;

namespace glovo_webapi.Controllers.Users
{
    
    [ApiController]
    [Route("api/users")]
    public class UserLocationController : ControllerBase
    {
        private readonly IUsersService _userService;
        private readonly IMapper _mapper;

        public UserLocationController(
            IUsersService userService,
            IMapper mapper
            )
        {
            _userService = userService;
            _mapper = mapper;
        }
        
        //GET api/users/logged/location
        [Authorize]
        [HttpGet("logged/location")]
        public ActionResult<LocationModel> GetUserLocation()
        {
            User loggedUser;
            try {
                loggedUser = _userService.GetLogged();
            } catch (RequestException) {
                return NotFound(new {message = "No user is logged"});
            }

            return Ok(_mapper.Map<LocationModel>(loggedUser.Location));
        }
        
        //POST api/users/logged/location
        [Authorize]
        [HttpPost("logged/location")]
        public ActionResult PostUserLocation([FromBody]LocationModel newLocation)
        {
            User loggedUser;
            try {
                loggedUser = _userService.GetLogged();
            } catch (RequestException) {
                return NotFound(new {message = "No user is logged"});
            }

            loggedUser.Location = _mapper.Map<Location>(newLocation);
            
            _userService.Update(loggedUser);

            return Ok(_mapper.Map<LocationModel>(loggedUser.Location));
        }
    }
}