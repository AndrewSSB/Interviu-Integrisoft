using System;
using System.Collections.Generic;

namespace InterviuIntegrisoft.Entities;

public partial class Materie
{
    public int Id { get; set; }

    public string? Nume { get; set; }

    public virtual ICollection<Note> Note { get; set; } = new List<Note>();
}
