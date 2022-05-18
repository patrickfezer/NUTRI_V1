//
//  WidgetView.swift
//  WidgetView
//
//  Created by Patrick Fezer on 09.09.20.
//

import WidgetKit
import SwiftUI


// MARK: BarEntry
struct BarViewEntry: TimelineEntry {
    let date: Date
    let kcal: WidgetData
    let fat: WidgetData
    let saturated: WidgetData
    let carbs: WidgetData
    let protein: WidgetData
    let leucin: WidgetData
}

// MARK: BarEntry with constant Values
// Used in Placeholder and Snapshot Views
let constantWidgetData = BarViewEntry(date: Date(), kcal: WidgetData(title: "Kcal", destinationAmount: 2800, currentAmount: 2300, color: .blue, showUnit: false), fat: WidgetData(title: "Fett", destinationAmount: 60, currentAmount: 35, color: .red, showUnit: true), saturated: WidgetData(title: "Ges. Fettsäuren", destinationAmount: 10, currentAmount: 6.5, color: .red, showUnit: true), carbs: WidgetData(title: "Carbs", destinationAmount: 400, currentAmount: 355, color: .orange, showUnit: true), protein: WidgetData(title: "Protein", destinationAmount: 200, currentAmount: 135, color: .green, showUnit: true), leucin: WidgetData(title: "L-Leucin", destinationAmount: 25, currentAmount: 7.5, color: .blue, showUnit: true))


// MARK: Provider
struct Provider: TimelineProvider {
    
    // Saved Data in App Group
    @AppStorage("destinationAmounts", store: UserDefaults(suiteName: "group.com.fezer.shared")) var destinationAmounts: Data = Data()
    
    @AppStorage("currentAmounts", store: UserDefaults(suiteName: "group.com.fezer.shared")) var currentAmounts: Data = Data()

    
    // Variables Dictionary ----------------------------------
    var getCurrentAmounts: [String : Double] {
        
        
        guard let getterCurrentAmounts = try? JSONDecoder().decode([String : Double].self, from: currentAmounts) else {
            print("error")
            return ["" : 0]
        }
        
        print("Updated current amounts")
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
    // -------------------------------------------------------
    
    
    // Functions to get Values as Valid CGFloat ----------------------------------------
    func getterDestinationAmount(_ key: String) -> CGFloat {

        return CGFloat(Double(getDestinationAmounts[key]!.replacingOccurrences(of: ",", with: ".")) ?? 0)

    }
    
    func getterCurrentAmount(_ key: String) -> CGFloat {
        return CGFloat(getCurrentAmounts[key] ?? 0)
    }
    // ---------------------------------------------------------------------------------

    
    // Placeholer -> return const. Values
    func placeholder(in context: Context) -> BarViewEntry {
        return constantWidgetData
    }
    
    // Snapshot
    // Showing in the widget Configuration view from iOS
    func getSnapshot(in context: Context, completion: @escaping (BarViewEntry) -> Void) {
        
        let entry = constantWidgetData
        
        completion(entry)
    }
    
    // TimeLine
    func getTimeline(in context: Context, completion: @escaping (Timeline<BarViewEntry>) -> Void) {
        
        
        
        let entry = BarViewEntry(date: Date(), kcal: WidgetData(title: "Kalorien", destinationAmount: getterDestinationAmount("kcal"), currentAmount: getterCurrentAmount("kcal"), color: .blue, showUnit: false), fat: WidgetData(title: "Fett", destinationAmount: getterDestinationAmount("fat"), currentAmount: getterCurrentAmount("fat"), color: .red, showUnit: true), saturated: WidgetData(title: "Ges. Fetts.", destinationAmount: getterDestinationAmount("saturated"), currentAmount: getterCurrentAmount("saturated"), color: .red, showUnit: true), carbs: WidgetData(title: "Carbs", destinationAmount: getterDestinationAmount("carbs"), currentAmount: getterCurrentAmount("carbs"), color: .orange, showUnit: true), protein: WidgetData(title: "Protein", destinationAmount: getterDestinationAmount("protein"), currentAmount: getterCurrentAmount("protein"), color: .green, showUnit: true), leucin: WidgetData(title: "L-Leucin", destinationAmount: getterDestinationAmount("leucin"), currentAmount: getterCurrentAmount("leucin"), color: .green, showUnit: true))
        
        
        
        let timeLine = Timeline(entries: [entry], policy: .atEnd)
        completion(timeLine)
    }
}

// MARK: PlaceHolderView
struct PlaceHolderView: View {
    var body: some View {
        Text("Keine Daten gefunden.")
    }
}

// MARK: WidgetEntryView
struct WidgetEntryView: View {
    
