//
//  Cachorro.swift
//  BigDog
//
//  Created by Meyrillan Souza da Silva on 10/03/20.
//  Copyright © 2020 Meyrillan Souza da Silva. All rights reserved.
//
import UIKit
import Foundation

class Cachorro {
    var nomeTexto: String
    var racaTexto: String
    var racaImagem: UIImage
    ///idade apenas em meses
    var idadeValor: Int = 0
    var pesoValor: Float = 0
    
    init (nome: String, raca: String, racaDesenho: UIImage, idade: Int, peso: Float) {
        nomeTexto = nome
        racaTexto = raca
        racaImagem = racaDesenho
        idadeValor = idade
        pesoValor = peso
    }
    
    func transformarIdadeEmSemanas() -> Int {
        // pegar texto do picker idade, transformar em numero
        // Multiplicar 4 (quantidade de semanas) pela media aritimetica de meses
        // guardar resultado
        
        // Multiplicar 4 (quantidade de semanas) pela idade em meses
        
        let idadeEmSemanas = idadeValor * 4
        
        return idadeEmSemanas
    }
    
    func dividirPesoPorIdade() -> Float {
        
        // dividir o peso pelo resultado da funçao transformarIdadeEmSemanas
        
        let divisaoPesoPorIdade =  pesoValor / Float(transformarIdadeEmSemanas())
        
        //let resultadoString = String(divisaoPesoPorIdade
        
        return divisaoPesoPorIdade
    }
    
    func calcularResultadoFinal() -> Float {
        // pegar resultado da funçao dividirPesoPorIdade e multiplicar por 52
        let resultadoFinal = dividirPesoPorIdade() * 52
        
        return resultadoFinal
    }
    
}
