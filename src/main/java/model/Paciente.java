package model;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Paciente {
    private long id;
    private Usuario usuario; //herdando dados básicos de ‘login’
    private String cpf;
}
