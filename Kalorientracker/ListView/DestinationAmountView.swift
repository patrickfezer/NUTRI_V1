//
//  DestinationAmountView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 04.09.20.
//

import SwiftUI
import WidgetKit

struct DestinationAmountView: View {
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var appData: AppData
    @State private var destinationValuesTraining = destinationAmountWithTraining()
    @State private var showDeleteConfirmationView = false
    @State private var defaultValuesCommited = false
    @State private var showFinishButton = false
    @AppStorage("saveKeySelection") var selection = 0
    static let categories = ["Aufbau", "Erhalt", "Diät"]
    
    // Einrichtung der App - FirstStartApp = false
    
    var buttonLabel: Text {
        var text = Text("")
        
        if appData.appsFirstStart {
            text = Text("done")
        } else {
            if showFinishButton {
                text = Text("done")
            } else {
                text = Text("finish")
            }
        }
        
        
        return text
    }
    
    // MARK: Functions
    func setDestinationValues(index: Int) {
        
        // Werte im Cart auf Auswahl der Trainingsdaten setzen
        cart.destinationKcal = destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.kcal
        cart.destinationFat = destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.fat
        cart.destinationSaturated = destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.saturated
        cart.destinationCarbs = destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.carbs
        cart.destinationRoughage = destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.roughage
        cart.destinationSugar = destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.sugar
        cart.destinationProtein = destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.protein
        cart.destinationLeucin = destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.leucin
        cart.destinationSalt = destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.salt
        
        
        cart.save()
        
        DispatchQueue.main.async {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    func setTrainingValues(index: Int) {
        
        // Trainingsdaten auf Cart setzen
        destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.kcal = cart.destinationKcal
        destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.fat = cart.destinationFat
        destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.saturated = cart.destinationSaturated
        destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.carbs = cart.destinationCarbs
        destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.roughage = cart.destinationRoughage
        destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.sugar = cart.destinationSugar
        destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.protein = cart.destinationProtein
        destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.leucin = cart.destinationLeucin
        destinationValuesTraining.entries[DestinationAmountView.categories[index]]!.salt = cart.destinationSalt
        
        destinationValuesTraining.save()
        
        DispatchQueue.main.async {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    
    
    var body: some View {
        
        List {
            Section(header: Text("destinationValues")) {
                Group {
                    DestinationAmountInputView(productName: Text("calories"), textValue: $cart.destinationKcal, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: Text("fat"), textValue: $cart.destinationFat, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: Text("saturated"), textValue: $cart.destinationSaturated, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: Text("carbs"), textValue: $cart.destinationCarbs, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: Text("roughage"), textValue: $cart.destinationRoughage, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: Text("sugar"), textValue: $cart.destinationSugar, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: Text("protein"), textValue: $cart.destinationProtein, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: Text("leucine"), textValue: $cart.destinationLeucin, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: Text("salt"), textValue: $cart.destinationSalt, isEdeting: $showFinishButton)

                }
                .onTapGesture {
                    setTrainingValues(index: selection)
                    cart.save()
                    self.hideKeyboard()
                    showFinishButton = false
                }
            }
            
            Section {
                Picker("destinationSelection", selection: $selection) {
                    ForEach(0..<DestinationAmountView.categories.count, id: \.self) {
                        Text(DestinationAmountView.categories[$0])
                    }
                }
                
                Button("reset") {
                    showDeleteConfirmationView = true
                }
                .actionSheet(isPresented: $showDeleteConfirmationView, content: {
                    ActionSheet(title: Text("reset"), message: Text("resetWarningText"), buttons: [
                        .destructive(Text("delete"), action: {
                            cart.deleteAllProductValues()
                            destinationValuesTraining.removeAllValues()
                            selection = 0
                            
                            DispatchQueue.main.async {
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                        }),
                        .cancel()
                    ])
                })
                .foregroundColor(.red)
            } header: {
                Text("Training & Reset")
            }
            
        
        }
        .onChange(of: selection, perform: { newValue in
            setDestinationValues(index: selection)
        })
        .listStyle(GroupedListStyle())
        
        .navigationBarTitle(Text("Zielwerte"), displayMode: .inline)
        .toolbar(content: {
            Button {
                // Überprüfung auf ersten Start der App
                if !appData.appsFirstStart && buttonLabel == Text("finish") {
                    appData.saveValue()
                }
                

                self.hideKeyboard()
                self.showFinishButton = false
                
                setTrainingValues(index: selection)
                
                cart.saveProductValues()
            } label: {
                buttonLabel
                    .disabled(!showFinishButton && appData.appsFirstStart)
                
            }

        })
        .navigationBarBackButtonHidden(showFinishButton)
    }
}

struct DestinationAmountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DestinationAmountView()
                .environmentObject(Cart())
                .environmentObject(AppData())
        }
    }
}
