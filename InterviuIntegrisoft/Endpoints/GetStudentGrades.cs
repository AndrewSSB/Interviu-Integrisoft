using FastEndpoints;
using InterviuIntegrisoft.DTOs;
using InterviuIntegrisoft.Interfaces;

namespace InterviuIntegrisoft.Endpoints;

public class GetStudentGrades(IStudentService _studentService) : EndpointWithoutRequest<StudentResponse>
{
    public override void Configure()
    {
        Get("/grades-and-courses");
    }
    public override async Task HandleAsync(CancellationToken ct)
    {
        int studentId = Query<int>("studentId", isRequired: false);

        var studentGrades = await _studentService.GetStudentsGrades(studentId);

        if (studentGrades is null)
        {
            AddError("There is no student with the specified id");
            ThrowIfAnyErrors();
        }

        await SendAsync(studentGrades!, cancellation: ct);
    }
}
