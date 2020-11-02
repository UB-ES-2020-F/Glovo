using System;

namespace glovo_webapi.Services
{
    public class RequestException : Exception
    {
        public int Code { get; }

        public RequestException(int code) : base("")
        {
            Code = code;
        }
    }
}