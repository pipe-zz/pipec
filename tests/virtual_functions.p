; Pipe Lang virtual function

my_class: {

  func(): @@

  #v_func: (my_class*: self) { ... }

}

my_derived_class: my_class.{
  callBaseVirtualFuncs: bool

  #v_func = (my_derived_class*: self) { ... }
}

my_class.func(self): @ {
  self#v_func(self)
}

my_class#v_func: (my_class: self) @@ self.{
  print("calling my_class.func")
}

my_derived_class#v_func = (my_derived_class*: self) @@ self.{
  callBaseFuncs ? {
    my_class#v_func(self)
  }

  print("calling my_derived_class.func")
}

c: my_derived_class
c.callBaseVirtualFuncs = true
c.func()
c.callBaseVirtualFuncs = false
c.func()
