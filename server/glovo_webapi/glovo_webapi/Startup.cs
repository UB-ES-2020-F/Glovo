using System;
using AutoMapper;
using glovo_webapi.Data;
using glovo_webapi.Helpers;
using glovo_webapi.Services.Orders;
using glovo_webapi.Services.Products;
using glovo_webapi.Services.Restaurants;
using glovo_webapi.Services.UserService;
using glovo_webapi.Utils;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Server.IISIntegration;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace glovo_webapi
{
    public class Startup
    {
        public IConfiguration Configuration { get; }
        public IWebHostEnvironment Env { get; }
        
        readonly string AllowedOrigins = "_AllowedOrigins";
        public Startup(IWebHostEnvironment env, IConfiguration configuration)
        {
            Env = env;
            
            var builder = new ConfigurationBuilder()
                .SetBasePath(env.ContentRootPath)
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);

            Configuration = builder.Build();
        }
        
        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddCors(options =>
            {
                options.AddPolicy(name: AllowedOrigins,
                                builder =>
                                {
                                    if(Env.IsDevelopment()) {
                                        builder.AllowAnyOrigin()
                                        		.AllowAnyMethod()
                                        		.AllowAnyHeader();
                                    }
                                    else {
                                        builder.WithOrigins("http://localhost:34819",
                                                        "http://localhost:*",
                                                        "https://localhost:34819",
                                                        "http://komet.cat",
                                                        "https://komet.cat",
                                                        "http://ub-es2020-glovo-dev.herokuapp.com",
                                                        "https://ub-es2020-glovo-dev.herokuapp.com",
                                                        "http://ub-es2020-glovo.herokuapp.com",
                                                        "http://ub-es2020-glovo.herokuapp.com"
                                                        )
                                        		.AllowAnyMethod().AllowAnyHeader();
                                    }  
                                });
            });
            string connection = Configuration.GetConnectionString("LocalDBConnection");
            string dbUrl = Environment.GetEnvironmentVariable("DATABASE_URL");
            if (Env.IsProduction())
            {
                Console.Write("PRODUCTION!\n");
            }
            if (Env.IsProduction() && dbUrl != null)
            {
                Uri dbUri = new Uri(dbUrl);
                string username = dbUri.UserInfo.Split(":")[0];
                string password = dbUri.UserInfo.Split(":")[1];
                connection = "User ID=" + username + ";Password=" + password +
                             ";Host=" + dbUri.Host + ";Port=" + dbUri.Port + ";Database=" + dbUri.AbsolutePath.Substring(1);
                
            }
            Console.Write("Database connection string:"+connection);
            services.AddDbContext<GlovoDbContext>(opt => opt.UseNpgsql(connection));

            services.AddCors();
            services.AddControllers();

            services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

            services.AddScoped<IRestaurantsService, RestApiRestaurantsService>();
            services.AddScoped<IProductsService, RestApiProductsService>();
            services.AddScoped<IOrdersService, RestApiOrdersService>();
            services.AddScoped<IUsersService, RestApiUserService>();

            services.AddOptions();
            services.Configure<AppConfiguration>(Configuration.GetSection("AppSettings"));

            services.AddHttpContextAccessor();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            //app.UseHttpsRedirection();

            app.UseRouting();

            app.UseCors(AllowedOrigins);

            app.UseCors(x => x
                .AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader());

            app.UseAuthentication();
            app.UseAuthorization();

            app.UseMiddleware<JwtMiddleware>();
            
            app.UseEndpoints(endpoints => { endpoints.MapControllers(); });
        }
    }
}