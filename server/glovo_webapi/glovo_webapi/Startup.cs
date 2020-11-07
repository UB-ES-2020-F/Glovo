using System;
using AutoMapper;
using glovo_webapi.Data;
using glovo_webapi.Services.Orders;
using glovo_webapi.Services.Products;
using glovo_webapi.Services.Restaurants;
using glovo_webapi.Services.UserService;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using WebApi.Helpers;

namespace glovo_webapi
{
    public class Startup
    {
        public IConfiguration Configuration { get; }
        public IWebHostEnvironment Env { get; }
        
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

            services.AddScoped<IRestaurantsService, NpgsqlRestaurantsService>();
            services.AddScoped<IProductsService, NpgsqlProductsService>();
            services.AddScoped<IOrdersService, NpgsqlOrdersService>();
            services.AddScoped<IUserService, UserService>();

            services.AddOptions();
            services.Configure<AppConfiguration>(Configuration.GetSection("AppSettings"));
            
            /*
            byte[] key = Encoding.ASCII.GetBytes(Configuration.GetValue<string>("AppSettings:Secret"));
            services.AddAuthentication(x =>
                {
                    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                })
                .AddJwtBearer(x =>
                {
                    x.Events = new JwtBearerEvents
                    {
                        OnTokenValidated = context =>
                        {
                            var userService = context.HttpContext.RequestServices.GetRequiredService<IUserService>();
                            var userId = int.Parse(context.Principal.Identity.Name);
                            var user = userService.GetById(userId);
                            if (user == null)
                            {
                                // return unauthorized if user no longer exists
                                context.Fail("Unauthorized");
                            }
                            return Task.CompletedTask;
                        }
                    };
                    x.RequireHttpsMetadata = false;
                    x.SaveToken = true;
                    x.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKey = new SymmetricSecurityKey(key),
                        ValidateIssuer = false,
                        ValidateAudience = false
                    };
                });
            */
            
            services.AddHttpContextAccessor();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

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