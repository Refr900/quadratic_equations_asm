#include <stdio.h>
#include <math.h>

void solve(double a, double b, double c)
{
    printf("| %.7gx^2 + %.7gx + %.7g = 0\n", a, b, c);
    printf("");
    double discriminant = b * b - 4 * a * c;
    printf("| D = %.7g", discriminant);
    if (discriminant > 0)
    {
        double d_sqrt = sqrt(discriminant);
        printf(" = %.7g^2\n", d_sqrt);
        double x1 = (-b + d_sqrt) / (2 * a);
        double x2 = (-b - d_sqrt) / (2 * a);
        printf("| x1 = %.7g\n", x1);
        printf("| x2 = %.7g\n", x2);
        return;
    }

    printf("\n");
    if (discriminant == 0.0)
    {
        double x1 = -b / (2 * a);
        printf("| x = %.7g\n", x1);
    }
    else
    {
        printf("| No real roots :(\n");
    }
}

double input(char *str)
{
    double coefficient = 0;
    do
    {
        printf("> ");
        printf(str);
        printf(": ");
        scanf("%lf", &coefficient);
        if (coefficient != 0.0)
        {
            break;
        }
        printf("error: Coefficient can't be zero! (for now, oopsie :#)\n");
    } while (1);
    return coefficient;
}

int main()
{
    printf("| ax^2 + bx + c = 0\n");
    double a = input("a");
    double b = input("b");
    double c = input("c");
    solve(a, b, c);
    return 0;
}
