# Rust Language

In Rust, polymorphics generics often called parametric polymorphism allow you to write code that works with multiple types while maintaining full type safety and performance. Rust implements this via a process called monomorphization. It generates a concrete version for each specific type. Type parameters are usually denoted by single letters inside angle brackets. The type parameters should accept trait bounds to limit it. Because the compiler knows the exact type at compile time, it can statically dispatch function calls.


