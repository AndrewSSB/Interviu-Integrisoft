namespace InterviuIntegrisoft.DTOs;

public class StudentResponse
{
    public string Nume { get; set; }
    public string Prenume { get; set; }
    public string Grupa { get; set; }
    public string OrasulDeResedinta { get; set; }
    public List<GradesResponse> Note { get; set; }
}
