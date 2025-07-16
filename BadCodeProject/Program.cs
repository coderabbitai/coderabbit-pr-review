using System;
using System.Collections.Generic;
using System.Linq;

namespace BadCodeProject
{
    public class Program
    {
        public static void Main(string[] args)
        {
            // Unused variable
            int unusedVariable = 42;

            // Redundant type specification
            List<string> strings = new List<string>();

            // Possible null reference
            string? nullableString = null;
            Console.WriteLine(nullableString.Length);

            // Inconsistent naming
            int my_variable = 10;
            int myVariable = 20;

            // Unused parameter
            void UnusedParameter(int unusedParam)
            {
                Console.WriteLine("Hello");
            }

            // Redundant parentheses
            int result = (1 + (2 * 3));

            // Magic number
            if (result > 7)
            {
                Console.WriteLine("Too high");
            }

            // Inconsistent string literal
            Console.WriteLine("Hello" + " " + "World");

            // Unnecessary boxing
            object boxed = 42;

            // Redundant ToString() call
            string number = 42.ToString();

            // Unused method
            void UnusedMethod()
            {
                Console.WriteLine("Never called");
            }

            // Possible multiple enumeration
            var numbers = Enumerable.Range(1, 10);
            var sum = numbers.Sum();
            var count = numbers.Count();

            // Inconsistent access modifiers
            private int privateField = 0;
            public int publicField = 0;

            // Unnecessary cast
            object obj = "string";
            string str = (string)obj;

            // Redundant conditional
            bool condition = true;
            if (condition == true)
            {
                Console.WriteLine("Redundant");
            }
        }
    }
} 