using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InterviuIntegrisoft.Authentication;

public class BasicAuthenticationAttribute : AuthorizeAttribute
{
    public BasicAuthenticationAttribute()
    {
        AuthenticationSchemes = "Basic";
    }
}
