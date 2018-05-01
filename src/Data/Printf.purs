module Data.Printf where

import Prelude (identity, (<>), show)
import Type.Prelude (class IsSymbol, SProxy(..), reflectSymbol)
import Prim.Symbol as Symbol

class Format (string :: Symbol) fun | string -> fun where
  format :: SProxy string -> fun

instance formatFFormat ::
  ( Parse string format
  , FormatF format fun
  ) => Format string fun where
  format _ = formatF (FProxy :: FProxy format) ""

class FormatF (format :: FList) fun | format -> fun where
  formatF :: FProxy format -> String -> fun

instance formatFNil :: FormatF FNil String where
  formatF _ = identity

instance formatFConsD ::
  FormatF rest fun
  => FormatF (FCons D rest) (Int -> fun) where
  formatF _ str
    = \i -> formatF (FProxy :: FProxy rest) (str <> show i)

instance formatFConsS ::
  FormatF rest fun
  => FormatF (FCons S rest) (String -> fun) where
  formatF _ str
    = \s -> formatF (FProxy :: FProxy rest) (str <> s)

instance formatFConsLit ::
  ( IsSymbol lit
  , FormatF rest fun
  ) => FormatF (FCons (Lit lit) rest) fun where
  formatF _ str
    = formatF (FProxy :: FProxy rest) (str <> reflectSymbol (SProxy :: SProxy lit))

--------------------------------------------------------------------------------
class Parse (string :: Symbol) (format :: FList) | string -> format

foreign import kind FList
foreign import data FNil :: FList
foreign import data FCons :: Specifier -> FList -> FList

data FProxy (f :: FList) = FProxy

instance aNilParse :: Parse "" (FCons (Lit "") FNil)
else instance bConsParse :: (Symbol.Cons h t string, Match h t fl) => Parse string fl

class Match (head :: Symbol) (tail :: Symbol) (out :: FList) | head tail -> out

instance aMatchFmt :: Match a "" (FCons (Lit a) FNil)
else instance bMatchFmt ::
  ( Symbol.Cons h t s
  , MatchFmt h spec
  , Parse t rest
  ) => Match "%" s (FCons (Lit "") (FCons spec rest))
else instance cMatchFmt ::
  ( Parse s (FCons (Lit acc) r)
  , Symbol.Cons o acc rest
  ) => Match o s (FCons (Lit rest) r)

class MatchFmt (head :: Symbol) (out :: Specifier) | head -> out
instance matchFmtD :: MatchFmt "d" D
instance matchFmtS :: MatchFmt "s" S

-- TODO: add more of these...
foreign import kind Specifier
foreign import data D :: Specifier
foreign import data S :: Specifier
foreign import data Lit :: Symbol -> Specifier
