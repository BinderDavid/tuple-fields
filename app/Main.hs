module Main where

import Data.List (intersperse)
import System.FilePath ((</>))

-- | The maximum tuple size supported by GHC.
max_tuple :: Int
max_tuple = 62

source_path :: FilePath
source_path = "src" </> "Data" </> "Tuple" </> "Fields.hs"

header :: String
header =
    unlines [ "{-# LANGUAGE DataKinds #-}"
            , "{-# OPTIONS_GHC -Wno-orphans #-}"
            , "{-# LANGUAGE InstanceSigs #-}"
            , "module Data.Tuple.Fields () where"
            , ""
            , "import Data.Tuple"
            , "import GHC.Records ( HasField(..) )"
            ]

solo_instance :: String
solo_instance =
    unlines [ "instance HasField \"_1\" (Solo a) a where"
            , "  getField (Solo x) = x"
            ]

tuple_instance :: Int -> String
tuple_instance n = unlines [tuple_instance_field n m | m <- [1..n]]

-- | var_name 5 = "a5"
var_name :: Int -> String
var_name n = "a" <> show n

-- | field_name 5 = "_5"
field_name :: Int -> String
field_name n = "\"_" <> show n <> "\""

-- | tuple_name 5 = "(a1, a2, a3, a4, a5)"
tuple_name :: Int -> String
tuple_name n = "(" <> concat (intersperse "," [var_name x | x <- [1..n]])  <> ")"

-- | tuple_pattern 3 2 =  "(_,x,_)"
tuple_pattern :: Int -> Int -> String
tuple_pattern n m = "(" <> concat (intersperse "," [if x == m then "x" else "_" | x <- [1..n]]) <> ")"
 
tuple_instance_field :: Int -> Int -> String
tuple_instance_field n m =
    unlines [ "instance HasField " <> field_name m <> " " <> tuple_name n <> " " <> var_name m <> " where"
            , "  getField " <> tuple_pattern n m <> " = x"
            ] 

source_file :: String
source_file = unlines ([header, solo_instance] <>  [tuple_instance n | n <- [2..max_tuple]])

main :: IO ()
main = writeFile source_path source_file