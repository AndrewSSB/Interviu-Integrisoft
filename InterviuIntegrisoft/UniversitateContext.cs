using InterviuIntegrisoft.Entities;
using Microsoft.EntityFrameworkCore;

namespace InterviuIntegrisoft;

public partial class UniversitateContext : DbContext
{
    public UniversitateContext()
    {
    }

    public UniversitateContext(DbContextOptions<UniversitateContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Grupa> Grupa { get; set; }

    public virtual DbSet<Materie> Materie { get; set; }

    public virtual DbSet<Note> Note { get; set; }

    public virtual DbSet<Orase> Orase { get; set; }

    public virtual DbSet<Student> Student { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Data Source=.\\SQLEXPRESS;Initial Catalog=Universitate;Integrated Security=True;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.UseCollation("SQL_Latin1_General_CP1_CI_AI");

        modelBuilder.Entity<Grupa>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Grupa__3214EC072020674F");

            entity.ToTable("Grupa");

            entity.HasIndex(e => e.Denumire, "IDX_Denumire_Grupa").IsUnique();

            entity.HasIndex(e => e.Denumire, "UQ_Denumire_Grupa").IsUnique();

            entity.Property(e => e.Denumire).HasMaxLength(100);
        });

        modelBuilder.Entity<Materie>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Materie__3214EC07786CB229");

            entity.ToTable("Materie");

            entity.HasIndex(e => e.Nume, "IDX_Nume_Materie").IsUnique();

            entity.HasIndex(e => e.Nume, "UQ_Nume_Materie").IsUnique();

            entity.Property(e => e.Nume).HasMaxLength(100);
        });

        modelBuilder.Entity<Note>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Note__3214EC07D2B566D2");

            entity.ToTable("Note");

            entity.Property(e => e.NotaObtinuta).HasColumnName("Nota_obtinuta");

            entity.HasOne(d => d.MateriaNavigation).WithMany(p => p.Note)
                .HasForeignKey(d => d.Materia)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Note_Materie");

            entity.HasOne(d => d.StudentNavigation).WithMany(p => p.Notes)
                .HasForeignKey(d => d.Student)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Note_Student");
        });

        modelBuilder.Entity<Orase>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Orase__3214EC07B811EE20");

            entity.ToTable("Orase");

            entity.HasIndex(e => e.Denumire, "IDX_Denumire_Oras").IsUnique();

            entity.HasIndex(e => e.Denumire, "UQ_Denumire_Orase").IsUnique();

            entity.Property(e => e.Denumire).HasMaxLength(100);
        });

        modelBuilder.Entity<Student>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Student__3214EC074CE21B9F");

            entity.ToTable("Student");

            entity.Property(e => e.GrupaLaCareApartine).HasColumnName("Grupa_la_care_apartine");
            entity.Property(e => e.Nume).HasMaxLength(100);
            entity.Property(e => e.OrasulDeResedinta).HasColumnName("Orasul_de_resedinta");
            entity.Property(e => e.Prenume).HasMaxLength(100);

            entity.HasOne(d => d.GrupaLaCareApartineNavigation).WithMany(p => p.Students)
                .HasForeignKey(d => d.GrupaLaCareApartine)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Student_Grupa");

            entity.HasOne(d => d.OrasulDeResedintaNavigation).WithMany(p => p.Students)
                .HasForeignKey(d => d.OrasulDeResedinta)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Student_Oras");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
