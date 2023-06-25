//
//  SubviewRupp.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 27.11.22.
//

import SwiftUI

struct SubviewRupp: View {
    enum priorityOptions: String, CaseIterable, Identifiable {
        case shall = "shall"
        case should = "should"
        case will = "will"

        var id: Self { self }
    }

    enum verbOptions: String, CaseIterable, Identifiable {
        case process = "<process verb>"
        case provide = "provide <whom>"
        case able = "be able to"

        var id: Self { self }
    }

    @Binding var requirement: String
    @Binding var project: Project
    @Binding var systemName: String

    @State private var prioritySelected: priorityOptions = .shall
    @State private var verbSelected: verbOptions = .process

    @State private var object = ""
    @State private var processVerb = ""
    @State private var details = ""

    var body: some View {
        VStack (alignment: .leading) {
            RoundedVStack {
                TextField("The System", text: $systemName)
                    .textInputAutocapitalization(.never)
                    .padding()
            }

            RoundedVStack {
                Picker("Priority", selection: $prioritySelected) {
                    ForEach(priorityOptions.allCases) { priority in
                        Text(priority.rawValue)
                    }
                }
                .padding(.all, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .tint(.black)
            }

            RoundedVStack {
                Picker("Verb", selection: $verbSelected) {
                    ForEach(verbOptions.allCases) { verb in
                        Text(verb.rawValue)
                    }
                }
                .padding(.all, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .tint(.black)
            }

            if (verbSelected == .provide) {
                RoundedVStack {
                    TextField("<whom>", text: $object)
                        .textInputAutocapitalization(.never)
                        .padding()
                }

                RoundedVStack {
                    Text("with the ability to")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            } else {
                RoundedVStack {
                    TextField("<process verb>", text: $processVerb)
                        .textInputAutocapitalization(.never)
                        .padding()
                }
            }

            RoundedVStack {
                TextField("<details>", text: $details)
                    .textInputAutocapitalization(.never)
                    .padding()
            }

            Spacer()

            Text("Preview:")
            RoundedVStack {
                Text(
                    buildRequirement(prioritySelected: prioritySelected.rawValue,
                                     verbSelected: verbSelected.rawValue,
                                     object: object,
                                     processVerb: processVerb)
                )
                .padding()
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onChange(of: project) { newProject in
            systemName = newProject.projectName
        }
    }

    private func buildRequirement(prioritySelected: String, verbSelected: String, object: String, processVerb: String) -> String {
        var requirement: String = ""

        requirement = (systemName.isEmpty ? "The System" : systemName) + " " + prioritySelected + " "

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
}

struct SubviewRupp_Previews: PreviewProvider {
    static var previews: some View {
        SubviewRupp(
            requirement: .constant(""),
            project: .constant(.empty),
            systemName: .constant("")
        )
    }
}
