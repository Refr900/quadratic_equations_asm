# Quadratic equations

Trying to write a function to solve simple quadratic equations in NASM for win64 ***for learning purposes***.

# Build

```
nasm -f win64 src\main.asm -o main.o
gcc main.o -o main.exe
main
```

# Examples

```
| ax^2 + bx + c = 0
> a: 4
> b: 8
> c: -12
| 4x^2 + 8x + -12 = 0
| D = 256 = 16^2
| x1 = 1
| x2 = -3
```

```
| ax^2 + bx + c = 0
> a: 2 
> b: 4
> c: 2
| 2x^2 + 4x + 2 = 0
| D = 0
| x = -1
```

```
| ax^2 + bx + c = 0
> a: 10
> b: 1
> c: 6
| 10x^2 + 1x + 6 = 0
| D = -239
| No real roots :(
```