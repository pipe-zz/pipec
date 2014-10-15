<integral_types>: @@

; maybe should be named signed_8bit_integer for full verbosity
int8: {
	```llvm-ir
	`#` = i8 0
	```
	min: -127
	max: 128
	
	+(self, num: int8): ret @ {
		ret: int8
		```llvm-ir
		`ret` = add i8 `self`, `num`
		```
	}
	
	+=(self, num: int8): ret @ {
		```
		`self` = add i8 `self`, `num`
		```
		ret: self
	}
	
	-(num: int8): ret @ {
		ret: int8
		```llvm-ir
		`ret` = sub i8 `name`, `num`
		```
	}
	
	-=(self, num: int8): ret @ {
		```llvm-ir
		`self` = sub i8 `self`, `num`
		```
		ret: self
	}
}

uint8: {
	
	min: 0
	max: 255
}

int16: {
	
	min: -32767
	max: 32768
}

uint16: {
	
	min: 0
	max: 65535
}

int32: {
	
	min: -2147483647
	max: 2147483648
}

uint32: {
	
	min: 0
	max: 4294967295
}

int64: {
	
	min: -9223372036854775808
	max: 9223372036854775807
}

uint64: {
	
	min: 0
	max: 18446744073709551616
}
