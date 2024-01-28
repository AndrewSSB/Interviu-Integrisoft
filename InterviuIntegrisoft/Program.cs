using FastEndpoints;
using InterviuIntegrisoft;
using InterviuIntegrisoft.Authentication;
using Microsoft.AspNetCore.Authentication;

try
{
    var builder = WebApplication.CreateBuilder(args);

    // Add services to the container.

    builder.Services.AddControllers();
    // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
    builder.Services.AddEndpointsApiExplorer();
    builder.Services.AddSwaggerGen();

    var connectionString = builder.Configuration.GetConnectionString("DbConnection");

    builder.Services.ConfigureDbContext(connectionString ?? throw new Exception("Invalid connection string"));

    builder.Services.AddFastEndpoints();

    builder.Services.AddAuthentication()
        .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("Basic", null);

    builder.Services.ConfigureServices();

    var app = builder.Build();

    // Configure the HTTP request pipeline.
    if (app.Environment.IsDevelopment())
    {
        app.UseSwagger();
        app.UseSwaggerUI();
    }

    app.UseHttpsRedirection();

    app.UseAuthorization();

    app.MapControllers();

    app.UseFastEndpoints();

    app.Run();
}
catch (Exception ex) when (ex is not OperationCanceledException && !ex.GetType().Name.Contains("StopTheHostException") && !ex.GetType().Name.Contains("HostAbortedException"))
{
    Console.WriteLine(ex.Message);
}
finally
{
    Console.WriteLine("App shut down complete");
}