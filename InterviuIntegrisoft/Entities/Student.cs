namespace InterviuIntegrisoft.Entities;

public partial class Student
{
    public int Id { get; set; }

    public int GrupaLaCareApartine { get; set; }

    public int OrasulDeResedinta { get; set; }

    public string? Nume { get; set; }

    public string? Prenume { get; set; }

    public virtual Grupa GrupaLaCareApartineNavigation { get; set; } = null!;

    public virtual ICollection<Note> Notes { get; set; } = new List<Note>();

    public virtual Orase OrasulDeResedintaNavigation { get; set; } = null!;
}
