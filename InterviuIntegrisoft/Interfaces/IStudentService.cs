using InterviuIntegrisoft.DTOs;

namespace InterviuIntegrisoft.Interfaces;

public interface IStudentService
{
    Task<StudentResponse?> GetStudentsGrades(int studentId);
    Task<StudentGPAResponse?> GetStudentGPA(int studentId);
}
