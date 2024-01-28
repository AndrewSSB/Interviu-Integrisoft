using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using System.Security.Claims;
using System.Text;
using System.Text.Encodings.Web;

namespace InterviuIntegrisoft.Authentication;

public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
{
    public BasicAuthenticationHandler(IOptionsMonitor<AuthenticationSchemeOptions> options, ILoggerFactory logger, UrlEncoder encoder) : base(options, logger, encoder)
    {
    }

    protected override Task<AuthenticateResult> HandleAuthenticateAsync()
    {
        if (!Request.Headers.ContainsKey("Authorization"))
        {
            return Task.FromResult(AuthenticateResult.Fail("Missing authorization key"));
        }

        var authorizationHeader = Request.Headers.Authorization.ToString();
        if (!authorizationHeader.StartsWith("Basic ", StringComparison.OrdinalIgnoreCase))
        {
            return Task.FromResult(AuthenticateResult.Fail("Authorization header does not start with 'Basic '"));
        }

        var authBase64Decoded = Encoding.UTF8.GetString(Convert.FromBase64String(authorizationHeader.Replace("Basic ", "", StringComparison.OrdinalIgnoreCase)));

        var authSplit = authBase64Decoded.Split([':'], 2);
        if (authSplit.Length != 2)
        {
            return Task.FromResult(AuthenticateResult.Fail("Invalid authorization format"));
        }

        var username = authSplit[0];
        var password = authSplit[1];   
        
        if (username != "ene" || password != "Parola123!")
        {
            return Task.FromResult(AuthenticateResult.Fail("Invalid credentials"));
        }

        var client = new BasicAuthenticationClient
        {
            AuthenticationType = "Basic",
            Name = username,
            IsAuthenticated = true,
        };

        var claimsPrincipal = new ClaimsPrincipal(new ClaimsIdentity(client, new[]
        {
            new Claim(ClaimTypes.Name, username),
        }));

        return Task.FromResult(AuthenticateResult.Success(new AuthenticationTicket(claimsPrincipal, Scheme.Name)));
    }
}
