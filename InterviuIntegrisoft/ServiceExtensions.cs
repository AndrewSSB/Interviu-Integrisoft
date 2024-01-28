using InterviuIntegrisoft.Interfaces;
using InterviuIntegrisoft.Services;
using Microsoft.EntityFrameworkCore;

namespace InterviuIntegrisoft
{
    public static class ServiceExtensions
    {
        public static IServiceCollection ConfigureDbContext(this IServiceCollection services, string connection)
        {
            services.AddSqlServer<UniversitateContext>(connection, options =>
            {
                options.MigrationsAssembly(typeof(UniversitateContext).Assembly.FullName);
            });

            return services;
        }

        public static IServiceCollection ConfigureServices(this IServiceCollection services)
        {
            services.AddTransient<IStudentService, StudentService>();

            return services;
        }
    }
}
