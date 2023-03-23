{-# LANGUAGE OverloadedRecordDot #-}
module Main (main) where

import Test.Tasty
import Test.Tasty.HUnit
import Data.Tuple
import Data.Tuple.Fields ()

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Unit tests" [test1, test2, test3]

test1 :: TestTree
test1 = testCase "First element of 2-tuple" $ ((True,False)._1 == True) @? "Fail"

test2 :: TestTree
test2 = testCase "Second element of 2-tuple" $ ((True,False)._2 == False) @? "Fail"

test3 :: TestTree
test3 = testCase "Projecting on Solo" $ ((Solo True)._1 == True) @? "Fail"