//
//  Model.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 14/03/2023.
//

import Foundation

var localizationAuthorization = true


struct Occurrence {
    let description: String
    let location: String
    let type: String
}

var occurrences = [Occurrence(description: "Lâmpada partida", location: "Rua da Frente", type: "Iluminação Pública"),
                    Occurrence(description: "Buranco na estrada", location: "Rua do Lado", type: "Piso em Mau Estado"),
                    Occurrence(description: "Sinal Partido", location: "Rua de Trás", type: "Outros"),
                    Occurrence(description: "Passeio estreito", location: "Rua de Cima", type: "Piso em Mau Estado"),
                    Occurrence(description: "Estacionamento abusivo", location: "Rua de Baixo", type: "Outros"),
                    Occurrence(description: "Animal abandonado", location: "Rua do Outro Lado", type: "Animais Abandonados"),
]
