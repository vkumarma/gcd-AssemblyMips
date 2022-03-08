# gcd-AssemblyMips

In this lab, you must convert a C program (provided as boilerplate code) to an equivalent MIPS program in a faithful manner. In other words, if the C code calls a function, your code must also call a function. If the C code prints a string from memory, your program must print a string from memory. If the C code has an array with 100 elements in it to save the result, your code must have an array with 100 elements in it. And so on... (A few exceptions to this general rule are permitted. For example, we don't have a way to do #ifndef/#define statements in assembly, nor do we need to create header files)

Requirements:
Your MIPS program must faithfully follow the algorithm and organization of the C program
Your MIPS program must produce character-for-character identical output as the C program
Your MIPS program must use the procedure call convention described below
**Each line** of assembly code must be documented with a comment!
Each region of assembly code must clearly have a **comment block** documenting the overall purpose of that region, along with what values each register holds. You can use your own judgement for a reasonable region size.
