# purescript-safe-printf

[![Build Status](https://travis-ci.org/kcsongor/purescript-safe-printf.svg?branch=master)](https://travis-ci.org/kcsongor/purescript-safe-printf)

A bare-bones proof of concept implementation of a typesafe printf-like interface
where the format string is provided as a type-level string.

This library uses the 0.13.5 version of the compiler.

## Example

```purescript
format (SProxy :: SProxy "Hi %s! Yo%cr favourite number is %d") "Bill" 'u' 16
```

produces the string

```
"Hi Bill! Your favourite number is 16"
```

A function of the "right type" is generated from the format string, so that

```
:t format (SProxy :: SProxy "Hi %s! Yo%cr favourite number is %d")
```

gives
```
String -> Char -> Int -> String
```

You can also choose to use wildcards if you don't want to repeat yourself:

```purs
  let formatted = format (SProxy :: _ "Hi %s! You are %d") "Bill" 12
```


## TODO
Currently only "%c", "%d" and "%s" are supported, without any other fancy formatting.
