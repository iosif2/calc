//
//  ContentView.swift
//  Shared
//
//  Created by iosif on 2022/05/10.
//

import SwiftUI

struct ContentView: View {
    enum FocusField: Hashable {
        case field
    }
    func updateOutput() {
        var out = ""
        for i in arr{
            if i is Int {
                out += String((i as? Int) ?? 0, radix: output_mode).uppercased()
            }
            if i is String {
                out += (i as? String) ?? ""
            }
            
        }
        self.output = out
    }
    
    func numAction(num: Int) {
        if self.arr.count == 0 {
            self.arr.append(num)
        } else {
            let last = self.arr.last
            if last is Int {
                var tmp = (last as? Int) ?? 0
                tmp = tmp &* output_mode &+ num
                if 0 < tmp{
                    self.arr[self.arr.endIndex - 1] = tmp
                }
            }
            else {
                self.arr.append(num)
            }
            
        }
        updateOutput()
    }
    
    func operAction(oper: String) {
        if oper == "=" {
            if arr.last is String {
                if ["/", "*"].contains(arr.last as? String) {
                    self.arr.append(1)
                }
                else {
                    self.arr.append(0)
                }
            }
            calcuate()
        } else {
            if self.arr.count == 0 {
                arr.append(0)
                self.arr.append(oper)
            } else if arr.last is Int {
                self.arr.append(oper)
            }
            updateOutput()
        }
        
    }
    func replaceWithResult(index:Int, result: Int) {
        arr.remove(at: index)
        arr.remove(at: index)
        arr.remove(at: index)
        arr.insert(result, at: index)
    }
    
    func calcuate() {
        var index = 0
        if arr.contains(where: {$0 as? String == "*"}) || arr.contains(where: {$0 as? String == "/"}) {
            while (index < arr.count) {
                if index + 2 > arr.count {
                    break
                }
                let l = (arr[index] as! Int)
                let r = (arr[index + 2] as! Int)
                let op = (arr[index + 1] as! String)
                if "* /".contains(op) {
                    if op == "*" {
                        replaceWithResult(index: index, result: l &* r)
                    } else if op == "/" {
                        replaceWithResult(index: index, result: l / r)
                    }
                } else {
                    index += 2
                }
                
            }
            index = 0
        }
        while (index < arr.count) {
            if index + 2 > arr.count {
                break
            }
            let l = (arr[index] as! Int)
            let r = (arr[index + 2] as! Int)
            let op = (arr[index + 1] as! String)
            if op == "+" {
                replaceWithResult(index: index, result: l &+ r)
            } else if op == "-" {
                replaceWithResult(index: index, result: l &- r)
            }
        }
        updateOutput()
    }

    @State var output = ""
    @State var editor = " "
    @State var arr: [Any] = []
    @State var output_mode = 10
    @FocusState private var focusedField: FocusField?
    var body: some View {
        Form{
            HStack{
                if output_mode == 16{
                    VStack{
                        Button("A",
                            action : {
                            self.numAction(num: 10)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        Button("B",
                            action : {
                            self.numAction(num: 11)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        Button("C",
                            action : {
                            self.numAction(num: 12)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        Button("D",
                            action : {
                            self.numAction(num: 13)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        Button("E",
                            action : {
                            self.numAction(num: 14)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        Button("F",
                            action : {
                            self.numAction(num: 15)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        
                    }
                }
                VStack{
                    Text(output)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .frame(width: 157.0, height: 100.0)
                    
                    HStack{
                        Button("C",
                            action : {
                            arr.removeAll()
                            updateOutput()
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        Button("b",
                            action : {
                            output_mode = 2
                            updateOutput()

                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        Button("d",
                            action : {
                            output_mode = 10
                            updateOutput()

                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        Button("h",
                            action : {
                            output_mode = 16
                            updateOutput()

                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: 25)
                        TextEditor(text: $editor)
                            .frame(width: 25, height: 15, alignment: .center)
                            .multilineTextAlignment(.center)
                            .colorMultiply(.green)
                            .focused($focusedField, equals: .field)
                                      .task {
                                        self.focusedField = .field
                                      }
                            
                            
                    }
                    
                    HStack{
                        Button("7",
                            action : {
                            self.numAction(num: 7)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .disabled(output_mode == 2)
                        Button("8",
                            action : {
                            self.numAction(num: 8)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .disabled(output_mode == 2)
                        Button("9",
                            action : {
                            self.numAction(num: 9)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .disabled(output_mode == 2)
                        Button("+",
                            action : {
                            operAction(oper: "+")
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        Button("-",
                            action : {
                            operAction(oper: "-")
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    }
                    HStack{
                        Button("4",
                            action : {
                            self.numAction(num: 4)
                        })
                        .frame(width: 25.0, height: 25.0)
                        .disabled(output_mode == 2)
                        Button("5",
                            action : {
                            self.numAction(num: 5)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .disabled(output_mode == 2)
                        Button("6",
                            action : {
                            self.numAction(num: 6)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .disabled(output_mode == 2)
                        Button("*",
                            action : {
                            operAction(oper: "*")
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        Button("/",
                            action : {
                            operAction(oper: "/")
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        
                        
                    }
                    HStack{
                        Button("1",
                            action : {
                            self.numAction(num: 1)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        Button("2",
                            action : {
                            self.numAction(num: 2)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .disabled(output_mode == 2)
                        Button("3",
                            action : {
                            self.numAction(num: 3)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .disabled(output_mode == 2)
                        Button("0",
                            action : {
                            self.numAction(num: 0)
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        Button("=",
                            action : {
                            operAction(oper: "=")
                        })
                        .frame(width: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    }
                }
                
            }
        }
        .padding()
        .onChange(of: editor, perform: { string in
            let last = string.last
            if last == nil {
                return
            }
            editor.removeLast()
            if last == "\n"{
                calcuate()
            } else if last == "c" {
                arr.removeAll()
                updateOutput()
            } else if last!.isNumber {
                if (output_mode == 2 && last!.wholeNumberValue! < 2) || output_mode != 2{
                    numAction(num: last!.wholeNumberValue!)
                }
            } else if "+-/*=".contains(last!) {
                operAction(oper: String(last!))
            } else if "ABCDEF".contains(last!) {
                if(output_mode == 16) {numAction(num: Int(last!.asciiValue! - 65 + 10))}
            } else if "b".contains(last!) {
                output_mode = 2
                updateOutput()
            } else if "d".contains(last!) {
                output_mode = 10
                updateOutput()
            } else if "h".contains(last!) {
                output_mode = 16
                updateOutput()
            }
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
