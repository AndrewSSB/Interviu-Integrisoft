using FastEndpoints;
using InterviuIntegrisoft.DTOs;
using InterviuIntegrisoft.Interfaces;

namespace InterviuIntegrisoft.Endpoints;

public class GetStudentGPA(IStudentService _studentService) : EndpointWithoutRequest<StudentGPAResponse>
{
    public override void Configure()
    {
        Get("/student-gpa");
    }
    public override async Task HandleAsync(CancellationToken ct)
    {
        int studentId = Query<int>("studentId", isRequired: false);

        var studentGPA = await _studentService.GetStudentGPA(studentId);

        if (studentGPA is null)
        {
            AddError("There is no student with the specified id");
            ThrowIfAnyErrors();
        }

        await SendAsync(studentGPA!, cancellation: ct);
    }
}
