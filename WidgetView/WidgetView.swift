//
//  WidgetView.swift
//  WidgetView
//
//  Created by Patrick Fezer on 09.09.20.
//

import WidgetKit
import SwiftUI


// MARK: Preview with constant Values
let BarViewWithConstantValues = BarViewEntry(date: Date(), BarKcal: BarForWidgetView(title: "Kalorien", color: .blue, destinationAmount:                                                      2800, currentAmount: 2350, showUnit: false),
                                             BarFat: BarForWidgetView(title: "Fett", color: .red, destinationAmount: 60, currentAmount: 45, showUnit: true),
                                             BarSaturated: BarForWidgetView(title: "Ges. Fetts.", color: .red, destinationAmount: 25, currentAmount: 12.5, showUnit: true),
                                             BarCarbs: BarForWidgetView(title: "Carbs", color: .orange, destinationAmount: 400, currentAmount: 250, showUnit: true),
                                             BarRoughage: BarForWidgetView(title: "Ballastst.", color: .orange, destinationAmount: 50, currentAmount: 20.5, showUnit: true),
                                             BarSugar: BarForWidgetView(title: "Zucker", color: .orange, destinationAmount: 60, currentAmount: 45, showUnit: true),
                                             BarProtein: BarForWidgetView(title: "Protein", color: .green, destinationAmount: 180, currentAmount: 125, showUnit: true),
                                             BarLLeucin: BarForWidgetView(title: "L-Leucin", color: .green, destinationAmount: 15, currentAmount: 7.5, showUnit: true),
                                             BarSalt: BarForWidgetView(title: "Salz", color: Color("saltColor"), destinationAmount: 8, currentAmount: 4, showUnit: true))


// MARK: BarViewEntry
struct BarViewEntry: TimelineEntry {
    
    var date: Date
    let BarKcal: BarForWidgetView
    let BarFat: BarForWidgetView
    let BarSaturated: BarForWidgetView
    let BarCarbs: BarForWidgetView
    let BarRoughage: BarForWidgetView
    let BarSugar: BarForWidgetView
    let BarProtein: BarForWidgetView
    let BarLLeucin: BarForWidgetView
    let BarSalt: BarForWidgetView
}


// MARK: Provider
struct Provider: TimelineProvider {
    
    // MARK: Saved Data

    @AppStorage("destinationAmounts", store: UserDefaults(suiteName: "group.com.fezer.Kalorientracker"))
    var destinationAmounts: Data = Data()
    
    @AppStorage("currentAmounts", store: UserDefaults(suiteName: "group.com.fezer.Kalorientracker"))
    var currentAmounts: Data = Data()

    
    var getCurrentAmounts: [String : Double] {
        
        
        guard let getterCurrentAmounts = try? JSONDecoder().decode([String : Double].self, from: currentAmounts) else {
            print("error")
            return ["" : 0]
        }
        
        print("Updatet current amounts")
        return getterCurrentAmounts
        
    }
    
    var getDestinationAmounts: [String : String] {
        
        guard let getterDestinationAmounts = try? JSONDecoder().decode([String : String].self, from: destinationAmounts) else {
            print("error")
            return ["" : ""]
        }
        
        print("Updatet destination amounts")
        return getterDestinationAmounts
    }

    // MARK: Placeholer
    func placeholder(in context: Context) -> BarViewEntry {
        return BarViewWithConstantValues
    }
    
    // MARK: Snapshot
    // Showing in the widget Configuration view from iOS
    func getSnapshot(in context: Context, completion: @escaping (BarViewEntry) -> Void) {
        
        let entry = BarViewWithConstantValues
        
        completion(entry)
    }
    
