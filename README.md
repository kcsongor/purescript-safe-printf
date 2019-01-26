# purescript-safe-printf

[![Build Status](https://travis-ci.org/kcsongor/purescript-safe-printf.svg?branch=master)](https://travis-ci.org/kcsongor/purescript-safe-printf)

A bare-bones proof of concept implementation of a typesafe printf-like interface
where the format string is provided as a type-level string.

This library uses the 0.12 version of the compiler.

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
