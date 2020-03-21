//
//  ViewController.swift
//  BigDog
//
//  Created by Meyrillan Souza da Silva on 02/03/20.
//  Copyright © 2020 Meyrillan Souza da Silva. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomeTextField.delegate = self
        idadeTextField.delegate = self
        pesoTextField.delegate = self
        racasTableView.dataSource = self
        racasTableView.delegate = self
        resultadoView.isHidden = true
        ViewToLabelResultado.layer.cornerRadius = 14
        ViewToLabelResultado.clipsToBounds = true
        calcularButtonOutlet.layer.cornerRadius = 14
        calcularButtonOutlet.clipsToBounds = true
        areaRacaButton.layer.cornerRadius = 14
        areaRacaButton.clipsToBounds = true
        areaIdadeButton.layer.cornerRadius = 14
        areaIdadeButton.clipsToBounds = true
        areaPesoButton.layer.cornerRadius = 14
        areaPesoButton.clipsToBounds = true
        exibirRaca.text = "Ex.: Vira-Lata (SRD)"
        exibirRaca.textColor = UIColor(red: 0.3608, green: 0.4157, blue: 0.5961, alpha: 1.0)
        fotoDog.image = UIImage(named: "dog")!
        fotoDog.layer.cornerRadius = 14
        fotoDog.clipsToBounds = true
        viewToTableView.layer.cornerRadius = 14
        viewToTableView.isHidden = true
    }
    
    var racas: [String] = ["Vira-Lata (SRD)", "Pug", "Maltês", "Shih Tzu", "Buldogue", "Pit Bull", "Spitz Alemão", "Dachshund", "Pastor-Alemão", "Basset", "Schnauzer", "Poodle", "RottWeiler", "Labrador", "Pinscher", "Lhasa Apso", "Golden Retriever", "Yorkshire", "Border Collie", "Beagle"]
    
    var dog: Cachorro = Cachorro(nome: "", raca: "", racaDesenho: UIImage(named: "dog")!, idade: 0, peso: 0)
    
    @IBOutlet var nomeTextField: UITextField!
    
    @IBOutlet var idadeTextField: UITextField!
    
    @IBOutlet var pesoTextField: UITextField!
    
    @IBOutlet var areaRacaButton: UIButton!
    
    @IBOutlet var areaIdadeButton: UIButton!
    
    @IBOutlet var areaPesoButton: UIButton!
    
    @IBOutlet var exibirRaca: UILabel!
    
    @IBOutlet var fotoDog: UIImageView!
    
    @IBOutlet var porteLabel: UILabel!
    
    @IBOutlet var resultadoLabel: UILabel!
    
    @IBOutlet var calcularButtonOutlet: UIButton!
    
    @IBOutlet var ViewToLabelResultado: UIView!
    
    @IBOutlet var resultadoView: UIView!
    
    @IBOutlet var viewToTableView: UIView!
    
    @IBOutlet var racasTableView: UITableView!
    
    @IBAction func escolherFoto(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "", message: "Tire uma foto do seu dog ou selecione-a na galeria.", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Câmera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil )
                self.viewToTableView.isHidden = false
            } else {
                let alert = UIAlertController(title: "", message: "Câmera não disponível.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Certo", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert,animated: true, completion: nil)
                self.viewToTableView.isHidden = false
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Galeria", style: .default, handler: { (action:UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil )
            self.viewToTableView.isHidden = false
        }))
        
        if fotoDog.image != UIImage(named: "dog")! {
            actionSheet.addAction(UIAlertAction(title: "Apagar Foto", style: .destructive, handler: { (action:UIAlertAction) in
                self.fotoDog.image = UIImage(named: "dog")!
                self.viewToTableView.isHidden = false
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        fotoDog.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapGesture(_ sender: Any) {
        nomeTextField.resignFirstResponder()
        idadeTextField.resignFirstResponder()
        pesoTextField.resignFirstResponder()
        viewToTableView.isHidden = true
        nomeTextField.isEnabled = true
    }
    
    @IBAction func areaRacaAction(_ sender: Any) {
        viewToTableView.isHidden = false
        nomeTextField.isEnabled = false
        //abrir a view da table view quando clicar na área da foto
    }
    
    @IBAction func calcularButton(_ sender: UIButton) {
        
        dog = Cachorro(nome: lerNome(), raca: exibirRaca.text ?? "", racaDesenho: UIImage(named: "dog")!, idade: lerIdade(), peso: lerPeso())
        nomeTextField.resignFirstResponder()
        idadeTextField.resignFirstResponder()
        pesoTextField.resignFirstResponder()
        
        if nomeTextField.text == "" || exibirRaca.text == "Ex.: Vira-Lata (SRD)" || idadeTextField.text == "" || pesoTextField.text == "" {
            let alert = UIAlertController(title: "Falta informação", message: "Você precisa preencher todos os campos antes de clicar em calcular.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Certo", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert,animated: true, completion: nil)
        }
        else if dog.idadeValor >= 12 {
            let alert = UIAlertController(title: "Opa!", message: "Seu dog precisa ter um ano ou menos para a previsão funcionar.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Certo", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert,animated: true, completion: nil)
        } else {
            let result = dog.calcularResultadoFinal()
            mostrarResultado(resultado: result)
            mostrarPorte()
            resultadoView.isHidden = false
        }
    }
    
    @IBAction func informacaoButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Como funciona?", message:"\n 1º -> Peso / idade (em semanas) = resultado \n 2º -> Resultado x 52 \n \n A previsão será mais precisa se seu pet for alimentado corretamente.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Certo", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }
    
    func textFieldShouldReturn() {
        nomeTextField.resignFirstResponder()
        idadeTextField.resignFirstResponder()
        pesoTextField.resignFirstResponder()
    }
    
    func lerNome() -> String {
        let nome = nomeTextField.text!
        return nome
    }
    
    func lerPeso() -> Float {
        // pegar texto do text field peso, transformar em numero, guardar o peso
        let peso = pesoTextField.text ?? ""
        
        // transformar o texto em int
        let pesoFloat = Float(peso) ?? 0
        
        return pesoFloat
    }
    
    func lerIdade() -> Int {
        // pegar texto do text field idade, transformar em numero, guardar a idade
        let idade = idadeTextField.text ?? ""
        let idadeInt = Int(idade) ?? 0
        
        return idadeInt
    }
    
    func MedidaCertaParaRaca() -> String {
        var infoMedidaCerta: String = ""
        if dog.racaTexto == "Vira-Lata (SRD)" {
            infoMedidaCerta = "Como \(dog.nomeTexto) não tem raça definida, não sabemos se seu peso está correto para sua idade."
        } else if dog.racaTexto == "Pug" {
            infoMedidaCerta = "O peso ideal de um Pug adulto está entre 6,3 e 8,1 kg."
        } else if dog.racaTexto == "Maltês" {
            infoMedidaCerta = "O peso ideal de um Maltês adulto está entre 3 e 4 kg."
        } else if dog.racaTexto == "Shih Tzu" {
            infoMedidaCerta = "O peso ideal de um Shih Tzu adulto está entre 4,5 e 8 kg."
        } else if dog.racaTexto == "Buldogue" {
            infoMedidaCerta = "O peso ideal de um Buldogue Francês adulto está entre 8 e 14 kg, e de um Buldogue Inglês está entre 20 e 25 kg."
        } else if dog.racaTexto == "Pit Bull" {
            infoMedidaCerta = "O peso ideal de um Pit Bull adulto está entre 14 e 30 kg."
        } else if dog.racaTexto == "Spitz Alemão" {
            infoMedidaCerta = "O peso ideal de um Spitz Alemão adulto pequeno está entre 8 e 14 kg, e um médio entre 15 e 25 kg."
        } else if dog.racaTexto == "Dachshund" {
            infoMedidaCerta = "O peso ideal de um Dachshund adulto Standard está entre 6,5 e 7 kg, já o anão é de até 4 kg, e o miniatura até 3,5 kg."
        } else if dog.racaTexto == "Pastor-Alemão" {
            infoMedidaCerta = "O peso ideal de uma fêmea Pastor-Alemão adulta está entre 22 e 32 kg, já o peso do macho está entre 30 e 40 kg."
        } else if dog.racaTexto == "Basset" {
            infoMedidaCerta = "O peso ideal de um Basset adulto está entre 20 e 29 kg."
        } else if dog.racaTexto == "Schnauzer" {
            infoMedidaCerta = "O peso ideal de um Schnauzer adulto gigante está entre 34 e 43 kg, já o standart entá entre 14 e 20 kg, e o miniatura entre 5 e 8,2 kg."
        } else if dog.racaTexto == "Poodle" {
            infoMedidaCerta = "O peso ideal de um Poodle adulto gigante está entre 27 e 32 kg, já o miniatura entá entre 4 e 7 kg, e o toy entre 2 e 3 kg."
        } else if dog.racaTexto == "RottWeiler" {
            infoMedidaCerta = "O peso ideal de uma fêmea RottWeiler adulta está entre 35 e 48 kg, já o peso do macho está entre 50 e 60 kg."
        } else if dog.racaTexto == "Labrador" {
            infoMedidaCerta = "O peso ideal de uma fêmea Labrador adulta está entre 25 e 32 kg, já o peso do macho está entre 29 e 36 kg."
        } else if dog.racaTexto == "Pinscher" {
            infoMedidaCerta = "O peso ideal de um Pinscher adulto está entre 3,5 e 5 kg."
        } else if dog.racaTexto == "Lhasa Apso" {
            infoMedidaCerta = "O peso ideal de um Lhasa Apso adulto está entre 5 e 8 kg."
        } else if dog.racaTexto == "Golden Retriever" {
            infoMedidaCerta = "O peso ideal de uma fêmea Golden Retriever adulta está entre 25 e 32 kg, já o peso do macho está entre 30 e 34 kg."
        } else if dog.racaTexto == "Yorkshire" {
            infoMedidaCerta = "O peso ideal de um Yorkshire adulto é de até 3,2 kg."
        } else if dog.racaTexto == "Border Collie" {
            infoMedidaCerta = "O peso ideal de uma fêmea Border Collie adulta está entre 12 e 19 kg, já o peso do macho está entre 14 e 20 kg."
        } else if dog.racaTexto == "Beagle" {
            infoMedidaCerta = "O peso ideal de um Beagle adulto está entre 9 e 11 kg."
        } else {
            infoMedidaCerta = ""
        }
        return infoMedidaCerta
    }
    
    func mostrarPorte() {
        if dog.calcularResultadoFinal() >= 0 && dog.calcularResultadoFinal() <= 14 {
            porteLabel.text = "\(dog.nomeTexto) será de porte pequeno!"
        }
        else if dog.calcularResultadoFinal() >= 14 && dog.calcularResultadoFinal() <= 30 {
            porteLabel.text = "\(dog.nomeTexto) será de porte médio!"
        }
        else if dog.calcularResultadoFinal() >= 30 && dog.calcularResultadoFinal() <= 55 {
            porteLabel.text = "\(dog.nomeTexto) será de porte grande!"
        } else {
            porteLabel.text = "\(dog.nomeTexto) será de porte gigante!"
        }
    }
    
    func mostrarResultado(resultado: Float) {
        ///outra forma: let resultString = "\(resultado)"
        /// resultadoLabel.text = resultStrin
        let resultString = String(format:"%.2f",resultado)
        resultadoLabel.text = "A previsão é que \(dog.nomeTexto) tenha \(resultString) quilos quando estiver com um ano de idade. \(MedidaCertaParaRaca())"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return racas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "racaCell", for: indexPath) as? RacaTableViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.configure(nome: racas[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        exibirRaca.text = racas[indexPath.row]
        exibirRaca.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
    }
    
}
