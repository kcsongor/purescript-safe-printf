module Test.Main where

import Prelude

import Data.Printf (format)
import Effect (Effect)
import Test.Assert (assert)
import Type.Prelude (SProxy(..))

main :: Effect Unit
main = do
  let formatted = format (SProxy :: SProxy "Hi %s! You are %d%c") "Bill" 12 '.'
  assert $ formatted == "Hi Bill! You are 12."
