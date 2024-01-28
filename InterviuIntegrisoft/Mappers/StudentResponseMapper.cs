using InterviuIntegrisoft.DTOs;
using InterviuIntegrisoft.Entities;
using Riok.Mapperly.Abstractions;

namespace InterviuIntegrisoft.Mappers;

public partial class StudentResponseMapper
{
    [Mapper]
    public partial class StudentMapper
    {
        [MapProperty(nameof(Student.Nume), nameof(StudentResponse.Nume))]
        [MapProperty(nameof(Student.Prenume), nameof(StudentResponse.Prenume))]
        public partial StudentResponse MapToStudentResponse(Student student);
    }
}
