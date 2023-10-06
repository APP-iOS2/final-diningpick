//
//  ButtonUpdate.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct CustomizedButtonStyle : PrimitiveButtonStyle {

var disabled: Bool = false

func makeBody(configuration: Self.Configuration) -> some View {
configuration.label.disabled(disabled)
   .overlay(
       RoundedRectangle(cornerRadius: 4).stroke(disabled ? Color.blue :  Color.gray, lineWidth: 1).padding(8)
   )
}
}


struct ButtonUpdate: View {
var body: some View {
   VStack{
   Button(action: {
   }) { Text("button")
   }.buttonStyle(CustomizedButtonStyle(disabled: true))
   Button(action: {
   }) { Text("button")
   }.buttonStyle(CustomizedButtonStyle(disabled: false))
   }}

 }

#Preview {
    ButtonUpdate()
}
