using System;
using glovo_webapi.Models;
using Xunit;
using Xunit.Abstractions;
using FluentAssertions;

namespace glovo_webapi_test.Endpoints
{
    public class DummyTests
    {
        private readonly ITestOutputHelper _output;
        
        public DummyTests(ITestOutputHelper output)
        {
            _output = output;
        }
        
        [Fact]
        public void DummyTest()
        {
            Assert.Equal(0,0);
        }
    }
}