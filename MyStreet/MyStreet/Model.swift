//
//  Model.swift
//  MyStreet
//
//  Created by Santos, Dario Ferreira on 14/03/2023.
//

import Foundation

var localizationAuthorization = false

struct Ocurrence {
    let description: String
    let location: String
}

var occurrencies = [Ocurrence(description: "Lâmpada partida", location: "Rua da Frente"),Ocurrence(description: "Buranco na estrada", location: "Rua do Lado"),Ocurrence(description: "Sinal Partido", location: "Rua de Trás"),Ocurrence(description: "Passeio estreito", location: "Rua de Cima"),Ocurrence(description: "Estacionamento abusivo", location: "Rua de Baixo"),Ocurrence(description: "Animal abandonado", location: "Rua do Outro Lado"),
]
