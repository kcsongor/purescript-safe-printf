# purescript-safe-printf

A bare-bones proof of concept implementation of a typesafe printf-like interface
where the format string is provided as a type-level string.

This package uses a modified version of the compiler (and the typelevel-prelude
package) that supports ` class ConsSymbol (head :: Symbol) (tail :: Symbol) (sym :: Symbol) | sym -> head tail, head tail -> sym ` - breaking a type-level string to its head and tail.

It also relies on overlapping instances being chosen in alphabetical order.

## Example

```purescript
format (SProxy :: SProxy "Hi %s! Your favourite number is %d") "Bill" 16
```

produces the string

```
"Hi Bill! Your favourite number is 16"
```

A function of the "right type" is generated from the format string, so that

```
:t format (SProxy :: SProxy "Hi %s! Your favourite number is %d")
```

gives
```
String -> Int -> String
```

## TODO
Currently only "%d" and "%s" are supported, without any other fancy formatting.
