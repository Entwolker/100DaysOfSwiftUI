//
//  PropectsView.swift
//  Hot Prospects
//
//  Created by Kevin Hoàng on 26.05.21.
//

import CodeScanner
import SwiftUI

struct ProspectsView: View {
    
    @EnvironmentObject var prospects: Prospects
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    @State private var showingScanner = false
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted"
        case .uncontacted:
            return "Uncontacted"
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(prospect.email)
                            .font(Font.system(.subheadline, design: .monospaced))
                            .foregroundColor(.secondary)
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            prospects.toggle(prospect)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationBarTitle(title)
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    self.showingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                })
            
            .sheet(isPresented: $showingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Kevin Hoàng\nbinxkevin@gmx.de", completion: self.handleScan)
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.showingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.email = details[1]
            
            self.prospects.people.append(person)
            
            prospects.saveData()
        case .failure(_):
            print("Scanning failed")
        }
    }
    
    func delete(at offsets: IndexSet) {
        prospects.people.remove(atOffsets: offsets)
        
        prospects.saveData()
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
