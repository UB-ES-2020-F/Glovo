using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Xunit;
using Xunit.Abstractions;

namespace glovo_webapi_tests.API
{
    public class RestaurantsEndpointsTests
    {

        private readonly ITestOutputHelper _output;
        private HttpClient _client;
        
        public RestaurantsEndpointsTests(ITestOutputHelper output)
        {
            _output = output;
            
            _client = new HttpClient(new HttpClientHandler()
            {
                //Credentials = new NetworkCredential("glovodev", "password")
            });
        }
        
        //[Fact]
        public void GetAllRestaurantsTest()
        {
            Task<HttpResponseMessage> response = _client.GetAsync("https://localhost:5001/api/restaurants");
            Assert.Equal(HttpStatusCode.OK, response.Result.StatusCode);
        }
    }
}