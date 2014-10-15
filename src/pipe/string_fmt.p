*: @ <string>

fmt_char[u8char]<fmtT> := fmtT

fmt_char['f'] := float
fmt_char['d'] := double
fmt_char['s'] := string
fmt_char['i'] := int32
fmt_char['u'] := uint32

%(fmt: u8string, ...vars: *): str @ {
  str: u8string

  varIndex := 0

  u8char: c, i:=0, str.length > i ? i++ {
    c = fmt[i]
    c == '%' ? {
      i++
      c = fmt[i]
      c == '%' ? {
        str += '%'
      } ? {

        fmtT := fmt_char[c]
        str += to_u8string(fmtT{vars[varIndex]})

        varIndex += fmtT#size

      }
    } ? {
      str += c
    }
  }

  @@str
}
