//
//  CreateRequirementView.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 20.11.22.
//

import SwiftUI

struct CreateRequirementView: View {
    
    enum schemes: String, CaseIterable, Identifiable {
        case Rupp = "Rupp's scheme"
        case none = "No scheme"
        
        var id: Self { self }
    }
    @State private var selectedScheme: schemes = .Rupp
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Picker("Scheme", selection: $selectedScheme) {
                        ForEach(schemes.allCases) { scheme in
                            Text(scheme.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    if (selectedScheme == .none) {
                        SubviewNone(requirement: "")
                    } else if (selectedScheme == .Rupp) {
                        SubviewRupp(requirement: "")
                    } else {
                        EmptyView()
                    }
                }
                .padding()
                .navigationBarTitle("Create Requirement")
                
                HStack (alignment: .bottom){
                    Button("Check") {
                        //TODO
                    }
                    .padding()
                    .background(.blue)
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    
                    Button("Save") {
                        //TODO
                    }
                    .padding()
                    .background(.blue)
                    .cornerRadius(15)
                    .foregroundColor(.white)
                }
                .padding()
            }
        }
    }
}

struct CreateRequirementView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRequirementView()
    }
}

struct SubviewNone: View {
    
    @State public var requirement: String
    
    var body: some View {
        VStack (alignment: .leading) {
            TextField("Enter requirement ...", text: self.$requirement, axis: .vertical)
                .lineLimit(5, reservesSpace: true)
                .textFieldStyle(.roundedBorder)
            
            Spacer()
            
            Text(requirement)
        }
    }
}

struct SubviewRupp: View {
    
    @State public var requirement: String
    
    @State var systemName = "The system"
    
    enum priorityOptions: String, CaseIterable, Identifiable {
        
        case shall = "shall"
        case should = "should"
        case will = "will"
        
        var id: Self { self }
    }
    @State private var prioritySelected: priorityOptions = .shall
    
    enum verbOptions: String, CaseIterable, Identifiable {
        
        case process = "<process verb>"
        case provide = "provide <whom>"
        case able = "be able to"
        
        var id: Self { self }
    }
    @State private var verbSelected: verbOptions = .process
    
    @State private var object = ""
    @State private var processVerb = ""
    @State private var details = ""
    
    func buildRequirement(prioritySelected: String, verbSelected: String, object: String, processVerb: String) -> String {
        var tmp: String = ""
        
        tmp = systemName + " " + prioritySelected + " "
        
        if (verbSelected == "provide <whom>") {
            tmp += "provide " + object + " with the ability to "
        } else if (verbSelected == "<process verb>") {
            tmp += processVerb + " "
        } else if (verbSelected == "be able to") {
            tmp += verbSelected + " " + processVerb + " "
        }
        
        tmp += details + "."
        
        return(tmp)
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            
            TextField("The System", text: $systemName)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
            
            Picker("Priority", selection: $prioritySelected) {
                ForEach(priorityOptions.allCases) { priority in
                    Text(priority.rawValue)
                }
            }
            
            Picker("Verb", selection: $verbSelected) {
                ForEach(verbOptions.allCases) { verb in
                    Text(verb.rawValue)
                }
            }
            
            if (verbSelected == .provide) {
                TextField("<whom>", text: $object)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                Text("with the ability to")
            } else {
                TextField("<process verb>", text: $processVerb)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
            }

            TextField("<details>", text: $details)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
            
            Spacer()
            
            let requirement = buildRequirement(prioritySelected: prioritySelected.rawValue, verbSelected: verbSelected.rawValue, object: object, processVerb: processVerb)
            
            Text(requirement)
        }
    }
}