    let entry: Provider.Entry
    

    @Environment (\.widgetFamily) private var widgetFamily
    
    
    var body: some View {
        
        if widgetFamily == .systemMedium  {
            VStack {
                BarForWidgetView(title: entry.kcal.title, color: entry.kcal.color, destinationAmount: entry.kcal.destinationAmount, currentAmount: entry.kcal.currentAmount, showUnit: entry.kcal.showUnit)
                BarForWidgetView(title: entry.protein.title, color: entry.protein.color, destinationAmount: entry.protein.destinationAmount, currentAmount: entry.protein.currentAmount, showUnit: entry.protein.showUnit)
                BarForWidgetView(title: entry.carbs.title, color: entry.carbs.color, destinationAmount: entry.carbs.destinationAmount, currentAmount: entry.carbs.currentAmount, showUnit: entry.carbs.showUnit)
            }
            .padding()
            .padding(.top, 25)
            .padding(.bottom, 25)
            .background(Color("WidgetBackground"))
            
        } else if widgetFamily == .systemLarge {
            VStack {
                BarForWidgetView(title: entry.kcal.title, color: entry.kcal.color, destinationAmount: entry.kcal.destinationAmount, currentAmount: entry.kcal.currentAmount, showUnit: entry.kcal.showUnit)
                BarForWidgetView(title: entry.fat.title, color: entry.fat.color, destinationAmount: entry.fat.destinationAmount, currentAmount: entry.fat.currentAmount, showUnit: entry.fat.showUnit)
                BarForWidgetView(title: entry.saturated.title, color: entry.saturated.color, destinationAmount: entry.saturated.destinationAmount, currentAmount: entry.saturated.currentAmount, showUnit: entry.saturated.showUnit)
                BarForWidgetView(title: entry.carbs.title, color: entry.carbs.color, destinationAmount: entry.carbs.destinationAmount, currentAmount: entry.carbs.currentAmount, showUnit: entry.carbs.showUnit)
                BarForWidgetView(title: entry.protein.title, color: entry.protein.color, destinationAmount: entry.protein.destinationAmount, currentAmount: entry.protein.currentAmount, showUnit: entry.protein.showUnit)
                BarForWidgetView(title: entry.leucin.title, color: entry.leucin.color, destinationAmount: entry.leucin.destinationAmount, currentAmount: entry.leucin.currentAmount, showUnit: entry.leucin.showUnit)
            }
            .padding()
            .padding(.top, 35)
            .padding(.bottom, 35.0)
            .background(Color("WidgetBackground"))
        } else if widgetFamily == .systemSmall {
            
            let progress = CGFloat(entry.kcal.currentAmount / entry.kcal.destinationAmount)
            
            CircleView(progressLength: progress)
                .padding(25)
                .padding(.top, 25)
                .padding(.bottom, 25)
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
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .configurationDisplayName("Fortschritte")
        .description("Behalte deinen aktuellen Fortschritt ganz einfach im Auge.")
    }
}


// MARK: Previews
struct WidgetViewSmall_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: constantWidgetData)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .environment(\.colorScheme, .dark)
    }
}

struct WidgetViewMedium_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: constantWidgetData)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .environment(\.colorScheme, .dark)
    }
}

struct WidgetViewLarge_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: constantWidgetData)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .environment(\.colorScheme, .dark)
    }
}