    // MARK: TimeLine
    func getTimeline(in context: Context, completion: @escaping (Timeline<BarViewEntry>) -> Void) {

        
        let entry = BarViewEntry(date: Date(), BarKcal: BarForWidgetView(title: "Kalorien", color: .blue, destinationAmount: CGFloat(Double(getDestinationAmounts["kcal"]!.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(getCurrentAmounts["kcal"]!), showUnit: false),
            BarFat: BarForWidgetView(title: "Fett", color: .red, destinationAmount: CGFloat(Double(getDestinationAmounts["fat"]!.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(getCurrentAmounts["fat"]!), showUnit: true),
            BarSaturated: BarForWidgetView(title: "Ges. Fetts.", color: .red, destinationAmount: CGFloat(Double(getDestinationAmounts["saturated"]!.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(getCurrentAmounts["saturated"]!), showUnit: true),
            BarCarbs: BarForWidgetView(title: "Carbs", color: .orange, destinationAmount: CGFloat(Double(getDestinationAmounts["carbs"]!.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(getCurrentAmounts["carbs"]!), showUnit: true),
            BarRoughage: BarForWidgetView(title: "Ballastst.", color: .orange, destinationAmount: CGFloat(Double(getDestinationAmounts["roughage"]!.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(getCurrentAmounts["roughage"]!), showUnit: true),
            BarSugar: BarForWidgetView(title: "Zucker", color: .orange, destinationAmount: CGFloat(Double(getDestinationAmounts["sugar"]!.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(getCurrentAmounts["sugar"]!), showUnit: true),
            BarProtein: BarForWidgetView(title: "Protein", color: .green, destinationAmount: CGFloat(Double(getDestinationAmounts["protein"]!.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(getCurrentAmounts["protein"]!), showUnit: true),
            BarLLeucin: BarForWidgetView(title: "L-Leucin", color: .green, destinationAmount: CGFloat(Double(getDestinationAmounts["leucin"]!.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(getCurrentAmounts["leucin"]!), showUnit: true),
            BarSalt: BarForWidgetView(title: "Salz", color: Color("saltColor"), destinationAmount: CGFloat(Double(getDestinationAmounts["salt"]!.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(getCurrentAmounts["salt"]!), showUnit: true))
        
        
        let timeLine = Timeline(entries: [entry], policy: .atEnd)
        completion(timeLine)
    }
}

// MARK: PlaceHolderView
struct PlaceHolderView: View {
    var body: some View {
        VStack {
            BarForWidgetView(title: "Kalorien", color: .blue, destinationAmount: 2800, currentAmount: 2400, showUnit: false)
            BarForWidgetView(title: "Carbs", color: .orange, destinationAmount: 400, currentAmount: 125, showUnit: true)
            BarForWidgetView(title: "Fett", color: .red, destinationAmount: 60, currentAmount: 55, showUnit: true)
        }
    }
}

// MARK: WidgetEntryView
struct WidgetEntryView: View {
    
    let entry: Provider.Entry

    @Environment (\.widgetFamily) private var widgetFamily
    
    var body: some View {
        
        if widgetFamily == .systemMedium  {
            VStack {
                BarForWidgetView(title: entry.BarKcal.title, color: entry.BarKcal.color, destinationAmount: entry.BarKcal.destinationAmount, currentAmount: entry.BarKcal.currentAmount, showUnit: entry.BarKcal.showUnit)
                BarForWidgetView(title: entry.BarProtein.title, color: entry.BarProtein.color, destinationAmount: entry.BarProtein.destinationAmount, currentAmount: entry.BarProtein.currentAmount, showUnit: entry.BarProtein.showUnit)
                BarForWidgetView(title: entry.BarCarbs.title, color: entry.BarCarbs.color, destinationAmount: entry.BarCarbs.destinationAmount, currentAmount: entry.BarCarbs.currentAmount, showUnit: entry.BarCarbs.showUnit)
            }
            .padding()
            .background(Color("WidgetBackground"))
            
        } else if widgetFamily == .systemLarge {
            VStack {
                BarForWidgetView(title: entry.BarKcal.title, color: entry.BarKcal.color, destinationAmount: entry.BarKcal.destinationAmount, currentAmount: entry.BarKcal.currentAmount, showUnit: entry.BarKcal.showUnit)
                BarForWidgetView(title: entry.BarFat.title, color: entry.BarFat.color, destinationAmount: entry.BarFat.destinationAmount, currentAmount: entry.BarFat.currentAmount, showUnit: entry.BarFat.showUnit)
                BarForWidgetView(title: entry.BarSaturated.title, color: entry.BarSaturated.color, destinationAmount: entry.BarSaturated.destinationAmount, currentAmount: entry.BarSaturated.currentAmount, showUnit: entry.BarSaturated.showUnit)
                BarForWidgetView(title: entry.BarCarbs.title, color: entry.BarCarbs.color, destinationAmount: entry.BarCarbs.destinationAmount, currentAmount: entry.BarCarbs.currentAmount, showUnit: entry.BarCarbs.showUnit)
                BarForWidgetView(title: entry.BarProtein.title, color: entry.BarProtein.color, destinationAmount: entry.BarProtein.destinationAmount, currentAmount: entry.BarProtein.currentAmount, showUnit: entry.BarProtein.showUnit)
                BarForWidgetView(title: entry.BarLLeucin.title, color: entry.BarLLeucin.color, destinationAmount: entry.BarLLeucin.destinationAmount, currentAmount: entry.BarLLeucin.currentAmount, showUnit: entry.BarLLeucin.showUnit)
            }
            .padding()
            .padding(.top, 2)
            .padding(.bottom, 2)
            .background(Color("WidgetBackground"))
            }
    }
}


// MARK: Main
@main
struct WidgetView: Widget {
    private let kind = "WidgetView"
    
    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium, .systemLarge])
        .configurationDisplayName("Fortschritte")
        .description("Behalte deinen aktuellen Fortschritt ganz einfach im Auge.")
    }
}


// MARK: Previews
struct WidgetViewMedium_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: BarViewWithConstantValues)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}


struct WidgetViewLarge_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: BarViewWithConstantValues)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .environment(\.colorScheme, .dark)
    }
}
