using InterviuIntegrisoft.DTOs;
using InterviuIntegrisoft.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace InterviuIntegrisoft.Services;

public class StudentService(UniversitateContext _context) : IStudentService
{
    public async Task<StudentGPAResponse?> GetStudentGPA(int studentId)
    {
        var studentExists = await _context.Student.AnyAsync(x => x.Id == studentId);
        if (!studentExists)
        {
            return null;
        }

        var studentGrades = await _context.Note
            .Include(x => x.MateriaNavigation)
            .Where(n => n.Student == studentId)
            .GroupBy(n => n.Materia)
            .Select(g => g.OrderByDescending(n => n.Id).First())
            .ToListAsync();

        var GPA = studentGrades.Select(x => x.NotaObtinuta).Sum(x => (float?)x ?? 0.0F) / studentGrades.Count;

        return new StudentGPAResponse
        {
            GPA = (int)Math.Round(GPA)
        };
    }

    public async Task<StudentResponse?> GetStudentsGrades(int studentId)
    {
        var studentGrades = await _context.Student
            .Include(x => x.GrupaLaCareApartineNavigation)
            .Include(x => x.OrasulDeResedintaNavigation)
            .Include(x => x.Notes)
            .Where(x => x.Id == studentId)
            .Select(x => new StudentResponse
            {
                Nume = x.Nume ?? string.Empty,
                Prenume = x.Prenume ?? string.Empty,
                Grupa = x.GrupaLaCareApartineNavigation.Denumire ?? string.Empty,
                OrasulDeResedinta = x.OrasulDeResedintaNavigation.Denumire ?? string.Empty,
                Note = x.Notes.Select(y => new GradesResponse
                {
                    Nota = y.NotaObtinuta ?? default,
                    NumeMaterie = y.MateriaNavigation.Nume ?? string.Empty,
                }).ToList()
            })
            .FirstOrDefaultAsync();

        return studentGrades;
    }
}
