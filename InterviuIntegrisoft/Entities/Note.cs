using System;
using System.Collections.Generic;

namespace InterviuIntegrisoft.Entities;

public partial class Note
{
    public int Id { get; set; }

    public int Student { get; set; }

    public int Materia { get; set; }

    public int? NotaObtinuta { get; set; }

    public virtual Materie MateriaNavigation { get; set; } = null!;

    public virtual Student StudentNavigation { get; set; } = null!;
}
