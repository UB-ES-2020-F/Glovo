using System.Net.Http;
using Newtonsoft.Json;
using Xunit.Abstractions;
using Xunit;

namespace glovo_webapi_test.Endpoints
{
    public class UsersEndpointsTests
    {
        private readonly ITestOutputHelper _output;
        private HttpClient _client;
        private JsonSerializer _serializer;

        public UsersEndpointsTests(ITestOutputHelper output)
        {
            _output = output;
            _client = new HttpClient();
            _serializer = new JsonSerializer();
        }
        
        [Fact]
        public void RegisterTest()
        {
            
        }
        
        [Fact]
        public void LoginTest()
        {
            
        }
        
        [Fact]
        public void GetById()
        {
            
        }
        
        [Fact]
        public void GetAll()
        {
            
        }

        [Fact]
        public void Update()
        {
            
        }

        [Fact]
        public void Delete()
        {
            
        }
    }
}