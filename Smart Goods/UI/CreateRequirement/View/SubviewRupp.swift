//
//  SubviewRupp.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 27.11.22.
//

import SwiftUI

struct SubviewRupp: View {

    @Binding var requirement: String

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
        var requirement: String = ""

        requirement = systemName + " " + prioritySelected + " "

        if (verbSelected == "provide <whom>") {
            requirement += "provide " + object + " with the ability to "
        } else if (verbSelected == "<process verb>") {
            requirement += processVerb + " "
        } else if (verbSelected == "be able to") {
            requirement += verbSelected + " " + processVerb + " "
        }

        requirement += details + "."

        self.requirement = requirement

        return(requirement)
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

            Text(
                buildRequirement(prioritySelected: prioritySelected.rawValue,
                                 verbSelected: verbSelected.rawValue,
                                 object: object,
                                 processVerb: processVerb)
            )
        }
    }
}

struct SubviewRupp_Previews: PreviewProvider {
    static var previews: some View {
        SubviewRupp(requirement: .constant(""))
    }
}
